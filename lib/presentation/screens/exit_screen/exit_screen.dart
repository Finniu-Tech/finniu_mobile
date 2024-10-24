import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/utils/log_out.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExitScreen extends HookConsumerWidget {
  const ExitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    // const int backgroundLight = 0xffA2E6FA;
    const int backgroundLight = 0xffFFFFFF;
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          logOut(context, ref);
        });
      });

      return null;
    }, []);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image(
                  image: AssetImage(
                    isDarkMode ? "assets/images/logo_finniu_dark.png" : "assets/images/logo_finniu_light.png",
                  ),
                ),
              ),
              const TextPoppins(
                text: 'Cerrando Sesión',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textDark: backgroundLight,
                textLight: backgroundDark,
              ),
              const SizedBox(height: 20.0),
              const TextPoppins(
                text: 'Vive el #ModoFinniu',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textDark: backgroundLight,
                textLight: backgroundDark,
              ),
              const SizedBox(height: 20.0),
              const CircularLoader(width: 40, height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
