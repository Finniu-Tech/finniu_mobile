import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/models/otp.dart';
import 'package:finniu/providers/graphql_provider.dart';
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
            },
            pollInterval: const Duration(seconds: 10),
          ),
        );
        return result;
      },
    );
    print('response!!!!!!');
    print(response);
    if (response.data == null) {
      return false;
    }
    final otp = ValidOtpUser.fromJson(response.data?['validOtpUser']);
    return otp.success;
  },
);

final otpResendCodeProvider = FutureProvider((ref) => null);
