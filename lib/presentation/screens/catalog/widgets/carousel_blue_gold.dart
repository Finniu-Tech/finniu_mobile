import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/infrastructure/models/blue_gold_investment/progress_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card.dart';
import 'package:flutter/material.dart';

class CarouselBlueGold extends StatelessWidget {
  final ValueNotifier<int> pageNotifier;
  final List<AggroInvestment> aggroInvestmentList;
  const CarouselBlueGold({
    super.key,
    required this.pageNotifier,
    required this.aggroInvestmentList,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = aggroInvestmentList
        .map(
          (e) => BlueGoldInvestmentCard(
            days: e.totalDays,
            progress: e.advancePercent,
            amount: e.parcelAmount.toInt(),
          ),
        )
        .toList();

    return Container(
      height: 240,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 278,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            pageNotifier.value = index;
          },
        ),
      ),
    );
  }
}
