import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/news_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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

class NewsCarrousel extends ConsumerWidget {
  const NewsCarrousel({super.key});

  void onTap(String? url, context) {
    if (url == null || url.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Lo sentimos",
        message: "Noticia no disponible",
        snackType: SnackType.warning,
      );
      return;
    } else {
      Navigator.pushNamed(
        context,
        '/v4/notices_detail',
        arguments: url,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsyncValue = ref.watch(newsProvider);

    return newsAsyncValue.when(
      data: (news) => CarouselSlider(
        items: news
            .map(
              (newsItem) => NewItem(
                image: newsItem.imageUrl ?? '',
                title: newsItem.title,
                author: newsItem.author ?? 'Autor desconocido',
                date:
                    DateFormat('dd MMM, yyyy').format(newsItem.publicationDate),
                onTap: () => onTap(newsItem.newsUrl, context),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 160.0,
          enlargeCenterPage: false,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.6,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('Error cargando noticias: $error'),
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

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.date,
    required this.onTap,
  });

  final String image;
  final String title;
  final String author;
  final String date;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    const int buttonColor = 0xffA2E6FA;
    return Container(
      width: 180,
      height: 160, // Asegura una altura fija
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/home_v4/example_1.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        filterQuality: FilterQuality.medium,
                      ),
                    )
                  : Image.asset(
                      "assets/home_v4/example_1.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      filterQuality: FilterQuality.medium,
                      height: double.infinity,
                    ),
            ),
          ),
          // Añade un gradiente oscuro para mejor legibilidad
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
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
                        textDark: HomeV4Colors.newsTextDark,
                        textLight: HomeV4Colors.newsTextLight,
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
