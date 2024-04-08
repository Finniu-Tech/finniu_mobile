// I need a bottomSheetModal where  start with a image at center top, then have a title  , then it show two button bottom, one for cancel and other for accept

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void reinvestmentQuestionModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor: themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,
    context: ctx,
    builder: (ctx) => ReinvestmentQuestionBody(themeProvider: themeProvider),
  );
}

class ReinvestmentQuestionBody extends HookConsumerWidget {
  const ReinvestmentQuestionBody({
    super.key,
    required this.themeProvider,
  });

  final SettingsProviderState themeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return Container(
      // customize background color
      color: themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,

      height: MediaQuery.of(context).size.height * 0.70,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset('assets/reinvestment/avatar_with_money.png'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                ),
                "¡Muchas gracias por tu interés de reinvertir en Finniu!",
              ),
            ),

            const SizedBox(height: 20),
            // row with two lines and text in the middle of lines
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //container with a line
                  Container(
                    width: 70,
                    height: 1,
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                  ),
                  const SizedBox(width: 10),
                  //text in the middle of lines
                  Text(
                    "Elige tu opción reinversión",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //container with a line
                  Container(
                    width: 70,
                    height: 1,
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // TWO BUTTONS ONE OVER OTHER

            // first button
            SizedBox(
              width: 220,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  backgroundColor: Color(
                    themeProvider.isDarkMode ? primaryLight : primaryDark,
                  ),
                ),
                child: Text(
                  'Aumentar mi capital',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: themeProvider.isDarkMode ? Color(primaryDark) : Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                    width: 1,
                  ),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  backgroundColor:
                      themeProvider.isDarkMode ? const Color(primaryDark) : const Color(backgroundColorLight),
                ),
                child: Text(
                  'Reinvertir el mismo capital',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: themeProvider.isDarkMode ? Colors.white : Color(primaryDark),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,
                ),
                elevation: MaterialStateProperty.all<double>(0.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Aún no deseo reinvertir',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Color(0xff989797),
                  // color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
