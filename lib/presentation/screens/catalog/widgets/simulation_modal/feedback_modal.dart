import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/simulation_modal/feedback_container.dart';
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

class _BodyFeedback extends StatelessWidget {
  const _BodyFeedback();

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
      child: const _Dialog(),
    );
  }
}

class _Dialog extends HookConsumerWidget {
  const _Dialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff191919;
    const int colorLight = 0xffFFFFFF;
    final PageController pageController = PageController(
      initialPage: 0,
    );
    final isExpanded = useState(true);

    pageController.addListener(() {
      pageController.page! > 0.0
          ? isExpanded.value = false
          : isExpanded.value = true;
    });
    return Dialog(
      backgroundColor:
          isDarkMode ? const Color(colorDark) : const Color(colorLight),
      insetPadding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.9,
        height: isExpanded.value ? 560 : 271,
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeedbackContainer(
              pageController: pageController,
            ),
            const ThankYouContainer(),
          ],
        ),
      ),
    );
  }
}

class ThankYouContainer extends ConsumerWidget {
  const ThankYouContainer({
    super.key,
    this.isReInvestment = false,
  });
  final bool? isReInvestment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String titleText = "Gracias por invertir en Finniu!";
    const String secondText =
        "Recuerda que las tranferencias se confimarán en un plazo de 24hr si son directas y en un plazo de máximo 72hr si son interbancarios!";
    const String thankText = "Gracias por tu comprensión!";
    const int titleColorDark = 0xffA2E6FA;
    const int titleColorLight = 0xff0D3A5C;

    void onPressed() {
      Navigator.pop(context);
    }

    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const TextPoppins(
                    text: titleText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    lines: 2,
                    textDark: titleColorDark,
                    textLight: titleColorLight,
                  ),
                ),
                Image.asset(
                  'assets/icons/icon_tanks.png',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const TextPoppins(
              text: secondText,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              lines: 3,
            ),
            const TextPoppins(
              text: thankText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textDark: titleColorDark,
              textLight: titleColorLight,
            ),
            ButtonInvestment(
              text: "Ver mi progreso",
              onPressed: () => onPressed(),
            ),
          ],
        ),
      ),
    );
  }
}
