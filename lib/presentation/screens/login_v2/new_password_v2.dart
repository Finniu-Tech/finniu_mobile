import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_password_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/login_v2/helpers/new_password_helper.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/password_new_requiered.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldUserProfile(
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
                    fontWeight: FontWeight.w500,
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
      ),
    );
  }
}

class FormNewPasword extends HookConsumerWidget {
  const FormNewPasword({
    super.key,
  });
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final ValueNotifier<bool> passwordError = useState(false);
    final ValueNotifier<bool> passwordConfirmError = useState(false);
    final ValueNotifier<bool> isPasswordExpanded = useState(false);
    FocusNode passwordFocusNode = useFocusNode();
    useEffect(
      () {
        void focusListener() {
          if (!passwordFocusNode.hasFocus) {
            isPasswordExpanded.value = false;
          }
        }

        passwordFocusNode.addListener(focusListener);
        return () {};
      },
      [passwordFocusNode],
    );

    void savePassword() async {
      if (!formKey.currentState!.validate()) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.setNewPasswordV2,
            "error": "error_form",
          },
        );
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
        resetPassword(
          context: context,
          ref: ref,
          newPassword: passwordController.text.trim(),
        );
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
                      onTap: () {
                        isPasswordExpanded.value = true;
                      },
                      focusNode: passwordFocusNode,
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
