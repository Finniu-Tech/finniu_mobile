import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_feedback.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/simulation_modal/feedback_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ExperienceScreenV4 extends StatelessWidget {
  const ExperienceScreenV4({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: const ExperienceBody(),
          ),
        ),
      ),
    );
  }
}

class ExperienceBody extends HookConsumerWidget {
  const ExperienceBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final List<Color> gradientDark = [
      const Color(0xFF0E0E0E),
      const Color(0xFF08273F),
    ];
    final List<Color> gradientLight = [
      const Color(0xFFFFFFFF),
      const Color(0xFFDCF5FC),
    ];
    const titleDark = 0xffA2E6FA;
    const titleLight = 0xff0D3A5C;
    const textDark = 0xffFFFFFF;
    const textLight = 0xff0D3A5C;
    const borderDark = 0xff68C3DE;
    const borderLight = 0xff295984;

    final TextEditingController feedbackNumerController = useTextEditingController();
    final TextEditingController feedbackTextController = useTextEditingController();
    final buttonTrue = useState(false);
    void pushFeedback() async {
      final data = DtoFedbackForm(
        question: "¿Qué tan satisfecho estás con el proceso de inversión?",
        answer: feedbackNumerController.text,
        questionSecond: "¿que podemos hacer para mejorar en el proceso de inversión?",
        answerSecond: feedbackTextController.text,
      );

      context.loaderOverlay.show();

      final result = await pushFeedbackData(context, data, ref);

      if (result) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataSucces,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "push_feedback_succes",
          },
        );
      } else {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "push_feedback_false",
          },
        );
      }
      ref.read(navigatorStateProvider.notifier).state = 0;
      Navigator.pushNamedAndRemoveUntil(context, '/v4/home', (route) => false);
      context.loaderOverlay.hide();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode ? gradientDark : gradientLight,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextPoppins(
                  text: 'Tu experiencia es primero',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
                const SizedBox(height: 10),
                const TextPoppins(
                  text: 'Déjanos tus respuestas sobre tu experiencia dentro del proceso de inversión',
                  fontSize: 13,
                  lines: 2,
                  align: TextAlign.center,
                  textDark: textDark,
                  textLight: textLight,
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkMode ? const Color(borderDark) : const Color(borderLight),
                  ),
                ),
                const SizedBox(height: 10),
                const TextPoppins(
                  text: '¿Cómo calificarías tu experiencia durante el proceso de inversión?',
                  fontSize: 13,
                  lines: 2,
                  align: TextAlign.center,
                  textDark: textDark,
                  textLight: textLight,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: SelectFeedback(
                    controller: feedbackNumerController,
                    buttonTrue: buttonTrue,
                  ),
                ),
                const SizedBox(height: 10),
                const TextPoppins(
                  text: '¿Tienes algún comentario o sugerencia para mejorar nuestro proceso? (Opcional)',
                  fontSize: 13,
                  lines: 2,
                  align: TextAlign.center,
                  textDark: textDark,
                  textLight: textLight,
                ),
                const SizedBox(height: 10),
                InputTextAreaUserProfile(
                  controller: feedbackTextController,
                  hintText: "Por favor, cuéntanos tu experiencia con Finniu",
                  validator: null,
                ),
                const SizedBox(height: 10),
                ButtonForm(
                  text: 'Enviar mi feedback',
                  onPressed: buttonTrue.value ? pushFeedback : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
