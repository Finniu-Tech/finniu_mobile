import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/bottom_menu.dart';
import 'package:finniu/presentation/providers/investment_status_report_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FinishInvestment extends ConsumerWidget {
  const FinishInvestment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextPoppins(
                text: '¡Sigue cumpliendo tus metas financieras!',
                colorText: currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 360,
                      maxHeight: 212,
                    ),
                    child: Image.asset(
                      'assets/images/hands_shake.png',
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: SizedBox(
                      width: 111,
                      child: Image.asset(
                        'assets/images/finniu_logo.png',
                        color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 320,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 252,
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Recuerda que te enviaremos tu contrato luego de confirmar tu transferencia',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 13,
                      child: Image.asset(
                        'assets/icons/letter.png',
                        width: 35,
                        height: 35,
                        color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () async {
                  ref.read(navigatorStateProvider.notifier).state = BottomMenuEnum().investments.index;
                  Navigator.pushNamedAndRemoveUntil(context, '/process_investment', (route) => false);
                },
                child: const Text(
                  'Ir a Mis Inversiones',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
