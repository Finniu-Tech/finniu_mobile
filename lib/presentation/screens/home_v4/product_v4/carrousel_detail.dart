import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarrouselDetailV4 extends ConsumerWidget {
  const CarrouselDetailV4({super.key, required this.itemCarrousel});
  final List<Widget> itemCarrousel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: itemCarrousel,
        options: CarouselOptions(
          height: 280,
          enlargeCenterPage: true,
          aspectRatio: 3 / 2,
          viewportFraction: 0.7,
        ),
      ),
    );
  }
}
