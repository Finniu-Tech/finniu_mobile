import 'package:finniu/domain/entities/document.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final documentsUser = FutureProvider.family
    .autoDispose<UserDocuments?, String>((ref, uuid) async {
  try {
    final client = ref.watch(gqlClientProvider).value;

    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.getContratTaxReports,
        ),
        variables: {
          'preInvestmentUuid': uuid,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final data = result.data;

    if (data == null) {
      return null;
    }
    // final data = {
    //   "data": {
    //     "documentationQueries": {
    //       "contracts": [
    //         {
    //           "contractDate": "2024-12-01",
    //           "contractUrl": "https://example.com/contract1.pdf"
    //         }
    //       ],
    //       "taxes": [
    //         {"taxDate": "2024-12-02", "taxUrl": "https://example.com/tax1.pdf"}
    //       ],
    //       "quarterlyReports": [
    //         {
    //           "reportDate": "2024-12-03",
    //           "reportUrl": "https://example.com/report1.pdf"
    //         }
    //       ]
    //     }
    //   }
    // };

    final user = UserDocuments.fromJson(data["data"]!);
    return user;
  } catch (e) {
    print(e);
    return UserDocuments(
      contractList: [],
      taxList: [],
      reportList: [],
    );
  }
});
