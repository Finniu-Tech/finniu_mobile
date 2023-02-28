import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

class TransfersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/transfers/credit.png',
                    width: 90,
                    height: 90,
                  ),
                  // SizedBox(width: 10),
                  Text(
                    "Mis Transferencias",
                    style: TextStyle(fontSize: 24, color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          // width: 46.48,
                          // height: 34.87,
                          decoration: BoxDecoration(
                            color: Color(primaryDark),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            color: Color(cardBackgroundColorLight),
                            'assets/transfers/wallet_change.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Mis últimas transferencias', style: TextStyle(fontSize: 14, color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                )),
              ),
              Container(
                width: 270,
                height: 3,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(gradient_secondary_option),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Tus últimas transferencias de inversion realizadas en Finniu',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12, height: 1.5, color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TransferenceList(),
              EmptyTransference(),
            ])));
  }
}

class TransferenceList extends ConsumerWidget {
  const TransferenceList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
        alignment: Alignment.centerRight,
        width: 274.0,
        height: 74.0,
        decoration: BoxDecoration(
          color: currentTheme.isDarkMode ? const Color(gradient_primary) : const Color(gradient_secondary),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 18.0,
            ),
            child: Image(
              image: AssetImage(
                'assets/transfers/wallet_change.png',
              ),
              width: 24,
              height: 24,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Transferencia de Plan Origen',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '29 de Mayo 2022',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ])
        ]));
  }
}

class EmptyTransference extends ConsumerWidget {
  const EmptyTransference({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Expanded(
      child: Container(
        width: double.infinity,
        height: 274,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/transferences.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aun no tienes transferencias realizadas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            CustomButton(
              text: 'Ver planes',
              width: 108,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
