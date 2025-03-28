import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum InvestmentRoute {
  fundDetail,
  step1,
  step2,
}

class ScaffoldInvestment extends StatelessWidget {
  final dynamic body;
  final bool isDarkMode;
  final Color backgroundColor;
  final FundEntity fundEntity;
  final InvestmentRoute currentRoute;
  final Map<String, dynamic>? additionalArgs;

  const ScaffoldInvestment({
    super.key,
    required this.body,
    required this.isDarkMode,
    required this.backgroundColor,
    required this.fundEntity,
    required this.currentRoute,
    this.additionalArgs,
  });

  // void _handleNavigation(BuildContext context, WidgetRef ref) {
  //   switch (currentRoute) {
  //     case InvestmentRoute.step2:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         '/v2/investment/step-1',
  //         arguments: {
  //           'fund': fundEntity,
  //           ...?additionalArgs,
  //         },
  //       );
  //     case InvestmentRoute.step1:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         '/fund_detail',
  //         arguments: {'fund': fundEntity},
  //       );
  //     case InvestmentRoute.fundDetail:
  //       ref.read(navigatorStateProvider.notifier).state = 3;
  //       Navigator.pushReplacementNamed(
  //         context,
  //         '/v4/home',
  //       );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Consumer(
          builder: (context, ref, child) {
            return IconButton(
              icon: Icon(
                color: isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                Icons.arrow_back,
              ),
              onPressed: () => {
                ref.read(navigatorStateProvider.notifier).state = 0,
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/v4/home',
                  (route) => false,
                )
              },
            );
          },
        ),
      ),
      body: body,
    );
  }
}

// class ScaffoldInvestment extends StatelessWidget {
//   final dynamic body;
//   final bool isDarkMode;
//   final Color backgroundColor;
//   final FundEntity fundEntity;

//   const ScaffoldInvestment({
//     super.key,
//     required this.body,
//     required this.isDarkMode,
//     required this.backgroundColor,
//     required this.fundEntity,
//   });
//   @override
//   Widget build(BuildContext context) {
//     // final themeProvider = ref.watch(settingsNotifierProvider);

//     return Scaffold(
//       // backgroundColor: Theme.of(context).colorScheme.surface,
//       backgroundColor: backgroundColor,
//       // bottomNavigationBar: !hideNavBar ? const NavigationBarHome() : null,
//       // bottomNavigationBar: !hideNavBar ? const BottomNavigationBarHome() : null,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         // backgroundColor: Theme.of(context).colorScheme.surface,
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             color: isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
//             Icons.arrow_back,
//           ),
//           onPressed: () {
//             Navigator.pushReplacementNamed(
//               context,
//               '/fund_detail', // o '/ruta_anterior'
//               arguments: {'fund': fundEntity},
//             );

//             // Navigator.of(context).popUntil((route) => route.isFirst);
//           },
//           // onPressed: () => Navigator.of(context)
//           //     .pushNamedAndRemoveUntil("/home_v2", (route) => false),
//         ),
//       ),
//       body: body,
//     );
//   }
// }
