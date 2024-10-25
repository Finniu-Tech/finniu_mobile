import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BankTranferContainer extends ConsumerWidget {
  const BankTranferContainer({
    super.key,
    required this.title,
    required this.providerWatch,
    required this.isSended,
  });
  final String title;
  final bool isSended;
  final AutoDisposeStateProvider<BankAccount?> providerWatch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectBank = ref.watch(
      providerWatch,
    );
    return selectBank != null
        ? BankContainer(
            providerWatch: providerWatch,
            isSended: isSended,
          )
        : AddContainer(
            title: title,
            isSended: isSended,
          );
  }
}

class AddContainer extends ConsumerWidget {
  const AddContainer({
    super.key,
    required this.title,
    required this.isSended,
  });
  final String title;
  final bool isSended;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    final String currencyValue = isSoles ? currencyEnum.PEN : currencyEnum.USD;
    const int containerDark = 0xff212121;
    const int containerLight = 0xffBCF0FF;
    const int iconBackground = 0xff95E7FF;
    const int icon = 0xff0D3A5C;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: () => showBankAccountModal(
        context,
        ref,
        currencyValue,
        isSended,
        "",
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width,
        height: 38,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(iconBackground),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Icon(
                    Icons.add_card_outlined,
                    size: 20,
                    color: Color(icon),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextPoppins(
                  text: title,
                  fontSize: 11,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_outlined,
              size: 24,
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
          ],
        ),
      ),
    );
  }
}

class BankContainer extends ConsumerWidget {
  const BankContainer({
    super.key,
    required this.providerWatch,
    required this.isSended,
  });
  final AutoDisposeStateProvider<BankAccount?> providerWatch;
  final bool isSended;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectBank = ref.watch(
      providerWatch,
    );
    final isSoles = ref.watch(isSolesStateProvider);
    final String currencyValue = isSoles ? currencyEnum.PEN : currencyEnum.USD;

    const int containerDark = 0xff212121;
    const int containerLight = 0xffBCF0FF;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff0D3A5C;
    const int errorDark = 0xff181818;
    const int errorLight = 0xffA2E6FA;
    String getCurrency(String? currency) {
      switch (currency) {
        case "nuevo sol":
          return "Cuenta Soles";
        case "dolar":
          return "Cuenta Dolares";
        default:
          return "Cuenta Soles";
      }
    }

    return GestureDetector(
      onTap: () => showBankAccountModal(
        context,
        ref,
        currencyValue,
        isSended,
        "",
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width,
        height: 38,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    selectBank?.bankLogoUrl ?? "",
                    width: 30,
                    height: 30,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const CircularLoader(width: 10, height: 10);
                      }
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(errorDark)
                            : const Color(errorLight),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/bank_case_error.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextPoppins(
                    text:
                        "${selectBank?.bankName ?? "banco"} - ${getCurrency(selectBank?.currency)}  | ${selectBank?.bankAccount ?? "----"}",
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_outlined,
              size: 24,
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
          ],
        ),
      ),
    );
  }
}
