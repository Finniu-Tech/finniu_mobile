import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/rentability_current_month.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RentContainer extends ConsumerWidget {
  const RentContainer({
    super.key,
    required this.isRender,
  });

  final bool isRender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    final rentabilityAsync = ref.watch(rentabilityProvider);
    final currentDate = DateTime.now();
    final String dateInfo =
        'Rentabilidad mes ${DateFormat('MMMM', 'es').format(currentDate)}';

    return rentabilityAsync.when(
      data: (rentability) => _RentContainerContent(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        rent: rentability.rentabilityPerMonth,
        percent: rentability.rentabilityPercent,
        dateInfo: dateInfo,
        isRender: isRender,
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => _RentContainerContent(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        rent: 0.0.toString(),
        percent: 0.0.toString(),
        dateInfo: dateInfo,
        isRender: isRender,
      ),
    );
  }
}

class _RentContainerContent extends StatelessWidget {
  const _RentContainerContent({
    required this.isDarkMode,
    required this.isSoles,
    required this.rent,
    required this.percent,
    required this.dateInfo,
    required this.isRender,
  });

  final bool isDarkMode;
  final bool isSoles;
  final String rent;
  final String percent;
  final String dateInfo;
  final bool isRender;

  @override
  Widget build(BuildContext context) {
    const int backgroundDark = 0xffB5FF8A;
    const int backgroundLight = 0xffD0FFB5;
    const int dateDark = 0xff0D3A5C;
    const int dateLight = 0xff0D3A5C;
    const int percentDark = 0xff109B60;
    const int percentLight = 0xff109B60;
    const int percentContainerDark = 0xffA5FD72;
    const int percentContainerLight = 0xffBDFF97;
    const int textColor = 0xff000000;

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: isRender ? 100 : 80,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg_icons/status_up.svg',
                width: 20,
                height: 20,
                color:
                    isDarkMode ? const Color(dateDark) : const Color(dateLight),
              ),
              const SizedBox(width: 10),
              TextPoppins(
                text: dateInfo,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                textDark: textColor,
                textLight: textColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: "+${isSoles ? "S/" : "\$"}$rent ",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textDark: textColor,
                textLight: textColor,
              ),
              const SizedBox(width: 10),
              Container(
                width: 45,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(percentContainerDark)
                      : const Color(percentContainerLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextPoppins(
                  text: "+ $percent",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  textDark: percentDark,
                  textLight: percentLight,
                ),
              ),
            ],
          ),
          if (isRender)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg_icons/clock_icon.svg',
                  width: 20,
                  height: 20,
                  color: isDarkMode
                      ? const Color(dateDark)
                      : const Color(dateLight),
                ),
                const SizedBox(width: 5),
                TextPoppins(
                  text: dateInfo,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textDark: dateDark,
                  textLight: dateLight,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
