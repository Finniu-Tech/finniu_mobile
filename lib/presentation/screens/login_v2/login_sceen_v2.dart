import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/login_v2/helpers/login_helper.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
            fontWeight: FontWeight.w500,
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
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FormLogin(),
      ],
    );
  }
}

class FormLogin extends HookConsumerWidget {
  FormLogin({
    super.key,
  });

  final secureStorage = const FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    final rememberPassword = useState(Preferences.rememberMe);
    final passwordState = useState("");

    final emailController =
        useTextEditingController(text: Preferences.username ?? "");
    final passwordController =
        useTextEditingController(text: passwordState.value);
    final ValueNotifier<bool> emailError = useState(false);
    final ValueNotifier<bool> passwordError = useState(false);

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
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": "/v2/login_email",
            "error": "input_form",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Error de inicio de sesión",
          message: "Por favor, revise sus datos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (emailError.value) {
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.pushDataError,
            parameters: {
              "screen": "/v2/login_email",
              "error": "input_email",
            },
          );
          return;
        }
        if (passwordError.value) {
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.pushDataError,
            parameters: {
              "screen": "/v2/login_email",
              "error": "input_password",
            },
          );
          return;
        }
        context.loaderOverlay.show();

        loginEmailHelper(
          context: context,
          ref: ref,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rememberPassword: rememberPassword.value,
          secureStorage: secureStorage,
        );
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
              CheckBoxWidget(
                value: rememberPassword.value,
                onChanged: (value) {
                  rememberPassword.value = value ?? false;
                  Preferences.rememberMe = value ?? false;
                  if (!rememberPassword.value) {
                    passwordController.clear();
                  }
                },
              ),
              const TextPoppins(
                text: 'Recordarme para mis futuros ingresos',
                fontSize: 12,
                lines: 2,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ButtonInvestment(text: "Ingresar", onPressed: () => loginEmail()),
          const SizedBox(height: 15),
          const TextPoppins(
            text: "¿Aún no tienes una cuenta creada?,",
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: () => {
              ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                eventName: FirebaseAnalyticsEvents.navigateTo,
                parameters: {
                  "screen": "/v2/login_email",
                  "navigateTo": '/v2/register',
                },
              ),
              Navigator.pushNamed(context, '/v2/register'),
            },
            child: const TextPoppins(
              text: "Registrarme",
              fontSize: 13,
              fontWeight: FontWeight.w500,
              textDark: titleDark,
              textLight: titleLight,
            ),
          ),
        ],
      ),
    );
  }
}
