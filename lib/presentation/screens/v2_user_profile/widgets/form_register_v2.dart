import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormRegister extends HookConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final namesController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final checkboxValue = useState(false);

    return Form(
      key: formKey,
      child: Column(
        children: [
          RegisterTextFile(
            hintText: "Como te llaman",
            controller: namesController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          RegisterTextFile(
            isNumeric: true,
            hintText: "Número telefónico",
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Ingresa tu nómero de telémefono';
              }
              return null;
            },
          ),
          RegisterTextFile(
            hintText: "Correo electronico",
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Ingresar un correo electrónico válido';
              } else {
                return null;
              }
            },
          ),
          RegisterPasswordField(
            controller: passwordController,
            hintText: "Contraseña ",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              } else if (value.length < 8) {
                return 'Debe tener al menos 8 caracteres';
              }
              return null;
            },
          ),
          RegisterPasswordField(
            controller: passwordConfirmController,
            hintText: "Confirmar contraseña",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              } else if (value.length < 8) {
                return 'Debe tener al menos 8 caracteres';
              }
              if (value != passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          CheckConditions(
            checkboxValue: checkboxValue.value,
            onPressed: () {
              checkboxValue.value = !checkboxValue.value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonInvestment(
            text: "Crear mi cuenta",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                print(namesController.text);
                print(emailController.text);
                print(phoneController.text);
                print(passwordController.text);
                print("confirmacion");
                print(passwordConfirmController.text);
                print(checkboxValue.value);
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "¿Ya tienes una cuenta creada?,",
            fontSize: 14,
          ),
          RedirectLogin(),
        ],
      ),
    );
  }
}

class RedirectLogin extends ConsumerWidget {
  const RedirectLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int linkDark = 0xffA2E6FA;
    const int linkLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: () {
        print("login");
      },
      child: const TextPoppins(
        text: "Inicia sesión",
        fontSize: 14,
        isBold: true,
        textDark: linkDark,
        textLight: linkLight,
      ),
    );
  }
}

class CheckConditions extends ConsumerWidget {
  const CheckConditions({
    super.key,
    required this.checkboxValue,
    required this.onPressed,
  });
  final bool checkboxValue;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int spanDark = 0xffFFFFFF;
    const int spanLight = 0xff000000;
    const int linkDark = 0xffA2E6FA;
    const int linkLight = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            activeColor:
                isDarkMode ? const Color(linkDark) : const Color(linkLight),
            value: checkboxValue,
            onChanged: (onChanged) {
              onPressed();
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Estoy de acuerdo con los ',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? const Color(spanDark)
                              : const Color(spanLight),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text:
                            'Términos & condiciones y Políticas de privacidad',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? const Color(linkDark)
                              : const Color(linkLight),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("tap");
                            print(
                              "al usuario que lea los terminos y condiciones hay que darle un premio",
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterTextFile extends ConsumerWidget {
  const RegisterTextFile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isNumeric = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isNumeric;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Color(hintDark) : Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            fillColor: isDarkMode ? Color(fillDark) : Color(fillLight),
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class RegisterPasswordField extends HookConsumerWidget {
  const RegisterPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isObscure = useState(true);
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF000000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isObscure.value,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Color(hintDark) : Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            fillColor: isDarkMode ? Color(fillDark) : Color(fillLight),
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: isObscure.value
                  ? SvgPicture.asset(
                      "assets/svg_icons/eye_close.svg",
                      width: 24,
                      height: 24,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                    )
                  : Icon(
                      Icons.visibility,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                      size: 24,
                    ),
              onPressed: () {
                isObscure.value = !isObscure.value;
              },
            ),
          ),
          validator: validator,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
