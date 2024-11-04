import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FinniuAccount {
  final String accountNumber;
  final String accountCci;
  final String bankName;
  final String currency;
  final String slug;
  final String? bankUrl;

  FinniuAccount({
    required this.accountNumber,
    required this.accountCci,
    required this.bankName,
    required this.slug,
    required this.currency,
    this.bankUrl,
  });
}

final finniuAccountSolesDefault = FinniuAccount(
  accountNumber: '---------',
  accountCci: '---------',
  bankName: "",
  slug: '---------',
  currency: 'SOLES',
  bankUrl: '---------',
);
final finniuAccountDolarsDefault = FinniuAccount(
  accountNumber: '---------',
  accountCci: '---------',
  bankName: "",
  slug: '---------',
  currency: "DOLARES",
  bankUrl: "",
);

final finniuAccountProvider =
    FutureProvider.autoDispose<FinniuAccount>((ref) async {
  final bankSender = ref.watch(selectedBankAccountSenderProvider);
  final isSoles = ref.watch(isSolesStateProvider);

  try {
    final gqlClient = ref.watch(gqlClientProvider).value;
    if (gqlClient == null) {
      throw Exception('GraphQL client is null');
    }

    final Map<String, dynamic> variables = {};
    if (bankSender != null) {
      variables['bankSlug'] = bankSender.bankName.toLowerCase();
    }

    final response = await gqlClient.query(
      QueryOptions(
        document: gql(QueryRepository.getStepBankAccounts),
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    final data =
        response.data?["companyBankAccountQueries"]['companyBankAccounts'];

    if (data != null && data.isNotEmpty) {
      FinniuAccount? solesAccount;
      FinniuAccount? dollarsAccount;
      for (var account in data) {
        if (account["companyBankType"] == "SOLES") {
          solesAccount = FinniuAccount(
            accountNumber: account['accountNumber'],
            bankName: account["bank"]['bankName'],
            accountCci: account['accountCci'] ?? '',
            slug: account["bank"]['slug'],
            bankUrl: account["bank"]["bankImageUrl"] ?? '',
            currency: account["companyBankType"] ?? '',
          );
        } else if (account["companyBankType"] == "DOLARES") {
          dollarsAccount = FinniuAccount(
            accountNumber: account['accountNumber'],
            bankName: account["bank"]['bankName'],
            accountCci: account['accountCci'] ?? '',
            slug: account["bank"]['slug'],
            bankUrl: account["bank"]["bankImageUrl"] ?? '',
            currency: account["companyBankType"] ?? '',
          );
        }
      }

      if (isSoles) {
        return solesAccount ?? finniuAccountSolesDefault;
      } else {
        return dollarsAccount ?? finniuAccountDolarsDefault;
      }
    } else {
      throw Exception('No bank accounts found');
    }
  } catch (e) {
    throw Exception('No bank accounts found');
  }
});
