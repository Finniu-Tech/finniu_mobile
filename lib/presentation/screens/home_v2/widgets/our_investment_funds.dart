import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/event_tracker_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OurInvestmentFunds extends ConsumerWidget {
  const OurInvestmentFunds({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackerService = ref.watch(eventTrackerServiceProvider);

    Future<void> onTapNavigate(FundEntity fund) async {
      final String fundEventName = fund.fundType == FundTypeEnum.corporate
          ? 'fund-corporate-detail-card'
          : 'fund-aggro-detail-card';
      await trackerService.logButtonClick(fundEventName);
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.screenView,
        parameters: {
          'navigated_from': fund.name,
        },
      );
      ref.read(firebaseAnalyticsServiceProvider).logScreenView(
        screenName: fundEventName,
        screenClass: 'home_v2',
        parameters: {
          'navigated_from': fund.name,
        },
      );
      Navigator.pushNamed(
        context,
        '/fund_detail',
        arguments: {
          'fund': fund,
        },
      );
    }

    final fundListAsyncValue = ref.watch(fundListFutureProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const TitleOfFunds(
            title: "Nuestros Fondos",
            icon: Icons.monetization_on_outlined,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: fundListAsyncValue.when(
              data: (fundList) {
                final fundCardList = fundList
                    .map(
                      (fund) => CardInvestment(
                        background: isDarkMode
                            ? Color(fund.getHexListColorDark())
                            : Color(fund.getHexListColorLight()),
                        backgroundImage: isDarkMode
                            ? Color(fund.getHexListColorDark())
                            : Color(fund.getHexListColorLight()),
                        textBody: fund.name,
                        onTap: () => onTapNavigate(fund),
                        imageUrl: fund.iconUrl != null
                            ? fund.iconUrl!
                            : 'https://finniu-statics.s3.amazonaws.com/investment_funds/backgrounds/backgroud_agro.png',
                      ),
                    )
                    .toList();

                return CarouselSlider(
                  items: fundCardList,
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: false,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    clipBehavior: Clip.none,
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }
}

class CardInvestment extends StatelessWidget {
  final Color background;
  final Color backgroundImage;
  final String textBody;
  final String imageUrl;
  final Function()? onTap;
  const CardInvestment({
    super.key,
    required this.background,
    required this.onTap,
    required this.backgroundImage,
    required this.textBody,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 132,
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: adjustColor(backgroundImage, saturationFactor: 0.69),
                  ),
                  height: 40,
                  width: 40,
                  child: Image.network(imageUrl),
                ),
                const Spacer(),
                Transform.rotate(
                  angle: -0.7854,
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textBody,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleOfFunds extends ConsumerWidget {
  final String title;
  final IconData icon;
  const TitleOfFunds({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(
              currentTheme.isDarkMode ? titleTextInvestment : primaryDark,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 24,
          color: Color(
            currentTheme.isDarkMode ? titleTextInvestment : primaryDark,
          ),
        ),
      ],
    );
  }
}
