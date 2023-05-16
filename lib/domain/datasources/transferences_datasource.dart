import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TransferenceDataSource {
  Future<List<String>> getBoucherList({
    required GraphQLClient client,
  });
}
