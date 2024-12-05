import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<SaveCorporateInvestmentResponse> savePreInvestment(
  BuildContext context,
  WidgetRef ref,
  SaveCorporateInvestmentInput input,
) async {
  final response =
      await ref.read(saveCorporateInvestmentFutureProvider(input).future);
  return response;
}
