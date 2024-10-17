import 'package:finniu/constants/number_format.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/investment_detail_uuid_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/new_simulator/helpers/month_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showTablePay(BuildContext context, {required String preInvestmentUUID}) {
  print('show table pay !!!!');
  showDialog(
    context: context,
    builder: (context) =>
        ProfitabilityTable(preInvestmentUUID: preInvestmentUUID),
  );
}

class NotProfitability extends ConsumerWidget {
  const NotProfitability({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
        ),
        width: 300,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextPoppins(
              text: "Rentabilidad no disponible",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textDark: titleDark,
              textLight: titleLight,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonInvestment(
                text: "Presione para volver",
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfitabilityTable extends ConsumerWidget {
  final String preInvestmentUUID;

  const ProfitabilityTable({Key? key, required this.preInvestmentUUID})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profitabilityData =
        ref.watch(getMonthlyPaymentProvider(preInvestmentUUID));

    return Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: ref.watch(settingsNotifierProvider).isDarkMode
              ? const Color(0xff1A1A1A)
              : const Color(0xffFFFFFF),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: profitabilityData.when(
          data: (data) {
            if (data == null) {
              return const NotProfitability();
            }
            return _buildProfitabilityContent(context, ref, data);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const NotProfitability(),
        ),
      ),
    );
  }

  Widget _buildProfitabilityContent(
      BuildContext context, WidgetRef ref, List<ProfitabilityItem> list) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 20),
                    TextPoppins(
                      text: "Tabla de mis rentabilidades",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textDark: 0xffA2E6FA,
                      textLight: 0xff0D3A5C,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ProfitabilityTableBody(list: list),
              ],
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }
}

class ProfitabilityTableBody extends ConsumerWidget {
  final List<ProfitabilityItem> list;
  const ProfitabilityTableBody({
    super.key,
    required this.list,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(minWidth: 277),
      padding: const EdgeInsets.only(right: 20, left: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          const TitleData(),
          ProfitabilityList(list: list),
        ],
      ),
    );
  }
}

class ProfitabilityList extends ConsumerWidget {
  const ProfitabilityList({
    super.key,
    required this.list,
  });
  final List<ProfitabilityItem> list;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: isDarkMode
                    ? const Color(borderColorDark)
                    : const Color(borderColorLight),
              ),
              borderRadius: index == list.length - 1
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  constraints: const BoxConstraints(
                    minWidth: 100,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      TextPoppins(
                        text: monthToString(list[index].paymentDate),
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: isDarkMode
                      ? const Color(borderColorDark)
                      : const Color(borderColorLight),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      TextPoppins(
                        text: isSoles
                            ? formatterSoles.format(list[index].amount)
                            : formatterUSD.format(list[index].amount),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TitleData extends ConsumerWidget {
  const TitleData({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int backgroundColorDark = 0xff0D3A5C;
    const int backgroundColorLight = 0xffE3F9FF;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            constraints: const BoxConstraints(minWidth: 100),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: isDarkMode
                      ? const Color(titleTableDark)
                      : const Color(titleTableLight),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "Mes",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textDark: titleTableDark,
                  textLight: titleTableLight,
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: isDarkMode
                ? const Color(borderColorDark)
                : const Color(borderColorLight),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                'assets/svg_icons/status_up_two.svg',
                width: 17,
                height: 17,
                color: isDarkMode
                    ? const Color(titleTableDark)
                    : const Color(titleTableLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "Rentabilidad",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textDark: titleTableDark,
                textLight: titleTableLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
