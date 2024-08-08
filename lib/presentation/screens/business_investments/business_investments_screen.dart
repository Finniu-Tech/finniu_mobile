import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/see_calendar.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
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
      body: const SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            RealEstateBody(),
            // if (isVisible.value)
            //   SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.85,
            //     height: MediaQuery.of(context).size.height * 0.85,
            //     child: const ModalBarrier(
            //       dismissible: false,
            //     ),
            //   ),
            // isVisible.value
            //     ? Positioned(
            //         child: NoInvestmentBody(onPressed: hideNoInvestmentBody),
            //       )
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class RealEstateBody extends ConsumerWidget {
  const RealEstateBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userInvestment = ref.watch(userInfoAllInvestmentFutureProvider);
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Container(
      color: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      child: userInvestment.when(
        data: (investment) {
          if (investment != null && investment.hasAnyInvestment() == false) {
            return Stack(
              children: [
                _buildNormalContent(),
                Positioned.fill(
                  child: Container(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7),
                    child: NoInvestmentBody(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home_v2');
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final isReinvest = args != null && args['reinvest'] != null
                ? args['reinvest']
                : false;
            print(isReinvest);
            return _buildNormalContent(isReinvest: isReinvest);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildNormalContent({bool isReinvest = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const GraphicContainer(),
          const SizedBox(height: 10),
          const SeeCalendar(),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Historial de inversiones",
            fontSize: 16,
            isBold: true,
          ),
          const SizedBox(height: 10),
          TabBarBusiness(
            isReinvest: isReinvest,
          ),
        ],
      ),
    );
  }
}

  // void showEmptyMessageModal(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return NoInvestmentBody(
  //         onPressed: () => Navigator.of(context).pop(),
  //       );
  //     },
  //   );
  // }

