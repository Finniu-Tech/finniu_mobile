import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationBarHome extends ConsumerWidget {
  final Color? colorBackground;
  const NavigationBarHome({super.key, this.colorBackground});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigatorStateProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);

    void navigate(BuildContext context, int index) {
      switch (index) {
        case 0:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context).pushNamedAndRemoveUntil('/home_v2', (route) => false);
          break;
        case 1:
          ref.read(navigatorStateProvider.notifier).state = 1;
          Navigator.of(context).pushNamedAndRemoveUntil('/v2/simulator', (route) => false);
          break;
        case 2:
          ref.read(navigatorStateProvider.notifier).state = 2;
          Navigator.of(context).pushNamedAndRemoveUntil('/v2/investment', (route) => false);
          break;
        default:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context).pushNamedAndRemoveUntil('/home_home', (route) => false);
      }
    }

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorBackground ??
            (currentTheme.isDarkMode
                ? const Color(backgroundColorNavbar)
                : const Color(scaffoldLightGradientSecondary)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color:
                currentTheme.isDarkMode ? const Color(bottomBarBackgroundDark) : const Color(bottomBarBackgroundLight),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationButton(
                icon: Icons.home,
                title: 'Home',
                onTap: () => navigate(context, 0),
                isSelected: selectedIndex == 0 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: Icons.monetization_on_outlined,
                title: 'Simulador',
                onTap: () => navigate(context, 1),
                isSelected: selectedIndex == 1 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: Icons.bar_chart,
                title: 'Historial',
                onTap: () => navigate(context, 2),
                isSelected: selectedIndex == 2 ? true : false,
                currentTheme: currentTheme,
              ),
              const ProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBarInvestment extends ConsumerWidget {
  const NavigationBarInvestment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigatorStateProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);

    void navigate(BuildContext context, int index) {
      switch (index) {
        case 0:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context).pushNamedAndRemoveUntil('/home_v2', (route) => false);
          break;
        case 1:
          ref.read(navigatorStateProvider.notifier).state = 1;
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/business_investment',
            (route) => false,
          );
          break;
        case 2:
          ref.read(navigatorStateProvider.notifier).state = 2;
          Navigator.of(context).pushNamedAndRemoveUntil('/process_investment', (route) => false);
          break;
        default:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context).pushNamedAndRemoveUntil('/home_home', (route) => false);
      }
    }

    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color:
                currentTheme.isDarkMode ? const Color(bottomBarBackgroundDark) : const Color(bottomBarBackgroundLight),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationButton(
                icon: Icons.home,
                title: 'Home',
                onTap: () => navigate(context, 0),
                isSelected: selectedIndex == 0 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: Icons.monetization_on_outlined,
                title: 'Inversion',
                onTap: () => navigate(context, 1),
                isSelected: selectedIndex == 1 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: Icons.bar_chart,
                title: 'Inversión',
                onTap: () => navigate(context, 2),
                isSelected: selectedIndex == 2 ? true : false,
                currentTheme: currentTheme,
              ),
              const ProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;
  final bool isSelected;
  final currentTheme;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.currentTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        // color: isSelected ? const Color(backgroundColorNavbar) : const Color(primaryDark),

        color: isSelected
            ? currentTheme.isDarkMode
                ? const Color(primaryDark)
                : const Color(gradient_primary)
            : currentTheme.isDarkMode
                ? const Color(bottomBarBackgroundDark)
                : const Color(bottomBarBackgroundLight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: onTap,
            icon: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark)
                      : currentTheme.isDarkMode
                          ? const Color(colorIconlight)
                          : const Color(colorIconlight),
                ),
                isSelected
                    ? Text(
                        title,
                        style: TextStyle(
                          color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                          fontSize: 7,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
