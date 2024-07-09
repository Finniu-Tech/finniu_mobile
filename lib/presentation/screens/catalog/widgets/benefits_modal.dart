import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class GridItem {
  final String image;
  final String text;

  GridItem({
    required this.image,
    required this.text,
  });
}

class ModalBenefits extends StatelessWidget {
  const ModalBenefits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonInvestment(
      text: 'Beneficios',
      onPressed: () => showBenefits(context),
    );
  }

  Future<dynamic> showBenefits(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const BodyModalBenefits(),
    );
  }
}

class BodyModalBenefits extends ConsumerWidget {
  const BodyModalBenefits({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff0E0E0E;
    const backgroundLight = 0xffFFFFFF;
    final List<GridItem> gridItems = [
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_01.png',
        text: 'Socio de la cooperativa agraria',
      ),
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_02.png',
        text: 'Participa en la toma de decisiones',
      ),
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_03.png',
        text: 'Régimen especial de inafectación del IR',
      ),
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_04.png',
        text: 'Buen gobierno corporativo',
      ),
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_05.png',
        text: 'Tasa reducida del 0% hasta S/154,500 al año Ing. Netos',
      ),
      GridItem(
        image: 'assets/benefits_modal/benefits_modal_06.png',
        text: 'Integración de cooperativismo y comercio justo',
      ),
    ];

    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 529,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              const CloseButton(),
              const TextTitle(),
              GridContainer(
                items: gridItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridContainer extends ConsumerWidget {
  final List<GridItem> items;

  const GridContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff1C1B1B;
    const backgroundLight = 0xffB0D6FF;

    return SizedBox(
      height: 455,
      width: 400,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(item.image, width: 50, height: 50),
                const SizedBox(height: 5),
                Text(
                  item.text,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode
                        ? const Color(0xffFFFFFF)
                        : const Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TextTitle extends ConsumerWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffFFFFFF;
    const int colorLight = 0xff000000;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Beneficios",
          style: TextStyle(
            color:
                isDarkMode ? const Color(colorDark) : const Color(colorLight),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CloseButton extends ConsumerWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffFFFFFF;
    const int colorLight = 0xff515151;
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Transform.rotate(
              angle: math.pi / 4,
              child: Icon(
                Icons.add_circle_outline,
                size: 20,
                color: isDarkMode
                    ? const Color(colorDark)
                    : const Color(colorLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
