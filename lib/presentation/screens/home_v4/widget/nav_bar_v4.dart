import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBarV4 extends ConsumerWidget {
  const NavBarV4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectedIndex = ref.watch(navigatorStateProvider);
    const int backgroudDark = 0xff0A304D;
    const int backgroudLight = 0xffC0F1FF;

    void navigate(BuildContext context, int index) {
      switch (index) {
        case 0:
          ref.read(navigatorStateProvider.notifier).state = 0;
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateTo,
            parameters: {
              "navigate_to": FirebaseScreen.homeV2,
              "nav_bar": "true",
            },
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/v4/home', (route) => false);
          break;
        case 1:
          ref.read(navigatorStateProvider.notifier).state = 1;
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateTo,
            parameters: {
              "navigate_to": FirebaseScreen.simulatorV2,
              "nav_bar": "true",
            },
          );
          Navigator.of(context).pushNamed(
            '/v4/products',
          );
          break;
        case 2:
          ref.read(navigatorStateProvider.notifier).state = 2;
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateTo,
            parameters: {
              "navigate_to": FirebaseScreen.investmentV2,
              "nav_bar": "true",
            },
          );
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/v2/investment', (route) => false);
          break;
        case 3:
          ref.read(navigatorStateProvider.notifier).state = 2;
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateTo,
            parameters: {
              "navigate_to": FirebaseScreen.investmentV2,
              "nav_bar": "true",
            },
          );
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/v2/investment', (route) => false);
          break;
        default:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_v2', (route) => false);
      }
    }

    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(backgroudDark)
              : const Color(backgroudLight),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationButtonV4(
              icon: 'assets/svg_icons/home_icon.svg',
              title: 'Home',
              onTap: () => navigate(context, 0),
              isSelected: selectedIndex == 0 ? true : false,
              isDarkMode: isDarkMode,
            ),
            NavigationButtonV4(
              icon: 'assets/svg_icons/products_icon.svg',
              title: 'Productos',
              onTap: () => navigate(context, 1),
              isSelected: selectedIndex == 1 ? true : false,
              isDarkMode: isDarkMode,
            ),
            NavigationButtonV4(
              icon: 'assets/svg_icons/nav_bar_invest_icon.svg',
              title: 'Inversiones',
              onTap: () => navigate(context, 2),
              isSelected: selectedIndex == 2 ? true : false,
              isDarkMode: isDarkMode,
            ),
            NavigationButtonV4(
              icon: 'assets/svg_icons/notices_icon.svg',
              title: 'noticias',
              onTap: () => navigate(context, 1),
              isSelected: selectedIndex == 1 ? true : false,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButtonV4 extends StatelessWidget {
  final dynamic icon;
  final String title;
  final Function() onTap;
  final bool isSelected;
  final bool isDarkMode;

  const NavigationButtonV4({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    const int selectDark = 0xff0D3A5C;
    const int selectLight = 0xffA2E6FA;
    const int backgroudDark = 0xff0A304D;
    const int backgroudLight = 0xffC0F1FF;

    return Container(
      margin: const EdgeInsets.all(5),
      width: 80,
      height: 58,
      decoration: BoxDecoration(
        color: isSelected
            ? isDarkMode
                ? const Color(selectDark)
                : const Color(selectLight)
            : isDarkMode
                ? const Color(backgroudDark)
                : const Color(backgroudLight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(),
                if (isSelected)
                  Text(
                    title,
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      fontSize: 8,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    const int iconDark = 0xff4C8DBE;
    const int iconLight = 0xff4C8DBE;
    const int iconSelectDark = 0xffA2E6FA;
    const int iconSelectLight = 0xff0D3A5C;
    final color = isSelected
        ? isDarkMode
            ? const Color(iconSelectDark)
            : const Color(iconSelectLight)
        : isDarkMode
            ? const Color(iconDark)
            : const Color(iconLight);

    if (icon is IconData) {
      return Icon(icon as IconData, color: color);
    } else if (icon is String) {
      return SvgPicture.asset(
        icon,
        color: color,
        width: 24,
        height: 24,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
