import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/binnacle/widgets/icon_clip.dart';
import 'package:finniu/presentation/screens/binnacle/widgets/milestones_achieved.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BinnacleScreen extends ConsumerWidget {
  const BinnacleScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleBinnacle(),
            MilestonesAchieved(
              longShort: true,
              title: "Se desembolsó \$800,000.000 a los inversionistas",
              date: "Mayo 2019",
            ),
            SizedBox(
              height: 10,
            ),
            MilestonesAchieved(
              longShort: false,
              title: "Sembramos 1000 \nLotes en el año",
              date: "Septiembre 2020",
            ),
            IconClip(
              character: "🌱",
            ),
            IconClip(
              character: "💸",
            ),
            IconClip(
              character: "🫐",
            ),
            IconClip(
              character: "📌",
            ),
            IconClip(
              character: "👥",
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBinnacle extends StatelessWidget {
  const TitleBinnacle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Center(
        child: TextPoppins(
          text: "Conoce nuestros hitos logrados",
          fontSize: 20,
          isBold: true,
        ),
      ),
    );
  }
}
