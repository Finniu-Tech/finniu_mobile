import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class PreInvestmentDataSource {
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    String? coupon,
    required String currency,
    required String deadLineUuid,
    required String planUuid,
    String? bankAccountSender,
    OriginFunds? originFunds,
  });

  Future<PreInvestmentUpdateResponseAPI> update({
    required GraphQLClient client,
    required String uuid,
    required bool readContract,
    required List<String> files,
  });
}
