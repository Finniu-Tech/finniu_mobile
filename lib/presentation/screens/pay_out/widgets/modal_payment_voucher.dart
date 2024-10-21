import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showModalPaymentVoucher(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const VoucherDialog();
    },
  );
}

class VoucherDialog extends StatelessWidget {
  const VoucherDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 390,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: SizedBox(
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextPoppins(
                        text: 'Voucher del pago realizado',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      VoucherData(),
                    ],
                  ),
                ),
              ),
              ButtonInvestment(
                text: 'Descargar voucher',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoucherData extends ConsumerWidget {
  const VoucherData({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff272727;
    const int backgroundLight = 0xffEFEFEF;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      child: const Column(
        children: [],
      ),
    );
  }
}
