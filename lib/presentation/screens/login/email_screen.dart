// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email_validator/email_validator.dart';
import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/domain/entities/routes_entity.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/network_warning.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/infrastructure/repositories/auth_repository_imp.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';

class EmailLoginScreen extends HookConsumerWidget {
  EmailLoginScreen({super.key});

  final secureStorage = const FlutterSecureStorage();
  final passwordController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: Preferences.username ?? "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showError = useState(false);
    final graphqlProvider = ref.watch(gqlClientProvider.future);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final formKey = GlobalKey<FormState>();
    final rememberPassword = useState(Preferences.rememberMe);

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 224,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    themeProvider.isDarkMode
                        ? "assets/images/logo_finniu_dark.png"
                        : "assets/images/logo_finniu_light.png",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextPoppins(
                  text: '¡Bienvenido a Finniu!',
                  colorText:
                      themeProvider.isDarkMode ? skyBlueText : primaryDark,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextPoppins(
                          text: 'Ingresa a tu cuenta',
                          colorText:
                              themeProvider.isDarkMode ? whiteText : blackText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 224,
                        // height: 38,
                        child: TextFormField(
                          autocorrect: false,
                          onChanged: (value) {
                            // Actualiza _email y el textvalue.toLowerCase();
                            _emailController.text = value.trim().toLowerCase();
                            // Mueve el cursor al final del texto
                            _emailController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset: _emailController.text.length,
                              ),
                            );
                          },
                          decoration: const InputDecoration(
                            hintText: 'Escriba su correo electrónico',
                            label: Text(
                              "Correo electrónico",
                            ),
                          ),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese un correo';
                            }
                            if (EmailValidator.validate(value, true) == false) {
                              return 'Ingrese un correo válido';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 29),
                      SizedBox(
                        width: 224,
                        // height: 38,
                        child: PasswordField(
                          passwordController: passwordController,
                          secureStorage: secureStorage,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login_forgot');
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: TextPoppins(
                                text: 'Olvidé mi contraseña',
                                colorText: themeProvider.isDarkMode
                                    ? skyBlueText
                                    : primaryDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (showError.value) ...[
                        const Text(
                          'No se pudo validar sus credenciales',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                          ),
                        ),
                      ],
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 224,
                        height: 50,
                        child: TextButton(
                          child: const Text('Ingresar'),
                          // onPressed: () {
                          //   Navigator.pushNamed(context, '/investment_step2');
                          // },

                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context.loaderOverlay.show();
                              try {
                                bool isConnected =
                                    await InternetConnectionChecker()
                                        .hasConnection;
                                if (!isConnected) {
                                  context.loaderOverlay.hide();
                                  showNetworkWarning(context: context);
                                  return;
                                }

                                final loginResponse = AuthRepository().login(
                                  client: await graphqlProvider,
                                  username:
                                      _emailController.value.text.toLowerCase(),
                                  password: passwordController.value.text,
                                );
                                loginResponse.then((value) {
                                  if (value.success == true) {
                                    final token = ref.watch(
                                      authTokenMutationProvider(
                                        LoginModel(
                                          email: _emailController.value.text
                                              .toLowerCase(),
                                          password:
                                              passwordController.value.text,
                                        ),
                                      ).future,
                                    );
                                    token.then(
                                      (value) async {
                                        if (value != null) {
                                          ref
                                              .read(authTokenProvider.notifier)
                                              .state = value;
                                          Preferences.username =
                                              _emailController.value.text
                                                  .toLowerCase();
                                          context.loaderOverlay.hide();
                                          if (rememberPassword.value) {
                                            await secureStorage.write(
                                              key: 'password',
                                              value:
                                                  passwordController.value.text,
                                            );
                                          }

                                          final featureFlags = await ref.read(
                                            userFeatureFlagListFutureProvider
                                                .future,
                                          );
                                          ref
                                              .read(
                                                featureFlagsProvider.notifier,
                                              )
                                              .setFeatureFlags(featureFlags);

                                          final String route = ref
                                                  .watch(
                                                    featureFlagsProvider
                                                        .notifier,
                                                  )
                                                  .isEnabled(
                                                    FeatureFlags.homeV2,
                                                  )
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
                                    if (value.error ==
                                        'Su usuario no a sido activado') {
                                      showSnackBarV2(
                                        context: context,
                                        title: "Error al iniciar sesión",
                                        message: value.error ??
                                            'Su usuario no a sido activado',
                                        snackType: SnackType.error,
                                      );

                                      ref
                                          .read(
                                            userProfileNotifierProvider
                                                .notifier,
                                          )
                                          .updateFields(
                                            email: _emailController.value.text,
                                            password:
                                                passwordController.value.text,
                                          );
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        Navigator.pushNamed(
                                          context,
                                          '/send_code',
                                        );
                                      });
                                    } else {
                                      showSnackBarV2(
                                        context: context,
                                        title: "Error al iniciar sesión",
                                        message: value.error ??
                                            'No se pudo validar sus credenciales',
                                        snackType: SnackType.error,
                                      );
                                    }
                                  }
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                showSnackBarV2(
                                  context: context,
                                  title: "Error al iniciar sesión",
                                  message:
                                      'Ocurrió un problema, vuelva a intentarlo en unos minutos',
                                  snackType: SnackType.error,
                                );
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextPoppins(
                          text: '¿Aún no tienes una cuenta creada?',
                          colorText:
                              themeProvider.isDarkMode ? whiteText : blackText,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/sign_up_email');
                        },
                        child: Center(
                          child: TextPoppins(
                            text: 'Registrarme',
                            colorText: themeProvider.isDarkMode
                                ? skyBlueText
                                : primaryDark,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  final FlutterSecureStorage secureStorage;
  final sharedPreferences = Preferences();
  // add passwordController and secureStorage parameter as required
  // const PasswordField({
  //   passwordController,
  //   secureStorage
  // })

  PasswordField({
    super.key,
    required this.passwordController,
    required this.secureStorage,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool rememberPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _password = await widget.secureStorage.read(key: 'password');
      if (_password != null && _password.isNotEmpty && Preferences.rememberMe) {
        widget.passwordController.text = _password;
        setState(() {
          rememberPassword = Preferences.rememberMe;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autocorrect: false,
          controller: widget.passwordController,
          obscureText: _obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              // validation logic
            }
            return null;
          },
          decoration: InputDecoration(
            label: const Text(
              "Contraseña",
            ),
            hintText: 'Escriba su contraseña',
            constraints: const BoxConstraints(
              maxHeight: 38,
            ),
            suffixIcon: rememberPassword
                ? null
                : IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: rememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  rememberPassword = value!;
                  Preferences.rememberMe = value;
                  if (!rememberPassword) {
                    widget.passwordController.clear();
                  }
                });
              },
            ),
            const Text('Recordarme'),
          ],
        ),
      ],
    );
  }
}
