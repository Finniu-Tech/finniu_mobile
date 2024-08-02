import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    bool checkboxValue = false;

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
              }),
          RegisterTextFile(
              isNumeric: true,
              hintText: "Número telefónico",
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 8) {
                  return 'Ingresa tu nómero de telémefono';
                }
                return null;
              }),
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
              }),
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
          CheckConditions(),
          SizedBox(
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
              }
            },
          ),
        ],
      ),
    );
  }
}

class CheckConditions extends StatelessWidget {
  const CheckConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(value: true, onChanged: (onChanged) {}),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextPoppins(
                    text: "Estoy de acuerdo con los ", fontSize: 14),
                GestureDetector(
                  onTap: () {},
                  child: const TextPoppins(
                    text: "Términos & condiciones y Políticas de privacidad",
                    fontSize: 14,
                    isBold: true,
                    lines: 2,
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
              icon: Icon(
                isObscure.value ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? Colors.white : Colors.black,
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
