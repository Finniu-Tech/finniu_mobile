import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/recovery_password_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/modal_send_code_v2.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordV2 extends HookConsumerWidget {
  const ForgotPasswordV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final emailController = useTextEditingController();
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                height: 130,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 50,
                            right: 30,
                            top: 15,
                            bottom: 15,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(gradient_secondary),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 130,
                          width: 267,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.5,
                              ),
                              "Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña.",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 250,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 90,
                          width: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/forgotpassword/padlock.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 224,
                height: 38,
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu correo electrónico',
                    labelText: "Correo electrónico",
                  ),
                  // textHint: 'Escribe tu correo electrónico',
                  // textLabel: "Correo electrónico",
                ),
              ),
              const SizedBox(height: 25),
              Container(
                height: 50,
                width: 224,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(primaryDark),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      final status = await ref.watch(
                        recoveryPasswordFutureProvider(emailController.text)
                            .future,
                      );
                      if (status == true) {
                        ref
                            .read(userProfileNotifierProvider.notifier)
                            .setEmail(emailController.text);
                        sendEmailRecoveryPasswordModalV2(context, ref);
                      } else {
                        showSnackBarV2(
                          context: context,
                          title: "Error al enviar correo",
                          message: 'El correo ingresado no existe',
                          snackType: SnackType.error,
                        );
                      }
                    },
                    child: const Text('Enviar correo'),
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

class NewPasswordV2 extends HookConsumerWidget {
  const NewPasswordV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final passwordController = useTextEditingController();
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    final isHidden = useState(true);
    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/forgotpassword/padlock.png',
                    width: 67,
                    height: 75,
                  ),
                ),
              ),
              TextPoppins(
                text: 'Cambiar tu contraseña',
                colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              TextPoppins(
                text: 'Ingresa tu nueva contraseña',
                colorText: themeProvider.isDarkMode ? (whiteText) : (blackText),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 224,
                height: 38,
                child: TextFormField(
                  // onChanged: (value) {
                  //   _password = value;
                  // },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese algún valor';
                    }
                    return null;
                  },
                  obscureText: isHidden.value, // esto oculta la contrasenia
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
                  controller: passwordController,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                height: 50,
                width: 224,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(primaryDark),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      final status = await ref.read(
                        setNewPasswordFutureProvider(passwordController.text)
                            .future,
                      );
                      if (status == true) {
                        ref
                            .read(userProfileNotifierProvider.notifier)
                            .setPassword(passwordController.text);
                        const SnackBar(
                          content: Text('Contraseña cambiada con éxito'),
                        );
                        showSnackBarV2(
                          context: context,
                          title: "Contraseña cambiada con ≠!",
                          message: 'Contraseña cambiada con éxito!',
                          snackType: SnackType.success,
                        );

                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pushNamed(context, '/v2/login_email');
                      } else {
                        showSnackBarV2(
                          context: context,
                          title: "Error al cambiar la contraseña",
                          message: 'No se pudo cambiar la contraseña',
                          snackType: SnackType.error,
                        );
                      }
                    },
                    child: const Text('Cambiar contraseña'),
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
