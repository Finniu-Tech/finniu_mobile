import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FinniuAccount {
  final String accountNumber;
  final String accountCci;
  final String bankName;
  final String slug;
  final String? bankUrl;

  FinniuAccount({
    required this.accountNumber,
    required this.accountCci,
    required this.bankName,
    required this.slug,
    this.bankUrl,
  });
}

final finniuAccountProvider =
    FutureProvider.autoDispose<FinniuAccount>((ref) async {
  final bankSender = ref.watch(selectedBankAccountSenderProvider);

  try {
    final gqlClient = ref.watch(gqlClientProvider).value;
    if (gqlClient == null) {
      return FinniuAccount(
        accountNumber: '17262727227',
        accountCci: '173783838383',
        bankName: 'Interbank',
        slug: 'interbank',
      );
    }

    final Map<String, dynamic> variables = {};
    if (bankSender != null) {
      variables['bankId'] = bankSender.id;
    }
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(QueryRepository.getStepBankAccounts),
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    final data = response.data?['companyBankAccounts'];
    if (data != null && data.isNotEmpty) {
      return FinniuAccount(
        accountNumber: data[0]['accountNumber'] ?? '17262727227',
        accountCci: data[0]['accountCci'] ?? '173783838383',
        bankName: data[0]["bank" 'bankName'] ?? 'Interbank',
        slug: data[0]["bank" 'slug'] ?? 'interbank',
      );
    } else {
      return FinniuAccount(
        accountNumber: '17262727227',
        accountCci: '173783838383',
        bankName: 'Interbank',
        slug: 'interbank',
      );
    }
  } catch (e) {
    return FinniuAccount(
      accountNumber: '17262727227',
      accountCci: '173783838383',
      bankName: 'Interbank',
      slug: 'interbank',
    );
  }
});
