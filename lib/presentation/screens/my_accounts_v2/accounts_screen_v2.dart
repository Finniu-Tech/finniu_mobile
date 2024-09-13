import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/my_accounts_v2/widgets/account_card.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/screens/my_accounts_v2/widgets/add_accounts.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/back_account_register_modal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountsV2Screen extends StatelessWidget {
  const AccountsV2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Mis cuentas",
      children: _BodyMyAccounts(),
    );
  }
}

class _BodyMyAccounts extends ConsumerWidget {
  const _BodyMyAccounts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final currency = isSoles ? currencyEnum.PEN : currencyEnum.USD;
    final bankAccounts = ref.watch(bankAccountFutureProvider);

    const String logoNull =
        "https://w7.pngwing.com/pngs/929/674/png-transparent-bank-computer-icons-building-bank-building-text-logo.png";

    void addBank() {
      showAccountTransferModal(
        context,
        currency,
        true,
      );

      ref.read(bankFutureProvider.future);
    }

    String getCurrency(String currency) {
      if (currency == "nuevo sol") {
        return "Cuenta soles";
      } else {
        return "Cuenta dolares";
      }
    }

    String hideNumbers(String numero) {
      if (numero.length <= 4) {
        return numero;
      }
      String ultimosCuatro = numero.substring(numero.length - 4);
      String asteriscos = '*' * (10);
      return asteriscos + ultimosCuatro;
    }

    return bankAccounts.when(
      data: (data) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ...data.map(
                  (bank) => AccointCard(
                    title: bank.bankName,
                    subtitle:
                        "${getCurrency(bank.currency)} | ${hideNumbers(bank.bankAccount)}  ",
                    isJoint: bank.isJointAccount,
                    logoUrl: bank.bankLogoUrl == null || bank.bankLogoUrl == ""
                        ? logoNull
                        : bank.bankLogoUrl!,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => showAccountTransferModal(
                    context,
                    currency,
                    true,
                  ),
                  child: const AddAccounts(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text("Error al cargar las cuentas"),
        );
      },
      loading: () {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
    );
  }
}
