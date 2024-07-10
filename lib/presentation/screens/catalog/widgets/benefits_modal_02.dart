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

class ModalBenefitsTwo extends StatelessWidget {
  const ModalBenefitsTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonInvestment(
      text: 'Beneficios Two',
      onPressed: () => benefitsDialog(context),
    );
  }
}

Future<dynamic> benefitsDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const BodyModalBenefits(),
  );
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
        width: 322,
        height: 510,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CloseButton(),
                const SizedBox(height: 10),
                const TextTitle(),
                const SizedBox(height: 10),
                GridContainer(
                  items: gridItems,
                ),
              ],
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CardItem(item: items[0]),
            const SizedBox(width: 20),
            CardItem(item: items[1]),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CardItem(item: items[2]),
            const SizedBox(width: 20),
            CardItem(item: items[3]),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CardItem(item: items[4]),
            const SizedBox(width: 20),
            CardItem(item: items[5]),
          ],
        ),
      ],
    );
  }
}

class CardItem extends ConsumerWidget {
  const CardItem({
    super.key,
    required this.item,
  });
  final GridItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff1C1B1B;
    const backgroundLight = 0xffB0D6FF;
    return Container(
      width: 133,
      height: 120,
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
