import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_register_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/check_terms_conditions.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_phone_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormRegister extends HookConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nickNameController = useTextEditingController();
    final countryPrefixController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final acceptPrivacyAndTerms = useState(false);
    final ValueNotifier<bool> nickNameError = ValueNotifier<bool>(false);
    void saveAndPush(BuildContext context) async {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        // CustomSnackbarV2.show(context);
      }
      if (formKey.currentState!.validate()) {
        context.loaderOverlay.show();
        final DtoRegisterForm data = DtoRegisterForm(
          nickName: nickNameController.text.trim(),
          countryPrefix: countryPrefixController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          confirmPassword: passwordConfirmController.text.trim(),
          acceptTermsConditions: acceptPrivacyAndTerms.value,
          acceptPrivacyPolicy: acceptPrivacyAndTerms.value,
        );
        if (acceptPrivacyAndTerms.value == false) {
          showSnackBarV2(
            context: context,
            title: "Olvidaste marcar los T&C",
            message: "Revisa y marca los T&C y las políticas ",
            snackType: SnackType.warning,
          );
        }
        context.loaderOverlay.show();
        pushDataForm(context, data, ref);
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: nickNameError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                onError: () => nickNameError.value = false,
                isError: isError,
                hintText: "Como te llaman",
                controller: nickNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "Nombre obligatorio",
                      message: "Por favor, completa el nombre.",
                      snackType: SnackType.warning,
                    );
                    nickNameError.value = true;
                    return null;
                  }
                  if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                    showSnackBarV2(
                      context: context,
                      title: "Nombre inválido",
                      message:
                          "El nombre no debe contener números ni caracteres especiales.",
                      snackType: SnackType.warning,
                    );
                    nickNameError.value = true;
                    return null;
                  }
                  return null;
                },
              );
            },
          ),
          InputPhoneUserProfile(
            controller: phoneNumberController,
            countryController: countryPrefixController,
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
          InputTextFileUserProfile(
            isError: false,
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
            checkboxValue: acceptPrivacyAndTerms.value,
            onPressed: () {
              acceptPrivacyAndTerms.value = !acceptPrivacyAndTerms.value;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ButtonInvestment(
            text: "Crear mi cuenta",
            onPressed: () => saveAndPush(context),
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
