import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:finniu/infrastructure/datasources/transferences_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/transferences_provider.dart';
import 'package:finniu/presentation/screens/settings/widgets.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class TransfersScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomScaffoldReturnLogo(
      hideReturnButton: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  const SizedBox(
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const IconContainer(
                    image: 'assets/transfers/wallet.png',
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Mis últimas transferencias',
                    style: TextStyle(
                        fontSize: 14,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   height: 3,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: currentTheme.isDarkMode
            //             ? const Color(primaryLight)
            //             : const Color(gradient_secondary_option),
            //         width: 2,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 5),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     'Tus últimas transferencias de inversion realizadas en Finniu',
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //       fontSize: 12,
            //       height: 1.5,
            //       color: currentTheme.isDarkMode
            //           ? const Color(whiteText)
            //           : const Color(blackText),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),
            HookBuilder(
              builder: (context) {
                final transferences = ref.watch(transferenceFutureProvider);
                return transferences.when(
                  data: (transferences) {
                    if (transferences.length == 0) {
                      return EmptyTransference();
                    } else {
                      return TransfersScreenListWidget(
                        transferences: transferences,
                      );
                    }
                  },
                  error: ((error, stackTrace) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  }),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TransfersScreenListWidget extends HookConsumerWidget {
  final List<TransferenceEntity> transferences;
  TransfersScreenListWidget({required this.transferences});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      child: Column(
        children: [
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
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 290,
              child: Text(
                'Tus últimas transferencias de inversión realizadas en Finniu',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 310,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: transferences.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: TransferenceItem(
                    planName: transferences[index].planName,
                    imageUrl: transferences[index].urlVoucher,
                    dateSended: transferences[index].date,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransferenceItem extends ConsumerWidget {
  final String imageUrl;
  final String planName;
  final DateTime dateSended;
  const TransferenceItem({
    super.key,
    required this.imageUrl,
    required this.planName,
    required this.dateSended,
  });

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
      height: 74,
      width: MediaQuery.of(context).size.width * 0.8,
      // padding: const EdgeInsets.all(20),
      // margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerRight,
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
            child: GestureDetector(
              onTap: () async {
                // Reemplaza con la URL que deseas abrir
                if (imageUrl.isNotEmpty) {
                  final url = Uri.parse(imageUrl);
                  await launchUrl(url);
                } else {
                  throw 'No se pudo abrir la URL: $imageUrl';
                }
              },
              child: const Image(
                image: AssetImage('assets/transfers/wallet_change.png'),
                width: 24,
                height: 24,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transferencia de ${planName}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                // '29 de Mayo 2022',
                DateFormat('dd MMMM y', 'es').format(dateSended),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          )
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
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            // height: 270,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/transferences.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              children: const [
                SizedBox(height: 30),
                SizedBox(
                  width: 222,
                  child: Text(
                    'Aún no tienes transferencias realizadas',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 220,
                child: Text(
                  'Te invitamos a conocer nuestros planes de inversión',
                  style: TextStyle(
                    fontSize: 14,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 108,
            height: 32,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/plan_list');
              },
              child: const Text(
                style: TextStyle(fontSize: 12),
                'Ver planes',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
