import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CarrouselSlide extends StatelessWidget {
  const CarrouselSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      const ManagedAssets(),
      const InvestedCapital(),
      const SlideCarouselCard(
        color: 0xffFFEEDD,
        body: Text("index 3"),
      ),
    ];
    return Container(
      color: const Color(0xffDCF5FC),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 341,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class InvestedCapital extends StatelessWidget {
  const InvestedCapital({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SlideCarouselCard(
      color: 0xffFFFFFF,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text("Patrimonio neto (S/ MM)"), SfCartesianChart()],
      ),
    );
  }
}

class ManagedAssets extends StatelessWidget {
  const ManagedAssets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SlideCarouselCard(
      color: 0xffFFEEDD,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Activos administrados",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Los activos administrados representan el valor de mercado de las inversiones del fondo",
            maxLines: 4,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            height: 2,
            color: Color(0xff0D3A5C),
          ),
          Text(
            "Activos administrados",
            style: TextStyle(fontSize: 11),
            textAlign: TextAlign.right,
          ),
          Text(
            "S/5,700.00",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SlideCarouselCard extends StatelessWidget {
  final int color;
  final Widget body;
  const SlideCarouselCard({
    super.key,
    required this.color,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: body,
      ),
    );
  }
}
