import 'dart:io';
import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation/screens/login/start_screen.dart';

class UpgradeAppDialog extends HookConsumerWidget {
  final Uri playStoreUrl =
      Uri.parse('https://play.google.com/store/apps/details?id=com.finniu');
  final Uri appStoreUrl =
      Uri.parse('https://apps.apple.com/pe/app/finniu/id6449205870');

  final String textMinorUpdate =
      'Hay una nueva versión de la aplicación disponible, te recomendamos actualizarla para disfrutar de todas las nuevas funcionalidades!';
  final String textMajorUpdate =
      'Hay una nueva versión de la aplicación disponible, es necesario actualizarla para continuar disfrutando de todas las nuevas funcionalidades!';
  final bool forcedUpgrade;

  UpgradeAppDialog({super.key, required this.forcedUpgrade});

  Future<void> _openAppStore() async {
    if (Platform.isAndroid) {
      launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    } else if (Platform.isIOS) {
      launchUrl(appStoreUrl);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: const Color(primaryLightAlternative),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/finniu_logo.png',
            width: 100,
          ),
          Text(
            forcedUpgrade ? textMajorUpdate : textMinorUpdate,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(blackText),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !forcedUpgrade
                  ? OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StartLoginScreen(),
                          ),
                        );
                        // Navigator.of(context).pushNamed('/login_start');
                      },
                      child: const Text('Continuar'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  : SizedBox(width: 20),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _openAppStore();
                },
                child: const Text('Actualizar'),
                style: TextButton.styleFrom(
                  fixedSize: const Size(100, 30),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
