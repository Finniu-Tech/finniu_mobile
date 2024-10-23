import 'package:finniu/infrastructure/datasources/contract_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TermConditionsStep extends ConsumerWidget {
  const TermConditionsStep({
    super.key,
    required this.conditions,
  });
  final ValueNotifier<bool> conditions;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CheckBoxWidget(
          value: conditions.value,
          onChanged: (value) {
            conditions.value = conditions.value ? false : true;
          },
        ),
        GestureDetector(
          onTap: () async {
            String contractURL = await ContractDataSourceImp().getContract(
              uuid: args['preInvestmentUUID'],
              client: ref.watch(gqlClientProvider).value!,
            );

            if (contractURL.isNotEmpty) {
              conditions.value = true;

              Navigator.pushNamed(
                context,
                '/contract_view',
                arguments: {
                  'contractURL': contractURL,
                },
              );
            }
          },
          child: Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(
              text: "He leído y acepto el ",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode ? const Color(textDark) : const Color(textLight),
              ),
              children: [
                TextSpan(
                  text: 'Contrato de Inversión de Finniu',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? const Color(textDark)
                        : const Color(textLight),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class TextRickStep extends ConsumerWidget {
  const TextRickStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Text.rich(
      TextSpan(
        text: "Realiza tu transferencia de ",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? const Color(textDark) : const Color(textLight),
        ),
        children: [
          TextSpan(
            text: isSoles ? "S/ ${args['amount']}" : "USD ${args['amount']}",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
          ),
          TextSpan(
            text: ' a la cuenta bancaria de Finniu:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
