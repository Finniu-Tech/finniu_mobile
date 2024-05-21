import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final otpValidatorFutureProvider = FutureProvider.family(
  (ref, OTPForm otpForm) async {
    final response = await ref.watch(gqlClientProvider.future).then(
      (client) async {
        final QueryResult result = await client.query(
          QueryOptions(
            document: gql(
              MutationRepository.validateOTP(),
            ), // this is the query string you just created
            variables: {
              'email': otpForm.email,
              'code': otpForm.otp,
              'action': otpForm.action,
            },
          ),
        );
        return result;
      },
    );
    if (response.data == null) {
      return false;
    }
    final otp = ValidOtpUser.fromJson(response.data?['validOtpUser']);
    return otp.success;
  },
);

final otpResendCodeProvider = FutureProvider((ref) => null);

final resendOTPCodeFutureProvider = FutureProvider((ref) async {
  final response = await ref.watch(gqlClientProvider.future).then(
    (client) async {
      final user = ref.watch(userProfileNotifierProvider);
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(
            MutationRepository.resendOTPCode(),
          ), // this is the query string you just created
          variables: {
            'email': user.email,
          },
        ),
      );
      return result;
    },
  );
  if (response.data == null) {
    return false;
  }
  final otpResendModel = ResendOtpCode.fromJson(response.data?['resendOtpCode']);
  return otpResendModel.success;
});

Future<bool> sendEmailOTPCode(String email, GraphQLClient client) async {
  final QueryResult result = await client.query(
    QueryOptions(
      document: gql(
        MutationRepository.sendEmailOTPCode(),
      ), // this is the query string you just created
      variables: {
        'email': email,
      },
      fetchPolicy: FetchPolicy.noCache,
      // pollInterval: const Duration(seconds: 10),
    ),
  );
  if (result.data == null) {
    return false;
  }
  final otpResendModel = EmailOTPCodeResponse.fromJson(result.data?['sendMailOtp']);
  if (otpResendModel.successResendCode == false || otpResendModel.success == false) {
    return false;
  }
  return otpResendModel.success ?? false;
}
