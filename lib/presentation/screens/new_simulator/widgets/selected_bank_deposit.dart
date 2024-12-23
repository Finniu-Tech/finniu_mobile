import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedBankDeposit extends ConsumerWidget {
  const SelectedBankDeposit({
    super.key,
    required this.bankAccountReceiver,
  });
  final BankAccount bankAccountReceiver;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2A2929;
    const int backgroundLight = 0xffF1FCFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff000000;
    // const int buttonDark = 0xff181818;
    // const int buttonLight = 0xffCFF4FF;
    // const int iconDark = 0xffA2E6FA;
    // const int iconLight = 0xff0D3A5C;

    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (bankAccountReceiver.bankLogoUrl != null)
            Image.network(
              bankAccountReceiver.bankLogoUrl ?? "",
              width: 45,
              height: 45,
              errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
                "assets/svg_icons/bank_error_icon.svg",
                width: 50,
                height: 50,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const CircularLoader(width: 50, height: 50);
              },
            ),
          if (bankAccountReceiver.bankLogoUrl == null)
            Image.asset(
              "assets/images/bank_placeholder.png",
              width: 45,
              height: 45,
            ),

          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextPoppins(
                text: "Banco donde te depositamos ",
                fontSize: 14,
              ),
              TextPoppins(
                text: bankAccountReceiver.bankSlug.toUpperCase(),
                fontSize: 12,
              ),
              TextPoppins(
                text: "Nro. Cuenta: ${bankAccountReceiver.bankAccount}",
                fontSize: 12,
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.all(2),
          //       width: 20,
          //       height: 20,
          //       decoration: BoxDecoration(
          //         color: Color(isDarkMode ? buttonDark : buttonLight),
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       child: GestureDetector(
          //         onTap: () {
          //           print("cambiar tarjeta con id");
          //           print(bankAccountReceiver.id);
          //         },
          //         child: SvgPicture.asset(
          //           'assets/svg_icons/credit-card.svg',
          //           width: 20,
          //           height: 20,
          //           color: Color(isDarkMode ? iconDark : iconLight),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       width: 20,
          //       height: 20,
          //       padding: const EdgeInsets.all(2),
          //       decoration: BoxDecoration(
          //         color: Color(isDarkMode ? buttonDark : buttonLight),
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       child: GestureDetector(
          //         onTap: () {
          //           print("eliminar tarjeta con id");
          //           print(bankAccountReceiver.id);
          //         },
          //         child: SvgPicture.asset(
          //           'assets/svg_icons/trash-2.svg',
          //           width: 16,
          //           height: 16,
          //           color: Color(isDarkMode ? iconDark : iconLight),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
