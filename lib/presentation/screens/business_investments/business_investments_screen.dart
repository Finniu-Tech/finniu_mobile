import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/see_calendar.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BusinessInvestmentsScreen extends HookConsumerWidget {
  const BusinessInvestmentsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    final isVisible = useState<bool>(false);

    void hideNoInvestmentBody() {
      isVisible.value = false;
    }

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const BodyScaffold(),
            if (isVisible.value)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.85,
                child: const ModalBarrier(
                  dismissible: false,
                ),
              ),
            isVisible.value
                ? Positioned(
                    child: NoInvestmentBody(onPressed: hideNoInvestmentBody),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BodyScaffold extends ConsumerWidget {
  const BodyScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    return Container(
      color: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnterpriseFundTitle(),
            SizedBox(height: 15),
            GraphicContainer(),
            SizedBox(height: 10),
            SeeCalendar(),
            SizedBox(height: 10),
            TextPoppins(
              text: "Historial de inversiones",
              fontSize: 16,
              isBold: true,
            ),
            SizedBox(height: 10),
            TabBarBusiness(),
          ],
        ),
      ),
    );
  }
}
