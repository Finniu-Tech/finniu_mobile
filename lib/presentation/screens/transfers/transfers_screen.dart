import 'package:finniu/presentation/screens/settings/widgets.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransfersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
      child: Padding(
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
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      IconContainer(
                        image: 'assets/transfers/wallet.png',
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: 3,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(gradient_secondary_option),
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
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
            TransferenceList(),
            // EmptyTransference(),
          ])),
    ));
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
        color: currentTheme.isDarkMode
            ? const Color(gradient_primary)
            : const Color(gradient_secondary),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ])
        ],
      ),
    );
  }
}

class EmptyTransference extends ConsumerWidget {
  const EmptyTransference({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
      alignment: Alignment.bottomLeft,
      // height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/transferences.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150),
          Container(
            width: 210,
            child: Text(
              'Aún no tienes transferencias realizadas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 210,
          ),
          Column(
            children: [
              Text(
                'Te invitamos a conocer nuestros planes de inversion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          CustomButton(
            text: 'Ver planes',
            width: 108,
            height: 32,
          ),
        ],
      ),
    );
  }
}
