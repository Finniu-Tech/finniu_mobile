import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_register_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/check_terms_conditions.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_phone_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/v2_user_profile/widgets/password_required.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormRegister extends HookConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nickNameController = TextEditingController();
    final countryPrefixController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    // final acceptPrivacyAndTerms = useState(false);
    final ValueNotifier<bool> isPasswordExpanded = ValueNotifier<bool>(false);
    final ValueNotifier<bool> nickNameError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> phoneNumberError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> emailError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> passwordError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> passwordConfirmError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> acceptPrivacyAndTerms =
        ValueNotifier<bool>(false);
    void saveAndPush(BuildContext context) async {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (acceptPrivacyAndTerms.value == false) {
          showSnackBarV2(
            context: context,
            title: "Olvidaste marcar los T&C",
            message: "Revisa y marca los T&C y las políticas ",
            snackType: SnackType.warning,
          );
          return;
        }
        if (nickNameError.value) return;
        if (phoneNumberError.value) return;
        if (emailError.value) return;
        if (passwordError.value) return;
        if (passwordConfirmError.value) return;
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

        context.loaderOverlay.show();
        pushDataForm(context, data, ref);
      }
    }

    final FocusNode focusNode = FocusNode();
    return Form(
      key: formKey,
      child: Stack(
        children: [
          Column(
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
                      validateName(
                        value: value,
                        context: context,
                        boolNotifier: nickNameError,
                      );
                      return null;
                    },
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: phoneNumberError,
                builder: (context, isError, child) {
                  return InputPhoneUserProfile(
                    isError: isError,
                    onError: () => phoneNumberError.value = false,
                    controller: phoneNumberController,
                    countryController: countryPrefixController,
                    hintText: "Escribe tu número telefónico",
                    validator: (value) {
                      validatePhone(
                        value: value,
                        context: context,
                        boolNotifier: phoneNumberError,
                      );
                      return null;
                    },
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: emailError,
                builder: (context, isError, child) {
                  return InputTextFileUserProfile(
                    isError: isError,
                    onError: () => emailError.value = false,
                    hintText: "Correo electronico",
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
              ValueListenableBuilder<bool>(
                valueListenable: acceptPrivacyAndTerms,
                builder: (context, isError, child) {
                  return CheckTermsAndConditions(
                    checkboxValue: acceptPrivacyAndTerms.value,
                    onPressed: () {
                      acceptPrivacyAndTerms.value =
                          !acceptPrivacyAndTerms.value;
                    },
                  );
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
          ValueListenableBuilder<bool>(
            valueListenable: isPasswordExpanded,
            builder: (context, isError, child) {
              return isPasswordExpanded.value
                  ? PasswordRequired(
                      controller: passwordController,
                      isExpanded: isPasswordExpanded.value,
                    )
                  : const SizedBox();
            },
          ),
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
        Navigator.pushNamed(context, '/v2/login_email');
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
