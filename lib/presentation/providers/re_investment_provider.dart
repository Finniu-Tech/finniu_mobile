import 'package:finniu/infrastructure/datasources/re_investment_datasoruce_imp.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/responde_models.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rejectReInvestmentProvider =
    FutureProvider.family.autoDispose<RejectReInvestmentResult, RejectReInvestmentParams>((ref, params) async {
  final reinvestmentDataSource = ReInvestmentDataSource(
    ref.watch(gqlClientProvider).value!,
  );
  final resp = reinvestmentDataSource.rejectReInvestment(
    preInvestmentUUID: params.preInvestmentUUID,
    rejectMotivation: params.rejectMotivation,
    textRejected: params.textRejected,
  );
  return resp;
});
