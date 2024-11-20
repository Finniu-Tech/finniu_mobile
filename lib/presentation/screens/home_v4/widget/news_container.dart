import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleNews(),
          NewsCarrousel(),
        ],
      ),
    );
  }
}

class NewsCarrousel extends StatelessWidget {
  const NewsCarrousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = List.generate(4, (index) => const NewItem());

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.4,
      ),
    );
  }
}

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red[300],
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/home_v4/new_example.png",
            fit: BoxFit.fill,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: "Artículo de finanzas",
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  textDark: HomeV4Colors.newsTitleDark,
                  textLight: HomeV4Colors.newsTitleLight,
                ),
                TextPoppins(
                  text: "Subtitulo finanzas",
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  textDark: HomeV4Colors.newsTitleDark,
                  textLight: HomeV4Colors.newsTitleLight,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleNews extends StatelessWidget {
  const TitleNews({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextPoppins(
      text: "Últimas noticias",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      align: TextAlign.start,
    );
  }
}

// final items = List.generate(
//   3,
//   (index) => Container(width: 100, height: 50, color: Colors.red),
// );
// return CarouselSlider(
//   items: items,
//   options: CarouselOptions(
//     height: 200.0,
//     enlargeCenterPage: true,
//     autoPlay: true,
//     aspectRatio: 16 / 9,
//     autoPlayCurve: Curves.fastOutSlowIn,
//     enableInfiniteScroll: true,
//     autoPlayAnimationDuration: const Duration(milliseconds: 800),
//     viewportFraction: 0.8,
//   ),
// );
