import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_feedback.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void showFeedbackModal(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const _BodyFeedback();
    },
  );
}

class _BodyFeedback extends ConsumerWidget {
  const _BodyFeedback();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff191919;
    const int colorLight = 0xffFFFFFF;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
      child: Dialog(
        backgroundColor:
            isDarkMode ? const Color(colorDark) : const Color(colorLight),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 540,
          child: const Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: "Feedback",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                TextPoppins(
                  text: "Cuéntanos como te fue tu proceso de inversión",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                TextPoppins(
                  text: "En una escala del 1 al 5",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TextPoppins(
                  text:
                      "¿Qué tan satisfecho estás con el proceso de inversión? 😊",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  lines: 2,
                ),
                _FormFeedback(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormFeedback extends HookConsumerWidget {
  const _FormFeedback();
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackTextController = useTextEditingController();
    final feedbackNumerController = useTextEditingController();

    void pushFeedback() {
      if (formKey.currentState!.validate()) {
        print("push feedback");
        print(feedbackTextController.text);
        print(feedbackNumerController.text);
        final data = DtoFedbackForm(
          message: feedbackTextController.text,
          rating: feedbackNumerController.text,
        );
        context.loaderOverlay.show();
        pushFeedbackData(context, data, ref);
        Navigator.pop(context);
      }
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectFeedback(
            controller: feedbackNumerController,
          ),
          const TextPoppins(
            text:
                "Cuéntanos, ¿que podemos hacer para mejorar en el proceso de registro?",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            lines: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          InputTextAreaUserProfile(
            controller: feedbackTextController,
            hintText: "Por favor, cuéntanos tu experiencia con Finniu",
            validator: null,
          ),
          ButtonInvestment(
            text: 'Enviar mi feedback',
            onPressed: () => pushFeedback(),
          ),
        ],
      ),
    );
  }
}

class SelectFeedback extends HookConsumerWidget {
  const SelectFeedback({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectedNumber = useState(
      controller.text,
    );

    List<String> options = ["1", "2", "3", "4", "5"];
    List<int> colors = [
      0xffFF4A40,
      0xffFFAE34,
      0xffFFE849,
      0xff23E986,
      0xff00C462,
    ];

    const int textColor = 0xff000000;

    return SizedBox(
      height: 90,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...options.map(
                  (number) => GestureDetector(
                    onTap: () {
                      controller.text = number;
                      selectedNumber.value = number;
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(colors[options.indexOf(number)]),
                        shape: BoxShape.circle,
                        boxShadow: selectedNumber.value == number
                            ? [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(2, 5),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: TextPoppins(
                          text: number,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          textDark: textColor,
                          textLight: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextPoppins(
                text: "Muy insatisfecho",
                fontSize: 8,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: "Muy satisfecho ",
                fontSize: 8,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
