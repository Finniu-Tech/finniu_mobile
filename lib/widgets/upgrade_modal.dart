import 'dart:io';
import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation/screens/login/start_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpgradeAppDialog extends HookConsumerWidget {
  final Uri playStoreUrl =
      Uri.parse('https://play.google.com/store/apps/details?id=com.finniu');
  final Uri appStoreUrl =
      Uri.parse('https://apps.apple.com/pe/app/finniu/id6449205870');
  final String appVersion;

  UpgradeAppDialog({super.key, required this.appVersion});

  Future<void> _openAppStore() async {
    if (Platform.isAndroid) {
      launchUrl(playStoreUrl);
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
            'Hay una nueva versión de la aplicación disponible, te recomendamos actualizarla para disfrutar de todas las nuevas funcionalidades!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(blackText),
            ),
          ),
          const SizedBox(height: 20),
          Text('Versión actual: $appVersion'),
          Text('Nueva versión: 1.0.0'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => StartLoginScreen(),
                    ),
                  );
                  // Navigator.of(context).pushNamed('/login_start');
                },
                child: Text('Continuar'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  _openAppStore();
                },
                child: Text('Actualizar'),
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
