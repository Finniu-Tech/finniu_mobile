import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/check_terms_conditions.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
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
    final countryController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final checkboxValue = useState(false);

    return Form(
      key: formKey,
      child: Column(
        children: [
          InputTextFileUserProfile(
            hintText: "Como te llaman",
            controller: namesController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          InputPhoneUserProfile(
            controller: phoneController,
            countryController: countryController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu nómero de telefono';
              }
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Solo puedes usar números';
              }
              if (value.length < 8) {
                return 'El nómero debe tener 8 digitos';
              }
              return null;
            },
            hintText: "Escribe tu número telefónico",
          ),
          const SizedBox(
            height: 15,
          ),
          InputTextFileUserProfile(
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
          InputPasswordFieldUserProfile(
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
          InputPasswordFieldUserProfile(
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
          CheckTermsAndConditions(
            checkboxValue: checkboxValue.value,
            onPressed: () {
              checkboxValue.value = !checkboxValue.value;
            },
          ),
          const SizedBox(
            height: 5,
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
                print(countryController.text);
                if (checkboxValue.value == false) {
                  CustomSnackbar.show(context,
                      "Debe aceptar los terminos y condiciones", 'error');
                }
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const TextPoppins(
            text: "¿Ya tienes una cuenta creada?,",
            fontSize: 14,
          ),
          const RedirectLogin(),
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
