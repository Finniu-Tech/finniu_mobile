import 'package:finniu/infrastructure/models/news_model.dart';
import 'package:finniu/presentation/providers/news_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NoticeScreenV4 extends StatelessWidget {
  const NoticeScreenV4({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return const Scaffold(
      appBar: AppBarProducts(
        title: "Noticias",
      ),
      bottomNavigationBar: NavBarV4(),
      body: SingleChildScrollView(
        child: NoticesColumn(),
      ),
    );
  }
}

class NoticesColumn extends ConsumerWidget {
  const NoticesColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(newsProvider);

    return notices.when(
      data: (notices) => SizedBox(
        height: MediaQuery.of(context).size.height - 160,
        child: ListView.builder(
          itemCount: notices.length,
          itemBuilder: (context, index) => NoticeItem(
            item: notices[index],
            index: index,
          ),
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => SizedBox(
        height: MediaQuery.of(context).size.height - 160,
        child: const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}

class NoticeItem extends ConsumerWidget {
  const NoticeItem({
    super.key,
    required this.index,
    required this.item,
  });
  final int index;
  final NewsModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    final int backgroudDark = index % 2 == 0 ? 0xffA2E6FA : 0xff0E0E0E;
    final int backgroudLight = index % 2 == 0 ? 0xffEDFBFF : 0xffFFFFFF;
    final int iconDark = index % 2 == 0 ? 0xff0D3A5C : 0xffA2E6FA;
    final int iconLight = index % 2 == 0 ? 0xff0D3A5C : 0xff0D3A5C;
    final int titleDark = index % 2 == 0 ? 0xff000000 : 0xffFFFFFF;
    final int titleLight = index % 2 == 0 ? 0xff000000 : 0xff000000;
    final int textDark = index % 2 == 0 ? 0xff000000 : 0xffFFFFFF;
    final int textLight = index % 2 == 0 ? 0xff000000 : 0xff000000;
    final int textButtonDark = index % 2 == 0 ? 0xffFFFFFF : 0xff0E0E0E;
    const int textButtonLight = 0xffFFFFFF;
    final int buttonDark = index % 2 == 0 ? 0xff0D3A5C : 0xffA2E6FA;
    final int buttonLight = index % 2 == 0 ? 0xff0D3A5C : 0xff0D3A5C;

    void onTap() {
      if (item.newsUrl == null || item.newsUrl!.isEmpty) {
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
          arguments: item.newsUrl,
        );
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(backgroudDark) : Color(backgroudLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextPoppins(
                  text: item.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  lines: 2,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: isDarkMode ? Color(iconDark) : Color(iconLight),
                  ),
                  const SizedBox(width: 5),
                  TextPoppins(
                    text:
                        DateFormat('dd MMM, yyyy').format(item.publicationDate),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    lines: 2,
                    textDark: titleDark,
                    textLight: titleLight,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          filterQuality: FilterQuality.low,
                          item.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "assets/home_v4/notice_exeption.png",
                            filterQuality: FilterQuality.low,
                            fit: BoxFit.cover,
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularLoader(
                                width: 50,
                                height: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextPoppins(
                          text: item.summary,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          lines: 5,
                          textDark: textDark,
                          textLight: textLight,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDarkMode
                                  ? Color(buttonDark)
                                  : Color(buttonLight),
                            ),
                            alignment: Alignment.center,
                            child: TextPoppins(
                              text: "Leer más",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              textDark: textButtonDark,
                              textLight: textButtonLight,
                            ),
                          ),
                        ),
                      ],
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
