import 'package:finniu/constants/colors/select_bank_account.dart';
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
  required BankAccount? bankSelect,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) {
      return SelectBankBody(
        isSender: isSender,
        currency: currency,
        typeReInvestment: typeReInvestment,
        bankSelect: bankSelect,
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
    required this.bankSelect,
  });
  final bool isSender;
  final String currency;
  final String typeReInvestment;
  final BankAccount? bankSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final selectedBank = isSender
        ? ref.watch(selectedBankAccountSenderProvider)
        : ref.watch(selectedBankAccountReceiverProvider);

    void closeModal() {
      isSender
          ? ref.read(selectedBankAccountSenderProvider.notifier).state =
              bankSelect
          : ref.read(selectedBankAccountReceiverProvider.notifier).state =
              bankSelect;
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
              ? const Color(SelectBankAccountColors.backgroundDark)
              : const Color(SelectBankAccountColors.backgroundLight),
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
                          ? const Color(SelectBankAccountColors.iconDark)
                          : const Color(SelectBankAccountColors.iconLight),
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
              textDark: SelectBankAccountColors.titleDark,
              textLight: SelectBankAccountColors.titleLight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.credit_card_outlined,
                  size: 24,
                  color: isDarkMode
                      ? const Color(SelectBankAccountColors.titleDark)
                      : const Color(SelectBankAccountColors.titleLight),
                ),
                const SizedBox(width: 10),
                const TextPoppins(
                  text: "Selecciona tu cuenta bancaria",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  lines: 2,
                  align: TextAlign.center,
                  textDark: SelectBankAccountColors.textDark,
                  textLight: SelectBankAccountColors.textLight,
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
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(SelectBankAccountColors.addAccountDark)
              : const Color(SelectBankAccountColors.addAccountLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Agregar cuenta bancaria',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: SelectBankAccountColors.addAccountTextDark,
            textLight: SelectBankAccountColors.addAccountTextLight,
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
          color: isDarkMode
              ? const Color(SelectBankAccountColors.confirmDark)
              : const Color(SelectBankAccountColors.confirmLight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Confirmar cuenta',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: SelectBankAccountColors.confirmTextDark,
            textLight: SelectBankAccountColors.confirmTextLight,
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

    final isSelected =
        selectedBank != null ? selectedBank.id == bankAccount.id : false;

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
                  ? const Color(SelectBankAccountColors.backgroundSelectDark)
                  : const Color(SelectBankAccountColors.backgroundSelectLight))
              : (isDarkMode
                  ? const Color(SelectBankAccountColors.backgroundColorDark)
                  : const Color(SelectBankAccountColors.backgroundColorLight)),
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
                        ? const Color(SelectBankAccountColors.errorDark)
                        : const Color(SelectBankAccountColors.errorLight),
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
                    textDark: isSelected
                        ? SelectBankAccountColors.textSelectDark
                        : null,
                    textLight: isSelected
                        ? SelectBankAccountColors.textSelectLight
                        : null,
                  ),
                  TextPoppins(
                    text:
                        "${bankAccount.bankSlug.toUpperCase()} ${getMaskedNumber(bankAccount.bankAccount)}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textDark: isSelected
                        ? SelectBankAccountColors.textSelectDark
                        : null,
                    textLight: isSelected
                        ? SelectBankAccountColors.textSelectLight
                        : null,
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
