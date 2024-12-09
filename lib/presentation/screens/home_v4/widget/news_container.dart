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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TitleNews(),
          ),
          NewsCarrousel(),
          SizedBox(height: 20),
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
    final items = List.generate(
      3,
      (index) => NewItem(
        index: (index + 1).toString(),
        title: "Artículo de finanzas",
        author: "Por Javier Salmón",
        date: "12 Nov, 2024",
        onTap: () {
          print("pon tap ${index + 1}");
        },
      ),
    );

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 160.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.5,
      ),
    );
  }
}

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.index,
    required this.title,
    required this.author,
    required this.date,
    required this.onTap,
  });
  final String index;
  final String title;
  final String author;
  final String date;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    const int buttonColor = 0xffA2E6FA;
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/home_v4/example_$index.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textDark: HomeV4Colors.newsTitleDark,
                  textLight: HomeV4Colors.newsTitleLight,
                  lines: 2,
                ),
                const SizedBox(height: 5),
                TextPoppins(
                  text: author,
                  fontSize: 8,
                  lines: 2,
                  textDark: HomeV4Colors.newsTitleDark,
                  textLight: HomeV4Colors.newsTitleLight,
                ),
                TextPoppins(
                  text: date,
                  fontSize: 8,
                  lines: 2,
                  textDark: HomeV4Colors.newsTitleDark,
                  textLight: HomeV4Colors.newsTitleLight,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 105,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(buttonColor),
                    ),
                    child: const Center(
                      child: TextPoppins(
                        text: "Leer Artículo",
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
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
