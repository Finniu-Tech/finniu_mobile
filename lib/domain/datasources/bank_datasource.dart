import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class BankDataSource {
  Future<List<BankEntity>> getBanks({
    required GraphQLClient client,
  });
}
