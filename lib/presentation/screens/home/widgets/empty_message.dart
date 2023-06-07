import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmptyReportMessage extends ConsumerWidget {
  const EmptyReportMessage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 162,
      constraints: const BoxConstraints(
        maxWidth: 330,
        maxHeight: 162,
      ),
      decoration: BoxDecoration(
        // color: const Color(0xffFFEEDD),
        color: currentTheme.isDarkMode
            ? const Color(primaryLightAlternative)
            : const Color(0xffFFEEDD),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Comienza a multiplicar tu dinero con nosotros ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(primaryDark),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Visita nuestros planes de inversión ',
            style: TextStyle(fontSize: 11, color: Color(primaryDark)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Button action
              Navigator.pushNamed(context, '/plan_list');
            },
            child: const Text('Ver Planes'),
          ),
        ],
      ),
    );
  }
}
