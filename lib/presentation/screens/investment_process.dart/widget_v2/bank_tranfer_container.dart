import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/widget/select_bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final bankSelect = isSended
        ? ref.read(selectedBankAccountSenderProvider)
        : ref.read(selectedBankAccountReceiverProvider);
    return GestureDetector(
      onTap: () => showBankAccountModalV4(
        context: context,
        currency: currencyValue,
        isSender: isSended,
        typeReInvestment: "",
        bankSelect: bankSelect,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 45,
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
                  child: SizedBox(
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/svg_icons/card_add_icon.svg",
                        width: 20,
                        height: 20,
                        color: const Color(icon),
                      ),
                    ),
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
    const int changeDark = 0xffA2E6FA;
    const int changeLight = 0xff0D3A5C;
    const int changeTextDark = 0xff0D3A5C;
    const int changeTextLight = 0xffFFFFFF;
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

    String getMaskedNumber(String? number) {
      if (number != null && number.length >= 3) {
        String visible = number.substring(number.length - 3);
        return "**********$visible";
      } else {
        return "**********----";
      }
    }

    return GestureDetector(
      onTap: () => showBankAccountModalV4(
        context: context,
        currency: currencyValue,
        isSender: isSended,
        typeReInvestment: "",
        bankSelect: selectBank,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            ClipOval(
              child: Image.network(
                selectBank?.bankLogoUrl ?? "",
                width: 35,
                height: 35,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularLoader(width: 10, height: 10);
                  }
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 35,
                  height: 35,
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
            Expanded(
              child: SizedBox(
                child: TextPoppins(
                  text:
                      "${selectBank?.bankSlug.toUpperCase() ?? "banco"}-${getCurrency(selectBank?.currency)}\n${getMaskedNumber(selectBank?.bankAccount)}",
                  fontSize: 11,
                  lines: 2,
                ),
              ),
            ),
            Container(
              width: 126,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isDarkMode
                    ? const Color(changeDark)
                    : const Color(changeLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg_icons/card_add_icon.svg",
                    width: 20,
                    height: 20,
                    color: isDarkMode
                        ? const Color(changeTextDark)
                        : const Color(changeTextLight),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextPoppins(
                    text: "Cambiar",
                    fontSize: 13,
                    textDark: changeTextDark,
                    textLight: changeTextLight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
