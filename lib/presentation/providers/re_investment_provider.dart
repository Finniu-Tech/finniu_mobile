import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/datasources/re_investment_datasoruce_imp.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/responde_models.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rejectReInvestmentProvider = FutureProvider.family
    .autoDispose<RejectReInvestmentResult, RejectReInvestmentParams>(
        (ref, params) async {
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

final selectedBankAccountSenderProvider =
    StateProvider.autoDispose<BankAccount?>((ref) {
  return null;
});

final selectedBankAccountReceiverProvider =
    StateProvider.autoDispose<BankAccount?>((ref) {
  return null;
});

final createReInvestmentProvider = FutureProvider.family
    .autoDispose<CreateReInvestmentResponse, CreateReInvestmentParams>(
        (ref, params) async {
  final reInvestmentDataSource = ReInvestmentDataSource(
    ref.watch(gqlClientProvider).value!,
  );
  final response = await reInvestmentDataSource.createReInvestment(
    preInvestmentUUID: params.preInvestmentUUID,
    finalAmount: params.finalAmount,
    currency: params.currency,
    deadlineUUID: params.deadlineUUID,
    coupon: params.coupon,
    originFounds: params.originFounds,
    typeReinvestment: params.typeReinvestment,
    bankAccountSender: params.bankAccountSender,
  );
  return response;
});

final updateReInvestmentProvider = FutureProvider.family
    .autoDispose<UpdateReInvestmentResponse, UpdateReInvestmentParams>(
        (ref, params) async {
  final reinvestmentDataSource = ReInvestmentDataSource(
    ref.watch(gqlClientProvider).value!,
  );
  return reinvestmentDataSource.updateReInvestment(
    preInvestmentUUID: params.preInvestmentUUID,
    userReadContract: params.userReadContract,
    files: params.files,
    bankAccountSender: params.bankAccountSender,
    bankAccountReceiver: params.bankAccountReceiver,
  );
});

final setBankAccountUserProvider = FutureProvider.autoDispose
    .family<SetBankAccountUserResponse, SetBankAccountUserParams>(
        (ref, params) async {
  final reinvestmentDataSource = ReInvestmentDataSource(
    ref.watch(gqlClientProvider).value!,
  );
  final resp = await reinvestmentDataSource.setBankAccountReceiver(
    reInvestmentUUID: params.reInvestmentUUID,
    bankAccountReceiver: params.bankAccountReceiver,
  );
  return resp;
});
