import 'package:finniu/constants/colors.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/models/auth.dart';
import 'package:finniu/models/user.dart';
import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/home/home.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:email_validator/email_validator.dart';

class EmailLoginScreen extends HookConsumerWidget {
  EmailLoginScreen({super.key});
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHidden = useState(true);
    final showError = useState(false);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final formKey = GlobalKey<FormState>();

    // final result = readRespositoriesResult.result;

    // if (result.hasException) {
    //     return Text(result.exception.toString());
    // }

    // if (result.isLoading) {
    //   return const Text('Loading');
    // }

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
                width: 224,
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
                          onChanged: (value) {
                            _email = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Escriba su correo electrónico',
                            label: Text(
                              "Correo electrónico",
                            ),
                          ),
                          controller: TextEditingController(text: _email),
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
                        child: TextFormField(
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese algún valor';
                            }
                            return null;
                          },
                          obscureText:
                              isHidden.value, // esto oculta la contrasenia
                          obscuringCharacter:
                              '*', //el caracter el cual reemplaza la contrasenia
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints(
                              maxHeight: 38,
                              minWidth: 38,
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 20,
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 23.20,
                              ),
                              alignment: Alignment.center,
                              onPressed: () {
                                isHidden.value = !isHidden.value;
                              },
                            ),
                            label: const Text(
                              "Contraseña",
                            ),
                          ),
                          controller: TextEditingController(text: _password),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_forgot');
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextPoppins(
                            text: '¿Olvidaste tu contraseña?',
                            colorText: themeProvider.isDarkMode
                                ? whiteText
                                : blackText,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home_home');
                            if (formKey.currentState!.validate()) {
                              context.loaderOverlay.show();
                              final token = ref.watch(
                                authTokenMutationProvider(
                                  LoginModel(
                                      email: _email, password: _password),
                                ),
                              );
                              token.when(
                                data: (token) {
                                  print('data: $token');
                                  context.loaderOverlay.hide();
                                  ref.read(authTokenProvider.notifier).state =
                                      token!;
                                  Navigator.pushNamed(context, '/home_home');
                                },
                                error: (err, stack) {
                                  print('error: $err');
                                  context.loaderOverlay.hide();
                                  showError.value = true;
                                },
                                loading: () {
                                  print('loading');
                                  const CircularProgressIndicator();
                                },
                              );
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
