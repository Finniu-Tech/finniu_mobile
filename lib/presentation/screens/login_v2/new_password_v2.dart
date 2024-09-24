import 'package:finniu/presentation/providers/recovery_password_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/v2_user_profile/widgets/password_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NewPasswordV2 extends ConsumerWidget {
  const NewPasswordV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const String text = "Ingresa tu nueva contraseña";

    return ScaffoldUserProfile(
      children: [
        Center(
          child: SizedBox(
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
                  text: text,
                  fontSize: 20,
                  isBold: true,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormNewPasword(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FormNewPasword extends HookConsumerWidget {
  const FormNewPasword({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    final ValueNotifier<bool> passwordError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> passwordConfirmError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isPasswordExpanded = ValueNotifier<bool>(false);
    final FocusNode focusNode = FocusNode();

    void savePassword() async {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (passwordError.value) return;
        if (passwordConfirmError.value) return;
        context.loaderOverlay.show();
        final status = await ref.read(
          setNewPasswordFutureProvider(passwordController.text).future,
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
          context.loaderOverlay.hide();
        } else {
          context.loaderOverlay.hide();
          showSnackBarV2(
            context: context,
            title: "Error al cambiar la contraseña",
            message: 'No se pudo cambiar la contraseña',
            snackType: SnackType.error,
          );
        }
      }
    }

    return Form(
      key: formKey,
      child: SizedBox(
        height: 350,
        child: Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: passwordError,
                  builder: (context, isError, child) {
                    return InputPasswordFieldUserProfile(
                      focusNode: focusNode,
                      onTap: () {
                        isPasswordExpanded.value = true;
                      },
                      isError: isError,
                      onError: () => passwordError.value = false,
                      controller: passwordController,
                      hintText: "Contraseña ",
                      validator: (value) {
                        validatePassword(
                          value: value,
                          context: context,
                          boolNotifier: passwordError,
                        );
                        return null;
                      },
                      onFocusChanged: (hasFocus) {
                        isPasswordExpanded.value = hasFocus;
                      },
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: passwordConfirmError,
                  builder: (context, isError, child) {
                    return InputPasswordFieldUserProfile(
                      onFocusChanged: (p0) {},
                      onTap: () {},
                      isError: isError,
                      onError: () => passwordConfirmError.value = false,
                      controller: passwordConfirmController,
                      hintText: "Confirmar contraseña",
                      validator: (value) {
                        validateConfirmPassword(
                          value: value,
                          context: context,
                          boolNotifier: passwordConfirmError,
                          password: passwordController.text.trim(),
                        );
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonInvestment(
                  text: "Aceptar",
                  onPressed: () => savePassword(),
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isPasswordExpanded,
              builder: (context, isError, child) {
                return isPasswordExpanded.value
                    ? PasswordNewRequired(
                        controller: passwordController,
                        isExpanded: isPasswordExpanded.value,
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordNewRequired extends HookConsumerWidget {
  const PasswordNewRequired({
    super.key,
    required this.controller,
    required this.isExpanded,
  });
  final bool isExpanded;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff222222;
    const int containerLight = 0xffF7F7F7;

    final ValueNotifier<bool> eightCharacters = ValueNotifier<bool>(false);
    final ValueNotifier<bool> oneNumber = ValueNotifier<bool>(false);
    final ValueNotifier<bool> oneLowercase = ValueNotifier<bool>(false);
    final ValueNotifier<bool> oneCapital = ValueNotifier<bool>(false);
    final ValueNotifier<bool> oneSpecialSymbol = ValueNotifier<bool>(false);

    final RegExp hasDigits = RegExp(r'[0-9]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    useEffect(
      () {
        controller.text.length >= 8
            ? eightCharacters.value = true
            : eightCharacters.value = false;
        hasDigits.hasMatch(controller.text)
            ? oneNumber.value = true
            : oneNumber.value = false;
        hasLowercase.hasMatch(controller.text)
            ? oneLowercase.value = true
            : oneLowercase.value = false;
        hasUppercase.hasMatch(controller.text)
            ? oneCapital.value = true
            : oneCapital.value = false;
        hasSpecialCharacters.hasMatch(controller.text)
            ? oneSpecialSymbol.value = true
            : oneSpecialSymbol.value = false;
        controller.addListener(() {
          controller.text.length >= 8
              ? eightCharacters.value = true
              : eightCharacters.value = false;
          hasDigits.hasMatch(controller.text)
              ? oneNumber.value = true
              : oneNumber.value = false;
          hasLowercase.hasMatch(controller.text)
              ? oneLowercase.value = true
              : oneLowercase.value = false;
          hasUppercase.hasMatch(controller.text)
              ? oneCapital.value = true
              : oneCapital.value = false;
          hasSpecialCharacters.hasMatch(controller.text)
              ? oneSpecialSymbol.value = true
              : oneSpecialSymbol.value = false;
        });
        return null;
      },
      [controller],
    );

    return Positioned(
      top: 120,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: eightCharacters,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 8 caracteres",
                  isValidate: eightCharacters.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneNumber,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 número (0....9)",
                  isValidate: oneNumber.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneLowercase,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 letra minúscula (a...z)",
                  isValidate: oneLowercase.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneCapital,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 letra mayúscula (A...Z)",
                  isValidate: oneCapital.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneSpecialSymbol,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 símbolo especial (!...\$)",
                  isValidate: oneSpecialSymbol.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// class NewPasswordV2 extends HookConsumerWidget {
//   const NewPasswordV2({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeProvider = ref.watch(settingsNotifierProvider);
//     final passwordController = useTextEditingController();
//     // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
//     final isHidden = useState(true);
//     return CustomScaffoldReturn(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//               Container(
//                 alignment: Alignment.topCenter,
//                 child: SizedBox(
//                   child: Image.asset(
//                     'assets/forgotpassword/padlock.png',
//                     width: 67,
//                     height: 75,
//                   ),
//                 ),
//               ),
//               TextPoppins(
//                 text: 'Cambiar tu contraseña',
//                 colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//               ),
//               const SizedBox(height: 20),
//               TextPoppins(
//                 text: 'Ingresa tu nueva contraseña',
//                 colorText: themeProvider.isDarkMode ? (whiteText) : (blackText),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 224,
//                 height: 38,
//                 child: TextFormField(
//                   // onChanged: (value) {
//                   //   _password = value;
//                   // },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Por favor ingrese algún valor';
//                     }
//                     return null;
//                   },
//                   obscureText: isHidden.value, // esto oculta la contrasenia
//                   obscuringCharacter:
//                       '*', //el caracter el cual reemplaza la contrasenia
//                   decoration: InputDecoration(
//                     suffixIconConstraints: const BoxConstraints(
//                       maxHeight: 38,
//                       minWidth: 38,
//                     ),
//                     suffixIcon: IconButton(
//                       splashRadius: 20,
//                       padding: EdgeInsets.zero,
//                       icon: Icon(
//                         isHidden.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         size: 23.20,
//                       ),
//                       alignment: Alignment.center,
//                       onPressed: () {
//                         isHidden.value = !isHidden.value;
//                       },
//                     ),
//                     label: const Text(
//                       "Contraseña",
//                     ),
//                   ),
//                   controller: passwordController,
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
//                       final status = await ref.read(
//                         setNewPasswordFutureProvider(passwordController.text)
//                             .future,
//                       );
//                       if (status == true) {
//                         ref
//                             .read(userProfileNotifierProvider.notifier)
//                             .setPassword(passwordController.text);
//                         const SnackBar(
//                           content: Text('Contraseña cambiada con éxito'),
//                         );
//                         showSnackBarV2(
//                           context: context,
//                           title: "Contraseña cambiada con ≠!",
//                           message: 'Contraseña cambiada con éxito!',
//                           snackType: SnackType.success,
//                         );

//                         await Future.delayed(const Duration(seconds: 1));
//                         Navigator.pushNamed(context, '/v2/login_email');
//                       } else {
//                         showSnackBarV2(
//                           context: context,
//                           title: "Error al cambiar la contraseña",
//                           message: 'No se pudo cambiar la contraseña',
//                           snackType: SnackType.error,
//                         );
//                       }
//                     },
//                     child: const Text('Cambiar contraseña'),
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
