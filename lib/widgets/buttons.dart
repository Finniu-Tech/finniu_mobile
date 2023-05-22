import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomButton extends ConsumerStatefulWidget {
  final int? colorBackground;
  final int? colorText;
  final String text;
  final String pushName;
  final String? image;
  final double width;
  final double height;
  final Color? imageColor;

  CustomButton({
    super.key,
    required this.text,
    this.colorBackground,
    this.colorText,
    this.pushName = "",
    this.width = 224,
    this.height = 50,
    this.image,
    this.imageColor,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends ConsumerState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    Color colorBackground;
    if (widget.colorBackground == null) {
      colorBackground = Theme.of(context)
          .textButtonTheme
          .style!
          .backgroundColor!
          .resolve({MaterialState.pressed})!;
    } else {
      colorBackground = Color(widget.colorBackground!);
    }

    Color textColor;
    if (widget.colorText == null) {
      textColor = Theme.of(context)
          .textButtonTheme
          .style!
          .foregroundColor!
          .resolve({MaterialState.pressed})!;
    } else {
      textColor = Color(widget.colorText!);
    }

    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(widget.width, widget.height),
        backgroundColor: colorBackground,
        foregroundColor: textColor,
      ),
      onPressed: () {
        if (widget.pushName != "") {
          Navigator.pushNamed(context, widget.pushName);
        }
      },
      child: widget.image != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text),
                SizedBox(width: 10),
                Image.asset(
                  widget.image!,
                  width: 20,
                  height: 20,
                  color: widget.imageColor,
                ),
              ],
            )
          : Text(widget.text),
    );
  }
}

class CustomReturnButton extends ConsumerWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton({
    super.key,
    this.colorBoxdecoration = primaryDark,
    this.colorIcon = primaryLight,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(
            currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Color(
              currentTheme.isDarkMode ? (primaryDark) : (primaryLight),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonRoundedDark extends ConsumerWidget {
  @override
  final String pushName;

  const CustomButtonRoundedDark({
    super.key,
    this.pushName = "",
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (pushName != "") {
          Navigator.pushNamed(context, pushName);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 28.67,
        height: 28.67,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.transparent,
          border: Border.all(
            color: const Color(primaryDark),
          ),
        ),
        child: const Center(
          child: Icon(
            size: 20,
            color: Color(primaryDark),
            Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}

class CusttomButtonRoundedLight extends StatefulWidget {
  @override
  final String pushName;
  final bool isReturn;

  const CusttomButtonRoundedLight({
    super.key,
    this.pushName = "",
    this.isReturn = false,
  });
  _CusttomButtonRoundedLightState createState() =>
      _CusttomButtonRoundedLightState();
}

class _CusttomButtonRoundedLightState extends State<CusttomButtonRoundedLight> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isReturn == true) {
          Navigator.of(context).pop();
        } else {
          Navigator.pushNamed(context, widget.pushName);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(primaryLight),
        ),
        child: const Center(
          child: Icon(
              size: 20, color: Color(primaryDark), Icons.arrow_back_outlined),
        ),
      ),
    );
  }
}

class BottomNavigationBarHome extends ConsumerWidget {
  const BottomNavigationBarHome({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          // adjust to your liking
        ),
        color: currentTheme.isDarkMode
            ? const Color(primaryLight)
            : const Color(
                primaryDark,
              ),
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: currentTheme.isDarkMode
            ? const Color(primaryDark)
            : const Color(
                primaryLight,
              ),
        unselectedItemColor: currentTheme.isDarkMode
            ? const Color(primaryDark)
            : const Color(
                primaryLight,
              ).withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home_home');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  'assets/icons/home.png',
                  width: 30,
                  height: 30,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(
                          primaryLight,
                        ),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Planes',
            icon: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/plan_list');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  'assets/icons/square.png',
                  width: 30,
                  height: 30,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(
                          primaryLight,
                        ),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Inversiones',
            icon: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/process_investment');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  'assets/icons/dollar.png',
                  width: 30,
                  height: 30,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(
                          primaryLight,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class BottomNavigationBarHome extends ConsumerWidget {
//   const BottomNavigationBarHome({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = ref.watch(settingsNotifierProvider);
//     // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//           // adjust to your liking
//         ),
//         color: currentTheme.isDarkMode
//             ? const Color(primaryLight)
//             : const Color(
//                 primaryDark,
//               ),
//       ),
//       child: BottomNavigationBar(
//         elevation: 0.0,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.transparent,
//         selectedItemColor: currentTheme.isDarkMode
//             ? const Color(primaryDark)
//             : const Color(
//                 primaryLight,
//               ),
//         unselectedItemColor: currentTheme.isDarkMode
//             ? const Color(primaryDark)
//             : const Color(
//                 primaryLight,
//               ).withOpacity(.60),
//         selectedFontSize: 14,
//         unselectedFontSize: 14,
//         onTap: (value) {
//           // Respond to item press.
//         },
//         items: [
//           BottomNavigationBarItem(
//             label: 'Home',
//             icon: GestureDetector(
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, '/home_home');
//                 // Navigator.of(context).pushNamedAndRemoveUntil(
//                 //   '/home_home',
//                 //   (route) => true,
//                 // );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 50, right: 50),
//                 child: Image.asset(
//                   'assets/icons/home.png',
//                   width: 30,
//                   height: 30,
//                   color: currentTheme.isDarkMode
//                       ? const Color(primaryDark)
//                       : const Color(
//                           primaryLight,
//                         ),
//                 ),
//               ),
//             ),
//           ),
//           BottomNavigationBarItem(
//             label: 'Planes',
//             icon: GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 50, right: 50),
//                 child: Image.asset(
//                   'assets/icons/square.png',
//                   width: 30,
//                   height: 30,
//                   color: currentTheme.isDarkMode
//                       ? const Color(primaryDark)
//                       : const Color(
//                           primaryLight,
//                         ),
//                 ),
//               ),
//               onTap: () {
//                 // Navigator.of(context).pushNamedAndRemoveUntil(
//                 //   '/plan_list',
//                 //   (route) => true,
//                 // );
//                 Navigator.pushReplacementNamed(context, '/plan_list');
//               },
//             ),
//           ),
//           BottomNavigationBarItem(
//               label: 'Inversiones',
//               icon: GestureDetector(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 50, right: 50),
//                   child: Image.asset(
//                     'assets/icons/dollar.png',
//                     width: 30,
//                     height: 30,
//                     color: currentTheme.isDarkMode
//                         ? const Color(primaryDark)
//                         : const Color(
//                             primaryLight,
//                           ),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacementNamed(
//                       context, '/process_investment');
//                   // Navigator.of(context).pushNamedAndRemoveUntil(
//                   //   '/process_investment',
//                   //   (route) => true,
//                   // );
//                 },
//               )),
//         ],
//       ),
//     );
//   }
// }
