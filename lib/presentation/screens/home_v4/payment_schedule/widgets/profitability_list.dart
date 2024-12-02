import 'package:finniu/constants/number_format.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/new_simulator/helpers/month_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfitabilityListV4 extends ConsumerWidget {
  const ProfitabilityListV4({
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

class TitleDataV4 extends ConsumerWidget {
  const TitleDataV4({
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
