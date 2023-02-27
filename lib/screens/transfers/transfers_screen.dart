import 'package:finniu/providers/settings_provider.dart';
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
                    style: TextStyle(
                        fontSize: 24,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        fontWeight: FontWeight.bold),
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
                        Text('Mis últimas transferencias',
                            style: TextStyle(
                                fontSize: 14,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontWeight: FontWeight.bold)),
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
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  width: 274.0,
                  height: 74.0,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(gradient_primary)
                        : const Color(gradient_secondary),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Image(
                            image: AssetImage(
                              'assets/transfers/wallet_change.png',
                            ),
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ])
                      ]))
            ])));
  }
}
