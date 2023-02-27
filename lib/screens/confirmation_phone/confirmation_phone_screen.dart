import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class Confirmation_Phone extends ConsumerWidget {
  const Confirmation_Phone({super.key});

  get numerotelefonicoController => null;

  get numerotelefonicoValidator => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    if (currentTheme.showWelcomeModal) {
      showWelcomeModal(context, ref);
    }
    return CustomScaffoldReturn(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        const SizedBox(height: 90),
        Stack(
          children: <Widget>[
            Container(
              width: 276,
              height: 70,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Text(
                'Confirmación de número telefónico',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(Theme.of(context).colorScheme.secondary.value),
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: 246,
                height: 99,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 65),
                decoration: BoxDecoration(
                  color: Color(gradient_secondary),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Hola Mari queremos enviarte un SMS de tu código de verificación por favor confirmanos tu numero telefonico.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 30,
                left: 160,
                child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        width: 65, // ancho deseado de la imagen
                        height: 61, // alto deseado de la imagen
                        child: Image(
                          image: AssetImage('assets/forgotpassword/letter.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )))
          ],
        ),
        SizedBox(
          height: 35,
        ),
        SizedBox(
          width: 224,
          child: TextFormField(
            controller: numerotelefonicoController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Este dato es requerido';
              }
              if (numerotelefonicoValidator.validate(value) == false) {
                return 'Ingrese un telefono válido';
              }
              return null;
            },
            onChanged: (value) {
              // emailController.text = value.toString();
            },
            decoration: const InputDecoration(
              hintText: 'Escriba su número telefónnico',
              label: Text('Número telefónico'),
            ),
          ),
        ),
        SizedBox(
          height: 120,
        ),
        SizedBox(
          width: 224,
          height: 50,
          child: TextButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/showModalBottomSheet');
              BottomSheetExample();
            },
            child: Text('Enviar SMS'),
          ),
        ),
      ],
    )));
  }
}

// void main() => runApp(const BottomSheetApp());

// class BottomSheetApp extends StatelessWidget {
//   const BottomSheetApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Bottom Sheet Sample')),
//         body: const BottomSheetExample(),
//       ),
//     );
//   }
// }

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text('Enviar SMS'),
    ));
  }
}

void showWelcomeModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  Future.delayed(const Duration(seconds: 1), () async {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
        ),
      ),
      elevation: 10,
      backgroundColor: themeProvider.isDarkMode ? const Color(primaryDark) : const Color(cardBackgroundColorLight),
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
                    color: Color(primaryDark),
                    borderRadius: BorderRadius.circular(25),
                  )),
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
                        color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
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
                        color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                      ),
                      "Te hemos enviado un SMS a tu numero para confirmar la operacion"),
                ),
                const SizedBox(height: 10),
                VerificationCode(
                  onCompleted: (value) {
                    Navigator.of(ctx).pushNamed('/on_boarding_start');
                  },
                  onEditing: (value) {},
                  textStyle: Theme.of(ctx).textTheme.bodyText2!.copyWith(color: Theme.of(ctx).primaryColor),
                  keyboardType: TextInputType.number,
                  underlineColor: Color(0xff9381FF), // If this is null it will use primaryColor: Colors.red from Theme
                  length: 4,
                  fullBorder: true,
                  cursorColor: Colors.blue, // If this is null it will default to the ambient
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  // clearAll: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     'clear all',
                  //     style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: Colors.blue[700]),
                  //   ),
                  // ),
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
                        color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                      ),
                      "Reenviar el codigo en"),
                ),
                SizedBox(height: 15),

                CircularCountdown(),
              ],
            ),
          ),
        )),
      ),
    );
  });
}

class CircularCountdown extends StatelessWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      child: CircularCountDownTimer(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        duration: 60,
        ringColor: Colors.grey[300]!,
        fillColor: Color(primaryDark),
        backgroundColor: Color(cardBackgroundColorLight),
        strokeWidth: 6.0,
        textStyle: TextStyle(
          fontSize: 25.0,
          color: Color(primaryDark),
          fontWeight: FontWeight.bold,
        ),
        textFormat: CountdownTextFormat.S,
        onComplete: () {
          debugPrint('Countdown Ended');
        },
      ),
    );
  }
}
