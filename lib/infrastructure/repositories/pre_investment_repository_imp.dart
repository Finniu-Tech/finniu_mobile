import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/domain/repositories/pre_investment_repository.dart';
import 'package:finniu/infrastructure/datasources/pre_investment_imp_datasource.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreInvestmentRepositoryImp implements PreInvestmentRepository {
  PreInvestmentRepositoryImp({
    required this.dataSource,
  });

  final PreInvestmentDataSourceImp dataSource;

  @override
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    // required String bankAccountNumber,
    required String deadLineUuid,
    required String planUuid,
    required String currency,
    String? coupon,
    required String? bankAccountNumber,
    required OriginFunds? originFunds,
  }) async {
    return await dataSource.save(
      client: client,
      amount: amount,
      // bankAccountNumber: bankAccountNumber,
      deadLineUuid: deadLineUuid,
      planUuid: planUuid,
      coupon: coupon,
      currency: currency,
      bankAccountNumber: bankAccountNumber,
      originFunds: originFunds,
    );
  }
}
