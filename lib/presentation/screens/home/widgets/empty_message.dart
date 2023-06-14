import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmptyReportMessage extends ConsumerWidget {
  const EmptyReportMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/layerblur.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 180,
            constraints: const BoxConstraints(
              maxWidth: 390,
              maxHeight: 180,
            ),
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLightAlternative)
                  : const Color(0xffFFEEDD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Image.asset(
                    'assets/images/bomb.png',
                    width: 98,
                    height: 98,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Comienza a multiplicar tu dinero con nosotros',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(blackText),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Visita nuestros planes de inversión',
                          style:
                              TextStyle(fontSize: 11, color: Color(blackText)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              // Button action
                              Navigator.pushNamed(context, '/plan_list');
                            },
                            child: const Text('Ver Planes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
