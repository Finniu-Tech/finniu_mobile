import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SliderItem {
  final String title;
  final String bodyText;
  final String imageUrl;
  final VoidCallback? onPressed;

  SliderItem({
    required this.title,
    required this.bodyText,
    required this.imageUrl,
    required this.onPressed,
  });
}

class ReInvestmentSlider extends StatefulWidget {
  final List<LastOperation> operations;
  const ReInvestmentSlider({
    super.key,
    required this.operations,
  });

  @override
  ReInvestmentSliderState createState() => ReInvestmentSliderState();
}

class ReInvestmentSliderState extends State<ReInvestmentSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<SliderItem> sliderItems = widget.operations.map((operation) {
      const String title = "¡Ya puedes reinvertir!";
      const String bodyText = "Tienes algunas inversiones disponibles para reinvertir";
      const String imageUrl = "assets/investment/tree_money.png";

      return SliderItem(
        title: title,
        bodyText: bodyText,
        imageUrl: imageUrl,
        onPressed: () => Navigator.pushNamed(
          context,
          '/v2/investment',
          arguments: {'reinvest': true},
        ),
      );
    }).toList();
    //if items mayor than 6 , only show 6

    if (sliderItems.length > 6) {
      sliderItems = sliderItems.sublist(0, 6);
    }

    // List<SliderItem> sliderItems = [
    //   SliderItem(
    //     title: "¡Ya puedes reinvertir!",
    //     bodyText: "Tienes algunas inversiones disponibles para reinvertir",
    //     imageUrl: "assets/investment/tree_money.png",
    //     onPressed: () => Navigator.pushNamed(
    //       context,
    //       '/v2/investment',
    //       arguments: {'reinvest': true},
    //     ),
    //   ),
    // ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Center(
          child: CarouselSlider(
            items: sliderItems.map((item) {
              return SliderReinvest(
                title: item.title,
                bodyText: item.bodyText,
                imageUrl: item.imageUrl,
                onPressed: item.onPressed,
              );
            }).toList(),
            options: CarouselOptions(
              height: 67,
              viewportFraction: 0.9,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
        ItemSelectCarrousel(
          sliderItems: sliderItems,
          currentIndex: _currentIndex,
        ),
      ],
    );
  }
}

class ItemSelectCarrousel extends ConsumerWidget {
  const ItemSelectCarrousel({
    super.key,
    required this.sliderItems,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final List<SliderItem> sliderItems;
  final int _currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int colorDark = 0xffA2E6FA;
    const int colorLight = 0xff0D3A5C;
    const int colorNotSelectDark = 0xff444444;
    const int colorNotSelectLight = 0xffA2E6FA;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(sliderItems.length, (index) {
        return Container(
          width: 45.0,
          height: 5.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: isDarkMode
                ? _currentIndex == index
                    ? const Color(colorDark)
                    : const Color(colorNotSelectDark)
                : _currentIndex == index
                    ? const Color(colorLight)
                    : const Color(colorNotSelectLight),
          ),
        );
      }),
    );
  }
}

class SliderReinvest extends StatelessWidget {
  const SliderReinvest({
    super.key,
    required this.onPressed,
    required this.title,
    required this.bodyText,
    required this.imageUrl,
  });
  final VoidCallback? onPressed;
  final String title;
  final String bodyText;
  final String imageUrl;

  final int textTitle = 0xff0D3A5C;
  final int bodyTitle = 0xff000000;
  final int gradientInitTitle = 0xFFFFEEDD;
  final int gradientEndTitle = 0xFFA2E6FA;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color(gradientInitTitle),
            Color(gradientEndTitle),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 48,
            height: 34,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: title,
                  fontSize: 16,
                  isBold: true,
                  textDark: textTitle,
                  textLight: textTitle,
                ),
                TextPoppins(
                  text: bodyText,
                  fontSize: 11,
                  isBold: false,
                  lines: 2,
                  textDark: bodyTitle,
                  textLight: bodyTitle,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              color: Color(textTitle),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
