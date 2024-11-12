import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/binnacle/widgets/icon_clip.dart';
import 'package:finniu/presentation/screens/binnacle/widgets/milestones_achieved.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BinnacleScreen extends ConsumerWidget {
  const BinnacleScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    const int lineColorDark = 0xff052E5C;
    const int lineColorLight = 0xffB1D6FF;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleBinnacle(),
            SizedBox(
              width: 300,
              height: 530,
              child: Stack(
                children: [
                  Positioned(
                    left: 80,
                    height: 460,
                    child: Container(
                      width: 5,
                      height: 50,
                      color: isDarkMode
                          ? const Color(lineColorDark)
                          : const Color(lineColorLight),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RowMilestones(
                        year: "2018",
                        longShort: false,
                        title: "Cosecha de 120 Lotes",
                        date: "Julio 2018",
                        character: "🫐",
                      ),
                      SizedBox(height: 10),
                      RowMilestones(
                        year: "2019",
                        longShort: false,
                        title: "Sembramos 1000 Lotes en el año",
                        date: "Mayo 2019",
                        character: "🌱",
                      ),
                      SizedBox(height: 10),
                      RowMilestones(
                        year: "2020",
                        longShort: false,
                        title: "Aumentó un 25% de cosecha.",
                        date: "Septiembre 2020",
                        character: "🌱",
                      ),
                      SizedBox(height: 10),
                      RowMilestones(
                        year: "2021",
                        longShort: true,
                        title:
                            "Se desembolsó \$800,000.000 a los inversionistas",
                        date: "Febrero 2021",
                        character: "💸",
                      ),
                      SizedBox(height: 10),
                      RowMilestones(
                        year: "2022",
                        longShort: true,
                        title:
                            "Ganamos un reconocimiento en Agroeconomía Peruana",
                        date: "Marzo 2022",
                        character: "📌",
                      ),
                      SizedBox(height: 10),
                      RowMilestones(
                        year: "2023",
                        longShort: true,
                        title: "Incremento de 50% de número de inversionitas ",
                        date: "Diciembre 2023",
                        character: "👥",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowMilestones extends StatelessWidget {
  const RowMilestones({
    super.key,
    required this.year,
    required this.longShort,
    required this.title,
    required this.date,
    required this.character,
  });
  final String year;
  final bool longShort;
  final String title;
  final String date;
  final String character;

  @override
  Widget build(BuildContext context) {
    const int yearDark = 0xff8AC2FF;
    const int yearLight = 0xff000000;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPoppins(
          text: year,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          textDark: yearDark,
          textLight: yearLight,
        ),
        IconClip(
          character: character,
        ),
        MilestonesAchieved(
          longShort: longShort,
          title: title,
          date: date,
        ),
      ],
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
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
