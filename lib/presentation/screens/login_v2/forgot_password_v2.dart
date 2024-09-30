import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/login_v2/helpers/send_email_helper.dart';
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
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const FormForgot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailError = useState<bool>(false);
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
        sendEmailRecovery(
          context: context,
          email: emailController.text.trim(),
          ref: ref,
        );
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            InputTextFileUserProfile(
              isError: emailError.value,
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
            ),
            ButtonInvestment(
              text: "Enviar",
              onPressed: seedEmail,
            ),
          ],
        ),
      ),
    );
  }
}
