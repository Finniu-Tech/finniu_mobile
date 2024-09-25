import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/domain/entities/routes_entity.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/infrastructure/repositories/auth_repository_imp.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/network_warning.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreenV2 extends ConsumerWidget {
  const LoginScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return ScaffoldUserProfile(
      appBar: null,
      children: [
        Image.asset(
          "assets/images/logo_finniu_${isDarkMode ? "dark" : "light"}.png",
        ),
        const Center(
          child: TextPoppins(
            text: "¡Bienvenido a Finniu!",
            fontSize: 24,
            isBold: true,
            textDark: titleDark,
            textLight: titleLight,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: TextPoppins(
            text: "Ingresa a tu cuenta",
            fontSize: 16,
            isBold: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const FormLogin(),
      ],
    );
  }
}

class FormLogin extends HookConsumerWidget {
  const FormLogin({
    super.key,
  });

  final secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    final rememberPassword = useState(Preferences.rememberMe);
    final showError = useState(false);
    final graphqlProvider = ref.watch(gqlClientProvider.future);
    final passwordState = useState("");
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController(text: Preferences.username ?? "");
    final passwordController = useTextEditingController(text: passwordState.value);
    final ValueNotifier<bool> emailError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> passwordError = ValueNotifier<bool>(false);

    useEffect(
      () {
        if (rememberPassword.value) {
          secureStorage.read(key: 'password').then(
            (pass) {
              if (pass != null) {
                passwordState.value = pass;
                passwordController.text = pass;
              }
            },
          );
        }

        return null;
      },
      [],
    );

    void loginEmail() async {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Error de inicio de sesión",
          message: "Por favor, revise sus datos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (emailError.value) return;
        if (passwordError.value) return;
        context.loaderOverlay.show();
        try {
          bool isConnected = await InternetConnectionChecker().hasConnection;
          if (!isConnected) {
            context.loaderOverlay.hide();
            showNetworkWarning(context: context);
            return;
          }

          final loginResponse = AuthRepository().login(
            client: await graphqlProvider,
            username: emailController.value.text.toLowerCase(),
            password: passwordController.value.text,
          );
          loginResponse.then((value) {
            if (value.success == true) {
              final token = ref.watch(
                authTokenMutationProvider(
                  LoginModel(
                    email: emailController.value.text.trim().toLowerCase(),
                    password: passwordController.value.text,
                  ),
                ).future,
              );

              token.then(
                (value) async {
                  if (value != null) {
                    showSnackBarV2(
                      context: context,
                      title: "Inicio de sesión exitoso",
                      message: "Bienvenido ${emailController.value.text}",
                      snackType: SnackType.success,
                    );
                    ref.read(authTokenProvider.notifier).state = value;
                    Preferences.username = emailController.value.text.trim().toLowerCase();
                    context.loaderOverlay.hide();
                    if (rememberPassword.value) {
                      await secureStorage.write(
                        key: 'password',
                        value: passwordController.value.text,
                      );
                    }

                    final featureFlags = await ref.read(userFeatureFlagListFutureProvider.future);
                    ref.read(featureFlagsProvider.notifier).setFeatureFlags(featureFlags);

                    final String route = ref.watch(featureFlagsProvider.notifier).isEnabled(FeatureFlags.homeV2)
                        ? FeatureRoutes.getRouteForFlag(
                            FeatureFlags.homeV2,
                            defaultHomeRoute,
                          )
                        : defaultHomeRoute;

                    Navigator.pushNamed(
                      context,
                      route,
                    );
                  } else {
                    showError.value = true;
                  }
                },
                onError: (err) {
                  context.loaderOverlay.hide();
                  showError.value = true;
                },
              );
            } else {
              context.loaderOverlay.hide();
              if (value.error == 'Su usuario no a sido activado') {
                showSnackBarV2(
                  context: context,
                  title: value.error ?? 'Su usuario no a sido activado',
                  message: "Por favor, revisa tu correo para activar tu cuenta",
                  snackType: SnackType.error,
                );

                ref.read(userProfileNotifierProvider.notifier).updateFields(
                      email: emailController.value.text,
                      password: passwordController.value.text,
                    );
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pushNamed(context, '/v2/send_code');
                });
              } else {
                showSnackBarV2(
                  context: context,
                  title: value.error ?? 'No se pudo validar sus credenciales',
                  message: "Por favor, revisa tus credenciales",
                  snackType: SnackType.error,
                );
              }
            }
          });
        } catch (e) {
          context.loaderOverlay.hide();
          showSnackBarV2(
            context: context,
            title: 'Error',
            message: 'Ocurrió un problema, vuelva a intentarlo en unos minutos',
            snackType: SnackType.error,
          );
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: emailError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                isError: isError,
                onError: () => emailError.value = false,
                hintText: "Correo electrónico",
                controller: emailController,
                validator: (value) {
                  validateEmail(
                    value: value,
                    context: context,
                    boolNotifier: emailError,
                  );
                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: passwordError,
            builder: (context, isError, child) {
              return InputPasswordFieldUserProfile(
                onFocusChanged: (p0) {},
                onTap: () {},
                isError: isError,
                onError: () => passwordError.value = false,
                controller: passwordController,
                hintText: "Contraseña",
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/v2/login_forgot'),
                child: const TextPoppins(
                  text: "¿Olvidaste tu contraseña?",
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: rememberPassword.value,
                onChanged: (bool? value) {
                  rememberPassword.value = value ?? false;
                  Preferences.rememberMe = value ?? false;
                  if (!rememberPassword.value) {
                    passwordController.clear();
                  }
                },
              ),
              const Text('Recordarme para mis futuros ingresos', style: TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          ButtonInvestment(text: "Ingresar", onPressed: () => loginEmail()),
          const SizedBox(height: 15),
          const TextPoppins(
            text: "¿Aún no tienes una cuenta creada?,",
            fontSize: 13,
            isBold: true,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/v2/register'),
            child: const TextPoppins(
              text: "Registrarme",
              fontSize: 13,
              isBold: true,
              textDark: titleDark,
              textLight: titleLight,
            ),
          ),
        ],
      ),
    );
  }
}
