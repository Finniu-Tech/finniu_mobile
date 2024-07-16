import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/voucher_modal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LessYearBlueGoldCard extends StatefulWidget {
  final int daysPassed;
  final int daysMissing;
  final int uuidVoucher;
  final int uuidReport;

  const LessYearBlueGoldCard({
    super.key,
    required this.daysPassed,
    required this.daysMissing,
    required this.uuidVoucher,
    required this.uuidReport,
  });

  @override
  State<LessYearBlueGoldCard> createState() => _LessYearBlueGoldCardState();
}

class _LessYearBlueGoldCardState extends State<LessYearBlueGoldCard> {
  bool _isExpanded = false;
  void closedExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void onTapVoucher() {
    print("pon tap voucher ${widget.uuidVoucher}");
    voucherModal(context, urlImage: "assets/blue_gold/voucher_example.png");
  }

  void onTapReport() {
    print("pon tap report ${widget.uuidReport}");
    voucherModal(context, urlImage: "assets/blue_gold/voucher_example.png");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DropDownWidget(
          isExpanded: _isExpanded,
          closed: closedExpand,
          onTapVoucher: onTapVoucher,
          onTapReport: onTapReport,
        ),
        GestureDetector(
          onTap: () {
            closedExpand();
          },
          child: TitleCard(
            daysPassed: widget.daysPassed,
            daysMissing: widget.daysMissing,
          ),
        ),
      ],
    );
  }
}

class DropDownWidget extends ConsumerWidget {
  const DropDownWidget({
    super.key,
    required this.closed,
    required bool isExpanded,
    required this.onTapVoucher,
    required this.onTapReport,
  }) : _isExpanded = isExpanded;
  final VoidCallback? closed;
  final VoidCallback? onTapVoucher;
  final VoidCallback? onTapReport;
  final bool _isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff112445;
    const int backgroundLight = 0xffDFEEFF;
    const int textTimeDark = 0xffFFFFFF;
    const int textTimeLight = 0xff1F4180;
    const int iconTimeDark = 0xffFFFFFF;
    const int iconTimeLight = 0xff000000;

    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * 0.95,
      height: _isExpanded ? 150 : 50,
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundDark : backgroundLight),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: _isExpanded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    VoucherButton(
                      onTapVoucher: onTapVoucher,
                    ),
                    ReportButton(
                      onTapReport: onTapReport,
                    ),
                  ],
                ),
                SizedBox(
                  height: 44,
                  child: GestureDetector(
                    onTap: closed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TextPoppins(
                          text: "Ver menos",
                          fontSize: 9,
                          textDark: textTimeDark,
                          textLight: textTimeLight,
                          isBold: true,
                        ),
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 24,
                          color:
                              Color(isDarkMode ? iconTimeDark : iconTimeLight),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class TitleCard extends ConsumerWidget {
  const TitleCard({
    super.key,
    required this.daysPassed,
    required this.daysMissing,
  });

  final int daysPassed;
  final int daysMissing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff315AA5;
    const int backgroundLight = 0xffC8E2FF;
    const int backgroundYearDark = 0xffA2CEFE;
    const int backgroundYearLight = 0xff315AA5;
    const int daysPassedDark = 0xff1F4180;
    const int daysPassedLight = 0xffFFFFFF;

    const int daysMissingDark = 0xff94C7FF;
    const int daysMissingLight = 0xff315AA5;
    return Container(
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundDark : backgroundLight),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
              color:
                  Color(isDarkMode ? backgroundYearDark : backgroundYearLight),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/blue_gold/plant_image.png",
                      width: 22, height: 22),
                ),
                Column(
                  children: [
                    TextPoppins(
                      text: "$daysPassed días",
                      fontSize: 16,
                      isBold: true,
                      textDark: daysPassedDark,
                      textLight: daysPassedLight,
                    ),
                    const TextPoppins(
                      text: "transcurridos desde tu inversión",
                      fontSize: 9,
                      isBold: true,
                      textDark: daysPassedDark,
                      textLight: daysPassedLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              const TextPoppins(
                text: "faltan ",
                fontSize: 12,
                textDark: daysMissingDark,
                textLight: daysMissingLight,
                isBold: true,
              ),
              TextPoppins(
                text: "$daysMissing días ",
                fontSize: 16,
                isBold: true,
                textDark: daysMissingDark,
                textLight: daysMissingLight,
              ),
              ClipOval(
                child: Image.asset(
                  "assets/blue_gold/blue_gold_investment.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
