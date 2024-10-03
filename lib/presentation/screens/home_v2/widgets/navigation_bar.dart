import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/button_to_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_v2', (route) => false);
          break;
        case 1:
          ref.read(navigatorStateProvider.notifier).state = 1;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/v2/simulator', (route) => false);
          break;
        case 2:
          ref.read(navigatorStateProvider.notifier).state = 2;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/v2/investment', (route) => false);
          break;
        default:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_home', (route) => false);
      }
    }

    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.7,
      constraints: const BoxConstraints(maxWidth: 350),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        // color: colorBackground ??
        //     (currentTheme.isDarkMode
        //         ? const Color(backgroundColorNavbar)
        //         : const Color(scaffoldLightGradientSecondary)),
      ),
      child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        // padding: EdgeInsets.fromLTRB(60, 0, 60, 45),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 45),
        child: Container(
          decoration: BoxDecoration(
            color: currentTheme.isDarkMode
                ? const Color(bottomBarBackgroundDark)
                : const Color(bottomBarBackgroundLight),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationButton(
                icon: 'assets/svg_icons/home_icon.svg',
                title: 'Home',
                onTap: () => navigate(context, 0),
                isSelected: selectedIndex == 0 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: 'assets/svg_icons/dollar-circle.svg',
                title: 'Simulador',
                onTap: () => navigate(context, 1),
                isSelected: selectedIndex == 1 ? true : false,
                currentTheme: currentTheme,
              ),
              NavigationButton(
                icon: 'assets/svg_icons/chart_bar_icon.svg',
                title: 'Historial',
                onTap: () => navigate(context, 2),
                isSelected: selectedIndex == 2 ? true : false,
                currentTheme: currentTheme,
              ),
              const ButtonToProfile(
                size: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NavigationBarInvestment extends ConsumerWidget {
//   const NavigationBarInvestment({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(navigatorStateProvider);
//     final currentTheme = ref.watch(settingsNotifierProvider);

//     void navigate(BuildContext context, int index) {
//       switch (index) {
//         case 0:
//           ref.read(navigatorStateProvider.notifier).state = 0;
//           Navigator.of(context).pushNamedAndRemoveUntil('/home_v2', (route) => false);
//           break;
//         case 1:
//           ref.read(navigatorStateProvider.notifier).state = 1;

//           break;
//         case 2:
//           ref.read(navigatorStateProvider.notifier).state = 2;
//           Navigator.of(context).pushNamedAndRemoveUntil('/process_investment', (route) => false);
//           break;
//         default:
//           ref.read(navigatorStateProvider.notifier).state = 0;
//           Navigator.of(context).pushNamedAndRemoveUntil('/home_home', (route) => false);
//       }
//     }

//     return SizedBox(
//       height: 80,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//         child: Container(
//           decoration: BoxDecoration(
//             color:
//                 currentTheme.isDarkMode ? const Color(bottomBarBackgroundDark) : const Color(bottomBarBackgroundLight),
//             borderRadius: const BorderRadius.all(Radius.circular(30)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               NavigationButton(
//                 icon: 'assets/svg_icons/home_icon.svg',
//                 title: 'Home',
//                 onTap: () => navigate(context, 0),
//                 isSelected: selectedIndex == 0 ? true : false,
//                 currentTheme: currentTheme,
//               ),
//               NavigationButton(
//                 icon: 'assets/svg_icons/dollar_icon_svg.svg',
//                 title: 'Inversion',
//                 onTap: () => navigate(context, 1),
//                 isSelected: selectedIndex == 1 ? true : false,
//                 currentTheme: currentTheme,
//               ),
//               NavigationButton(
//                 icon: 'assets/svg_icons/chart_bar_icon.svg',
//                 title: 'Inversión',
//                 onTap: () => navigate(context, 2),
//                 isSelected: selectedIndex == 2 ? true : false,
//                 currentTheme: currentTheme,
//               ),
//               const ProfileButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class NavigationButton extends StatelessWidget {
  final dynamic icon;
  final String title;
  final Function() onTap;
  final bool isSelected;
  final dynamic currentTheme;

  const NavigationButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 80,
      height: 58,
      decoration: BoxDecoration(
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
                      color: currentTheme.isDarkMode
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
    final color = isSelected
        ? currentTheme.isDarkMode
            ? const Color(primaryLight)
            : const Color(primaryDark)
        : currentTheme.isDarkMode
            ? const Color(colorIconlight)
            : const Color(colorIconlight);

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
      return const SizedBox
          .shrink(); // Fallback if icon is neither IconData nor String
    }
  }
}


// class NavigationButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Function() onTap;
//   final bool isSelected;
//   final currentTheme;

//   const NavigationButton({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//     required this.isSelected,
//     required this.currentTheme,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(5),
//       width: 80,
//       height: 58,
//       decoration: BoxDecoration(
//         // color: isSelected ? const Color(backgroundColorNavbar) : const Color(primaryDark),

//         color: isSelected
//             ? currentTheme.isDarkMode
//                 ? const Color(primaryDark)
//                 : const Color(gradient_primary)
//             : currentTheme.isDarkMode
//                 ? const Color(bottomBarBackgroundDark)
//                 : const Color(bottomBarBackgroundLight),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         children: [
//           IconButton(
//             onPressed: onTap,
//             icon: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   icon,
//                   color: isSelected
//                       ? currentTheme.isDarkMode
//                           ? const Color(primaryLight)
//                           : const Color(primaryDark)
//                       : currentTheme.isDarkMode
//                           ? const Color(colorIconlight)
//                           : const Color(colorIconlight),
//                 ),
//                 isSelected
//                     ? Text(
//                         title,
//                         style: TextStyle(
//                           color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
//                           fontSize: 7,
//                         ),
//                       )
//                     : const SizedBox(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
