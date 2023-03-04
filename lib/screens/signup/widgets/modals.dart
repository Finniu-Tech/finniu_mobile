import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/signup/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void sendSMSModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor: themeProvider.isDarkMode
        ? const Color(primaryDark)
        : const Color(cardBackgroundColorLight),
    context: ctx,
    builder: (ctx) => SizedBox(
      height: MediaQuery.of(ctx).size.height * 0.90,
      // height:\
      //     width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 88, // ancho deseado
                  height: 6,

                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(primaryDark),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                // alto deseado
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset('assets/images/padlock.png'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 280,
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : const Color(primaryDark),
                      ),
                      "Ingresa el codigo de verificacion"),
                ),
                SizedBox(
                  width: 280,
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : const Color(primaryDark),
                      ),
                      "Te hemos enviado un SMS a tu numero para confirmar la operacion"),
                ),
                const SizedBox(height: 10),
                VerificationCode(
                  onCompleted: (value) {
                    Navigator.of(ctx).pushNamed('/on_boarding_start');
                  },
                  onEditing: (value) {},
                  textStyle: Theme.of(ctx)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(ctx).primaryColor),
                  keyboardType: TextInputType.number,
                  underlineColor: const Color(
                      0xff9381FF), // If this is null it will use primaryColor: Colors.red from Theme
                  length: 4,
                  fullBorder: true,
                  cursorColor: Colors
                      .blue, // If this is null it will default to the ambient
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 280,
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : const Color(primaryDark),
                      ),
                      "Reenviar el codigo en"),
                ),
                const SizedBox(height: 15),

                const CircularCountdown(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
