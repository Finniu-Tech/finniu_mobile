import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showModalReasons(BuildContext context, bool isDarkMode) {
  const int backgroundDark = 0xff1A1A1A;
  const int backgroundLight = 0xffFFFFFF;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      child: ReasonsBody(
        isDarkMode: isDarkMode,
      ),
    ),
  );
}

class ReasonsBody extends StatelessWidget {
  const ReasonsBody({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 370,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CloseIcon(
              isDarkMode: isDarkMode,
              closeModal: () => Navigator.pop(context),
            ),
            const ReasonAndComments(),
          ],
        ),
      ),
    );
  }
}

class ReasonAndComments extends HookConsumerWidget {
  const ReasonAndComments({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final itemSelect = useState<String?>(null);
    final PageController pageController = usePageController();
    final areaController = useTextEditingController();

    const List<String> reasons = [
      "Ya completé mi meta",
      "Necesito mi dinero",
      "Me han ofrecido mejor rentabilidad",
      "Percibo mucho riesgo",
      "Otros",
    ];
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int containerDark = 0xff272728;
    const int containerLight = 0xffD9F6FF;
    const String remember =
        "Recuerda que el día 15 de Agosto estaremos realizando tu depósito de tu capital durante un plazo de 24 hrs";

    useEffect(
      () {
        if (itemSelect.value != null) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => {
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            },
          );
        }
        return null;
      },
      [itemSelect.value],
    );

    final List<Widget> pages = [
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const TextPoppins(
              text: "Cuéntanos tus motivos ",
              fontSize: 16,
            ),
            ...reasons.map(
              (reason) => GestureDetector(
                onTap: () => itemSelect.value = reason,
                child: ItemReason(
                  text: reason,
                  isDarkMode: isDarkMode,
                  isSelect: itemSelect.value == reason,
                ),
              ),
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextPoppins(
            text: "Cuéntanos tus motivos ",
            fontSize: 16,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: InputTextAreaUserProfile(
              controller: areaController,
              hintText: "Escribe el motivo",
              validator: null,
              lines: 8,
            ),
          ),
          ButtonInvestment(
            text: 'Enviar',
            onPressed: () => pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Image.asset(
            "assets/home_v4/tanks_coments${isDarkMode ? "_dark" : "_light"}.png",
            width: 90,
            height: 90,
          ),
          const TextPoppins(
            text: "¡Gracias por tus comentarios!",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            lines: 2,
            textDark: titleDark,
            textLight: titleLight,
          ),
          const SizedBox(
            height: 5,
          ),
          const TextPoppins(
            text: "Esperamos verte pronto 💸",
            fontSize: 16,
            align: TextAlign.center,
            lines: 2,
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(containerDark)
                  : const Color(containerLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/clock_icon.svg",
                  width: 20,
                  height: 20,
                  color: isDarkMode
                      ? const Color(titleDark)
                      : const Color(titleLight),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const TextPoppins(
                    text: remember,
                    fontSize: 12,
                    lines: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: 290,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
      ),
    );
  }
}

class ItemReason extends StatelessWidget {
  const ItemReason({
    super.key,
    required this.text,
    required this.isDarkMode,
    required this.isSelect,
  });
  final String text;
  final bool isDarkMode;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    const int backgroundDark = 0xff212121;
    const int backgroundLight = 0xffF2F2F2;
    const int backgroundSelectDark = 0xffBCF0FF;
    const int backgroundSelectLight = 0xffBCF0FF;
    const int textSelectDark = 0xff000000;
    const int textSelectLight = 0xff000000;
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelect
            ? isDarkMode
                ? const Color(backgroundSelectDark)
                : const Color(backgroundSelectLight)
            : isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
      ),
      child: TextPoppins(
        text: text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        textDark: isSelect ? textSelectDark : null,
        textLight: isSelect ? textSelectLight : null,
      ),
    );
  }
}
