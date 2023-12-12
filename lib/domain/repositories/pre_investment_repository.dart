import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class PreInvestmentRepository {
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    // required String bankAccountNumber,
    required String bankAccountTypeUuid,
    required String deadLineUuid,
    required String currency,
    required String planUuid,
  });
}
