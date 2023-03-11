// import 'package:finniu/constants/colors.dart';
// import 'package:finniu/presentation/providers/settings_provider.dart';
// import 'package:finniu/widgets/buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class Section2 extends ConsumerWidget {
//   PageController controller = PageController();
//   Section2({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = ref.watch(settingsNotifierProvider);
//     // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
//     return Column(
//       children: [
//         const SizedBox(height: 50),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 228,
//               height: 95,
//               child: Text(
//                 '¿Has invertido tu dinero anteriormente?',
//                 textAlign: TextAlign.center,
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
//         Column(
//           children: [
//             SizedBox(
//               child: Image.asset(
//                 'assets/investment/bills.png',
//                 width: 124.38,
//                 height: 89.7,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 14,
//         ),
//         ButtonQuestions(
//             text: "Nunca realicé una inversión ", controller: controller),
//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(
//             text: "Llevo menos de un año invirtiendo", controller: controller),

//         const SizedBox(
//           height: 11,
//         ),
//         ButtonQuestions(
//             text: "Llevo entre 1 a 5 años invirtiendo", controller: controller),

//         const SizedBox(
//           height: 15,
//         ),
//         ButtonQuestions(
//             text: "Llevo más de 5 años invirtiendo", controller: controller),

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
//     ;
//   }
// }
