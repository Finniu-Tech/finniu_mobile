import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ReportButton extends ConsumerWidget {
  const ReportButton({
    super.key,
    required this.onTapReport,
  });
  final VoidCallback? onTapReport;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int downloadBackgroundDark = 0xff94C7FF;
    const int downloadBackgroundLight = 0xff94C7FF;
    const int downloadTextDark = 0xff000000;
    const int downloadTextLight = 0xff000000;
    return GestureDetector(
      onTap: onTapReport,
      child: Container(
        width: 152,
        height: 44,
        decoration: BoxDecoration(
          color: Color(
            isDarkMode ? downloadBackgroundDark : downloadBackgroundLight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.file_download_outlined,
              size: 29,
              color: Color(
                isDarkMode ? downloadTextDark : downloadTextLight,
              ),
            ),
            const SizedBox(width: 7),
            const TextPoppins(
              text: "Informe anual",
              fontSize: 14,
              isBold: true,
              textDark: downloadTextDark,
              textLight: downloadTextLight,
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherButton extends ConsumerWidget {
  const VoucherButton({
    super.key,
    required this.onTapVoucher,
  });
  final VoidCallback? onTapVoucher;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int voucherBackgroundDark = 0xff3167CB;
    const int voucherBackgroundLight = 0xffA2E6FA;
    const int voucherTextDark = 0xffFFFFFF;
    const int voucherTextLight = 0xff000000;
    return GestureDetector(
      onTap: onTapVoucher,
      child: Container(
        decoration: BoxDecoration(
          color: Color(
            isDarkMode ? voucherBackgroundDark : voucherBackgroundLight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: 152,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/blue_gold/receipt_icon_${isDarkMode ? 'dark' : 'light'}.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 7),
            const TextPoppins(
              text: "Voucher",
              fontSize: 16,
              isBold: true,
              textDark: voucherTextDark,
              textLight: voucherTextLight,
            ),
          ],
        ),
      ),
    );
  }
}

class CloseButtonModal extends ConsumerWidget {
  const CloseButtonModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const iconDark = 0xffFFFFFF;
    const iconLight = 0xff515151;
    return Positioned(
      right: 10,
      top: 10,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Transform.rotate(
          angle: math.pi / 4,
          child: Icon(
            Icons.add_circle_outline,
            size: 25,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ),
      ),
    );
  }
}
