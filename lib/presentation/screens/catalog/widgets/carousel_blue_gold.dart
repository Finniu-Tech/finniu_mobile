import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gols_card.dart';
import 'package:flutter/material.dart';

class CarouselBlueGold extends StatelessWidget {
  const CarouselBlueGold({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      const BlueGoldInvestmentCard(days: 100, progress: 50, amount: 1000),
      const BlueGoldInvestmentCard(days: 50, progress: 60, amount: 2000),
      const BlueGoldInvestmentCard(days: 10, progress: 90, amount: 3000),
      const BlueGoldInvestmentCard(days: 0, progress: 100, amount: 4000),
    ];
    return Container(
      height: 240,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 278,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
