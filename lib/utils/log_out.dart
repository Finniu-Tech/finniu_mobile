import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_repository_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/last_operation_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/plan_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/rentability_graphic_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

logOut(BuildContext context, WidgetRef ref) {
  ref.invalidate(authTokenProvider);
  ref.invalidate(gqlClientProvider);
  ref.invalidate(userProfileFutureProvider);
  ref.invalidate(bankFutureProvider);
  ref.invalidate(deadLineFutureProvider);
  ref.invalidate(hasCompletedOnboardingProvider);
  ref.invalidate(userAcceptedTermsProvider);
  ref.invalidate(
    finishOnboardingFutureStateNotifierProvider,
  );
  ref.invalidate(importantDaysFutureProvider);
  ref.invalidate(
    startOnBoardingFutureStateNotifierProvider,
  );
  ref.invalidate(
    updateOnboardingFutureStateNotifierProvider,
  );
  ref.invalidate(onBoardingStateNotifierProvider);
  ref.invalidate(
    recommendedPlanStateNotifierProvider,
  );
  ref.invalidate(otpValidatorFutureProvider);
  ref.invalidate(otpResendCodeProvider);
  ref.invalidate(planListFutureProvider);
  ref.invalidate(preInvestmentSaveProvider);
  ref.invalidate(homeReportProvider);
  ref.invalidate(userProfileNotifierProvider);
  ref.invalidate(
    userProfileBalanceNotifierProvider,
  );
  ref.invalidate(settingsNotifierProvider);
  ref.invalidate(isSolesStateProvider);
  ref.invalidate(homeReportProviderV2);
  ref.invalidate(bankRepositoryProvider);
  ref.invalidate(featureFlagsDataSourceProvider);
  ref.invalidate(featureFlagsProvider);
  ref.invalidate(userFeatureFlagListFutureProvider);
  ref.invalidate(rentabilityGraphicFutureProvider);
  ref.invalidate(userInfoAllInvestmentFutureProvider);
  ref.invalidate(lastOperationsFutureProvider);
  ref.invalidate(lastOperationDataSourceProvider);

  // logout(ref);
  Navigator.of(context).pushNamedAndRemoveUntil(
    '/v2/on_boarding',
    (route) => true,
  );
}
