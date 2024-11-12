import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/see_calendar.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RealEstateBody extends ConsumerWidget {
  final FundEntity fund;
  const RealEstateBody({
    super.key,
    required this.fund,
  }) : super();

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
                _buildNormalContent(fund: fund),
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

            return _buildNormalContent(isReinvest: isReinvest, fund: fund);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildNormalContent(
      {bool isReinvest = false, required FundEntity fund}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const SwitchMoney(
            switchHeight: 30,
            switchWidth: 67,
          ),
          const SizedBox(height: 10),
          GraphicContainer(
            fund: fund,
          ),
          const SizedBox(height: 10),
          const SeeCalendar(),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Historial de inversiones ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 10),
          TabBarBusiness(
            isReinvest: isReinvest,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
