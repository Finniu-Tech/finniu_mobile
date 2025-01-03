import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VoucherDto {
  final String month;
  final String amount;
  final String depositDay;
  final String depositHour;
  final String bank;
  final String urlVoucher;

  const VoucherDto({
    required this.month,
    required this.amount,
    required this.depositDay,
    required this.depositHour,
    required this.bank,
    required this.urlVoucher,
  });
}

void showModalPaymentVoucher({
  required BuildContext context,
  required VoucherDto voucherData,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return VoucherDialog(
        voucher: voucherData,
      );
    },
  );
}

class VoucherDialog extends ConsumerWidget {
  const VoucherDialog({
    super.key,
    required this.voucher,
  });
  final VoucherDto voucher;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Dialog(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 390,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg_icons/receipt_item.svg',
                                width: 24,
                                height: 24,
                                color: isDarkMode
                                    ? const Color(iconDark)
                                    : const Color(iconLight),
                              ),
                              const SizedBox(width: 5),
                              const SizedBox(
                                width: 180,
                                child: TextPoppins(
                                  text: 'Voucher del pago realizado',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  textDark: iconDark,
                                  textLight: iconLight,
                                ),
                              ),
                            ],
                          ),
                          VoucherData(
                            voucher: voucher,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonIconInvestment(
                    text: "Descargar voucher",
                    onPressed: () {},
                    icon: Icons.file_download_outlined,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }
}

class VoucherData extends ConsumerWidget {
  const VoucherData({super.key, required this.voucher});
  final VoucherDto voucher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff272727;
    const int backgroundLight = 0xffEFEFEF;

    const int textDark = 0xffA2E6FA;
    const int textLight = 0xff0D3A5C;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210,
            child: TextPoppins(
              text: "Pago de rentabilidad - Mes ${voucher.month}",
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const TextPoppins(
                text: "Monto ",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: voucher.amount,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
            ],
          ),
          Row(
            children: [
              const TextPoppins(
                text: "Día del depósito ",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: voucher.depositDay,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
            ],
          ),
          Row(
            children: [
              const TextPoppins(
                text: "Hora del depósito  ",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: voucher.depositHour,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
            ],
          ),
          Row(
            children: [
              const TextPoppins(
                text: "Banco: ",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: voucher.bank,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
