import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/my_accounts_v2/widgets/account_card.dart';
import 'package:finniu/presentation/screens/my_accounts_v2/widgets/add_accounts.dart';
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
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            AccointCard(
              title: "Cuenta 1",
              subtitle: "Cuenta de prueba",
              isJoint: false,
            ),
            SizedBox(height: 15),
            AccointCard(
              title: "Cuenta 2",
              subtitle: "Cuenta de prueba",
              isJoint: true,
            ),
            SizedBox(height: 15),
            AddAccounts(),
          ],
        ),
      ),
    );
  }
}
