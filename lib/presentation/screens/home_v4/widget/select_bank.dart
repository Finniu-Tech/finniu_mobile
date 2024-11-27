import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

void showBankAccountModalV4({
  required BuildContext context,
  required String currency,
  required bool isSender,
  required String typeReInvestment,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return SelectBankBody(
        isSender: isSender,
        currency: currency,
        typeReInvestment: typeReInvestment,
      );
    },
  );
}

class SelectBankBody extends ConsumerWidget {
  const SelectBankBody({
    super.key,
    required this.isSender,
    required this.currency,
    required this.typeReInvestment,
  });
  final bool isSender;
  final String currency;
  final String typeReInvestment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff0E0E0E;
    const backgroundLight = 0xffFFFFFF;
    const iconDark = 0xffFFFFFF;
    const iconLight = 0xff0D3A5C;
    const titleDark = 0xffA2E6FA;
    const titleLight = 0xff0D3A5C;
    const textDark = 0xffFFFFFF;
    const textLight = 0xff0D3A5C;
    final selectedBank = isSender
        ? ref.watch(selectedBankAccountSenderProvider)
        : ref.watch(selectedBankAccountReceiverProvider);

    void closeModal() {
      isSender
          ? ref.read(selectedBankAccountSenderProvider.notifier).state = null
          : ref.read(selectedBankAccountReceiverProvider.notifier).state = null;
      Navigator.pop(context);
    }

    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width,
        height: selectedBank != null ? 590 : 550,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: closeModal,
                  icon: Transform.rotate(
                    angle: math.pi / -4,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 24,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                    ),
                  ),
                ),
              ),
            ),
            TextPoppins(
              text: isSender
                  ? '¿Desde qué cuenta nos tranasfieres el dinero? 💸'
                  : '¿A qué cuenta transferimos tu rentabilidad? 💸',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              lines: 2,
              align: TextAlign.center,
              textDark: titleDark,
              textLight: titleLight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.credit_card_outlined,
                  size: 24,
                  color: isDarkMode
                      ? const Color(titleDark)
                      : const Color(titleLight),
                ),
                const SizedBox(width: 10),
                const TextPoppins(
                  text: "Selecciona tu cuenta bancaria",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  lines: 2,
                  align: TextAlign.center,
                  textDark: textDark,
                  textLight: textLight,
                ),
              ],
            ),
            ListBanks(
              isSender: isSender,
            ),
            selectedBank != null ? const ConfirmAccount() : const SizedBox(),
            const AddAccount(),
          ],
        ),
      ),
    );
  }
}

class AddAccount extends ConsumerWidget {
  const AddAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const colorDark = 0xff0D3A5C;
    const colorLight = 0xffA2E6FA;
    const textDark = 0xffA2E6FA;
    const textLight = 0xff000000;
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(colorDark) : const Color(colorLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Agregar cuenta bancaria',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: textDark,
            textLight: textLight,
          ),
        ),
      ),
    );
  }
}

class ConfirmAccount extends ConsumerWidget {
  const ConfirmAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const colorDark = 0xffA2E6FA;
    const colorLight = 0xff0D3A5C;
    const textDark = 0xff0D3A5C;
    const textLight = 0xffFFFFFF;
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: isDarkMode ? const Color(colorDark) : const Color(colorLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Confirmar cuenta',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: textDark,
            textLight: textLight,
          ),
        ),
      ),
    );
  }
}

class ListBanks extends ConsumerWidget {
  const ListBanks({
    super.key,
    required this.isSender,
  });
  final bool isSender;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankAccountsAsyncValue = ref.watch(bankAccountFutureProvider);

    return bankAccountsAsyncValue.when(
      data: (bankAccounts) {
        return SizedBox(
          height: 250,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: bankAccounts.length,
            itemBuilder: (context, index) {
              return BankItem(
                bankAccount: bankAccounts[index],
                isSender: isSender,
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const SizedBox(
        height: 250,
        child: Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}

class BankItem extends ConsumerWidget {
  const BankItem({
    super.key,
    required this.bankAccount,
    required this.isSender,
  });
  final bool isSender;
  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectedBank = isSender
        ? ref.watch(selectedBankAccountSenderProvider)
        : ref.watch(selectedBankAccountReceiverProvider);

    // Colores
    const int backgroundColorDark = 0xff1F1F1F;
    const int backgroundColorLight = 0xffF0F0F0;
    const int errorDark = 0xff181818;
    const int errorLight = 0xffA2E6FA;
    const int backgroundSelectDark = 0xff8ADAF2;
    const int backgroundSelectLight = 0xffDFF8FF;
    const int textSelectDark = 0xff000000;
    const int textSelectLight = 0xff000000;

    String getCurrency(String? currency) {
      switch (currency) {
        case "nuevo sol":
          return "Cuenta Soles";
        case "dolar":
          return "Cuenta Dólares";
        default:
          return "Cuenta Soles";
      }
    }

    String getMaskedNumber(String? number) {
      if (number != null && number.length >= 3) {
        String visible = number.substring(number.length - 3);
        return "**********$visible";
      } else {
        return "**********234";
      }
    }

    final isSelected = selectedBank == bankAccount;

    return GestureDetector(
      onTap: () => {
        isSender
            ? ref.read(selectedBankAccountSenderProvider.notifier).state =
                bankAccount
            : ref.read(selectedBankAccountReceiverProvider.notifier).state =
                bankAccount,
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 65,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode
                  ? const Color(backgroundSelectDark)
                  : const Color(backgroundSelectLight))
              : (isDarkMode
                  ? const Color(backgroundColorDark)
                  : const Color(backgroundColorLight)),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                bankAccount.bankLogoUrl ?? "",
                width: 40,
                height: 40,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularLoader(width: 10, height: 10);
                  }
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 40,
                  height: 40,
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
              width: 20,
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextPoppins(
                    text: getCurrency(bankAccount.currency),
                    fontSize: 14,
                    textDark: isSelected ? textSelectDark : null,
                    textLight: isSelected ? textSelectLight : null,
                  ),
                  TextPoppins(
                    text:
                        "${bankAccount.bankSlug} ${getMaskedNumber(bankAccount.bankAccount)}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textDark: isSelected ? textSelectDark : null,
                    textLight: isSelected ? textSelectLight : null,
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
