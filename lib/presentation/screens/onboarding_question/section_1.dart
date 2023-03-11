// import 'package:finniu/constants/colors.dart';
// import 'package:finniu/presentation/providers/settings_provider.dart';
// import 'package:finniu/widgets/buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class Section1 extends ConsumerWidget {
//   PageController controller = PageController();
//   Section1({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = ref.watch(settingsNotifierProvider);
//     // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
//     return Column(
//       children: [
//         const SizedBox(height: 80),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               child: Image.asset(
//                 'assets/investment/star.png',
//                 width: 40,
//                 height: 40,
//               ),
//             ),
//             SizedBox(
//               width: 228,
//               height: 95,
//               child: Text(
//                 'Selecciona tu rango de edad',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: currentTheme.isDarkMode
//                       ? const Color(0xffA2E6FA)
//                       : const Color(primaryDark),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         ButtonQuestions(text: "18-25 años", controller: controller),
//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(text: "25-35 años", controller: controller),

//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(text: "35-45 años", controller: controller),

//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(text: "45-50 años", controller: controller),

//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(text: "55-65 años", controller: controller),

//         const SizedBox(
//           height: 5,
//         ),
//         // const CustomButton(
//         //   text: 'Continuar',
//         //   width: 224,
//         //   height: 50,
//         //   pushName: '/investment_result',
//         // ),
//       ],
//     );
//   }
// }
