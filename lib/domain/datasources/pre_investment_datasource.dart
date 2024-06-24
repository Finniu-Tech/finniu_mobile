import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class PreInvestmentDataSource {
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    // required String bankAccountNumber,
    required String bankAccountTypeUuid,
    required String deadLineUuid,
    required String planUuid,
    required String currency,
    String? coupon,
    required String bankAccountNumber,
    required OriginFunds originFunds,
  });

  Future<PreInvestmentUpdateResponseAPI> update({
    required GraphQLClient client,
    required String uuid,
    required bool readContract,
    required List<String> files,
  });
}
