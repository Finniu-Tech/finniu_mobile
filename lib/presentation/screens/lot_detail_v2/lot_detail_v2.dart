import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/widget/harvest_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LotDetailScreenV2 extends ConsumerWidget {
  const LotDetailScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(
        title: "",
      ),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [_BodyScaffold()],
        ),
      ),
    );
  }
}

class _BodyScaffold extends StatelessWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBody(),
          SizedBox(
            height: 10,
          ),
          _HarvestDate(),
          SizedBox(
            height: 10,
          ),
          HarvestStatus(),
        ],
      ),
    );
  }
}

class _HarvestDate extends ConsumerWidget {
  const _HarvestDate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff000000;
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: isDarkMode
              ? const Color(subTitleDark)
              : const Color(subTitleLight),
        ),
        const SizedBox(
          width: 5,
        ),
        const TextPoppins(
          text: "14 de Junio 2024",
          fontSize: 16,
          textDark: subTitleDark,
          textLight: subTitleLight,
          isBold: true,
        ),
      ],
    );
  }
}

class _TitleBody extends StatelessWidget {
  const _TitleBody();

  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return const TextPoppins(
      text: "Cosecha Lote 12",
      fontSize: 24,
      isBold: true,
      textDark: titleDark,
      textLight: titleLight,
    );
  }
}
