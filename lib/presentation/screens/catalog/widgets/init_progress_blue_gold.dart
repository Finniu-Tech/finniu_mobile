import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitProgressBlueGoldCard extends StatefulWidget {
  final int daysPassed;
  final int daysMissing;
  final int uuidVoucher;
  final int uuidReport;

  const InitProgressBlueGoldCard({
    super.key,
    required this.daysPassed,
    required this.daysMissing,
    required this.uuidVoucher,
    required this.uuidReport,
  });

  @override
  State<InitProgressBlueGoldCard> createState() =>
      _InitProgressBlueGoldCardState();
}

class _InitProgressBlueGoldCardState extends State<InitProgressBlueGoldCard> {
  bool _isExpanded = false;
  void closedExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void onTapVoucher() {
    print("pon tap voucher ${widget.uuidVoucher}");
  }

  void onTapReport() {
    print("pon tap report ${widget.uuidReport}");
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
            time: widget.daysPassed,
            timeInDay: widget.daysMissing,
          ),
        ),
      ],
    );
  }
}

class DropDownWidget extends ConsumerStatefulWidget {
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
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends ConsumerState<DropDownWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _heightAnimation = Tween<double>(begin: 50, end: 150).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget._isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(DropDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff112445;
    const int backgroundLight = 0xffDFEEFF;
    const int textTimeDark = 0xffFFFFFF;
    const int textTimeLight = 0xff1F4180;
    const int iconTimeDark = 0xffFFFFFF;
    const int iconTimeLight = 0xff000000;

    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: _heightAnimation.value,
          decoration: BoxDecoration(
            color: Color(isDarkMode ? backgroundDark : backgroundLight),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _heightAnimation.value >= 150
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        VoucherButton(
                          onTapVoucher: widget.onTapVoucher,
                        ),
                        ReportButton(
                          onTapReport: widget.onTapReport,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44,
                      child: GestureDetector(
                        onTap: widget.closed,
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
                              color: Color(
                                  isDarkMode ? iconTimeDark : iconTimeLight),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class TitleCard extends ConsumerWidget {
  final int time;
  final int timeInDay;
  const TitleCard({
    super.key,
    required this.time,
    required this.timeInDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1F4180;
    const int backgroundLight = 0xffC8E2FF;
    const int textTimeDark = 0xff6A9DFB;
    const int textTimeLight = 0xff315AA5;
    const int textTimeInDayDark = 0xff94C7FF;
    const int textTimeInDayLight = 0xff315AA5;
    return Container(
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundDark : backgroundLight),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPoppins(
            text: "$time AÑO",
            fontSize: 16,
            textDark: textTimeDark,
            textLight: textTimeLight,
            isBold: true,
          ),
          Row(
            children: [
              const TextPoppins(
                text: "faltan ",
                fontSize: 12,
                textDark: textTimeInDayDark,
                textLight: textTimeInDayLight,
                isBold: true,
              ),
              TextPoppins(
                text: "$timeInDay días ",
                fontSize: 16,
                isBold: true,
                textDark: textTimeInDayDark,
                textLight: textTimeInDayLight,
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
