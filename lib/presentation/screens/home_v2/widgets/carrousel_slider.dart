import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarrouselSlider extends StatelessWidget {
  const CarrouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Center(
        child: CarouselSlider(
          items: const [
            SliderReinvest(),
            SliderReinvest(),
          ],
          options: CarouselOptions(
            height: 67,
            viewportFraction: 0.8,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
          ),
        ),
      ),
    );
  }
}

class SliderReinvest extends StatelessWidget {
  const SliderReinvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFEEDD),
            Color(0xFFA2E6FA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
