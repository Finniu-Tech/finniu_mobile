import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TransferenceDataSource {
  Future<List<TransferenceEntity>> getBoucherList({
    required GraphQLClient client,
  });
}
