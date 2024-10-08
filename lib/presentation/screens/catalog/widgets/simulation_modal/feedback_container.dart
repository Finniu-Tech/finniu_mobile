import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_feedback.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FeedbackContainer extends StatelessWidget {
  const FeedbackContainer({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextPoppins(
            text: "Feedback",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          const TextPoppins(
            text: "Cuéntanos como te fue tu proceso de inversión",
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          const TextPoppins(
            text: "En una escala del 1 al 5",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          const TextPoppins(
            text: "¿Qué tan satisfecho estás con el proceso de inversión? 😊",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            lines: 2,
          ),
          FormFeedback(
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}

class FormFeedback extends HookConsumerWidget {
  const FormFeedback({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackTextController = useTextEditingController();
    final feedbackNumerController = useTextEditingController();
    final buttonTrue = useState(false);

    void pushFeedback() async {
      if (formKey.currentState!.validate()) {
        final data = DtoFedbackForm(
          question: "¿Qué tan satisfecho estás con el proceso de inversión?",
          answer: feedbackNumerController.text,
          questionSecond:
              "¿que podemos hacer para mejorar en el proceso de inversión?",
          answerSecond: feedbackTextController.text,
        );

        context.loaderOverlay.show();
        final result = await pushFeedbackData(context, data, ref);
        if (result) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn,
          );
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn,
          );
        }
        context.loaderOverlay.hide();
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
            buttonTrue: buttonTrue,
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
          ButtonForm(
            text: 'Enviar mi feedback',
            onPressed: buttonTrue.value ? pushFeedback : null,
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
    required this.buttonTrue,
  });
  final TextEditingController controller;
  final ValueNotifier<bool> buttonTrue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectedNumber = useState(
      controller.text,
    );

    List<String> options = ["1", "2", "3", "4", "5"];
    List<String> optionsSelect = ["😖", "☹️", "🤨", "😁", "🤩"];
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
                      buttonTrue.value = true;
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
                          text: selectedNumber.value == number
                              ? optionsSelect[options.indexOf(number)]
                              : number,
                          fontSize: selectedNumber.value == number ? 20 : 15,
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
