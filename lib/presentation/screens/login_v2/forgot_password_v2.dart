// import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/recovery_password_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/modal_send_code_v2.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordV2 extends ConsumerWidget {
  const ForgotPasswordV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const String text =
        "Ingresa el correo electrónico que utilizaste al crear tu cuenta. Te enviaremos un código de validación para que puedas restablecer tu contraseña.";
    return ScaffoldUserProfile(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/forgot_password.png",
                width: 64,
                height: 64,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextPoppins(
                text: "¿Olvidaste tu contraseña?",
                fontSize: 25,
                isBold: true,
                textDark: titleDark,
                textLight: titleLight,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextPoppins(
                text: text,
                fontSize: 12,
                lines: 3,
                align: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const FormForgot(),
            ],
          ),
        ),
      ],
    );
  }
}

class FormForgot extends HookConsumerWidget {
  const FormForgot({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> emailError = ValueNotifier<bool>(false);
    final emailController = useTextEditingController();

    void seedEmail() async {
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
        final status = await ref.watch(
          recoveryPasswordFutureProvider(emailController.text).future,
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
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
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
            ButtonInvestment(
              text: "Enviar",
              onPressed: () => seedEmail(),
            ),
          ],
        ),
      ),
    );
  }
}

// class ForgotPasswordV2 extends HookConsumerWidget {
//   const ForgotPasswordV2({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     final emailController = useTextEditingController();
//     // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

//     return CustomScaffoldReturn(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: 80),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 320,
//                 height: 130,
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.center,
//                       child: Card(
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.only(
//                             left: 50,
//                             right: 30,
//                             top: 15,
//                             bottom: 15,
//                           ),
//                           decoration: BoxDecoration(
//                             color: const Color(gradient_secondary),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           height: 130,
//                           width: 267,
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.black,
//                                 height: 1.5,
//                               ),
//                               "Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña.",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 20,
//                       right: 250,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           height: 90,
//                           width: 80,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 "assets/forgotpassword/padlock.png",
//                               ),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 224,
//                 height: 38,
//                 child: TextFormField(
//                   controller: emailController,
//                   style: const TextStyle(fontSize: 12),
//                   onChanged: (value) {},
//                   decoration: const InputDecoration(
//                     hintText: 'Escribe tu correo electrónico',
//                     labelText: "Correo electrónico",
//                   ),
//                   // textHint: 'Escribe tu correo electrónico',
//                   // textLabel: "Correo electrónico",
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Container(
//                 height: 50,
//                 width: 224,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: const Color(primaryDark),
//                 ),
//                 child: Center(
//                   child: TextButton(
//                     onPressed: () async {
//                       final status = await ref.watch(
//                         recoveryPasswordFutureProvider(emailController.text)
//                             .future,
//                       );
//                       if (status == true) {
//                         ref
//                             .read(userProfileNotifierProvider.notifier)
//                             .setEmail(emailController.text);
//                         sendEmailRecoveryPasswordModalV2(context, ref);
//                       } else {
//                         showSnackBarV2(
//                           context: context,
//                           title: "Error al enviar correo",
//                           message: 'El correo ingresado no existe',
//                           snackType: SnackType.error,
//                         );
//                       }
//                     },
//                     child: const Text('Enviar correo'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
