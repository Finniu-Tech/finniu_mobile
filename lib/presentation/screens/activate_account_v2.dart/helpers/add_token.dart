import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/infrastructure/repositories/auth_repository_imp.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void addToken(BuildContext context, WidgetRef ref, String code) {
  final userProfile = ref.watch(userProfileNotifierProvider);
  final futureIsValidCode = ref.watch(
    otpValidatorFutureProvider(
      OTPForm(
        email: userProfile.email!,
        otp: code,
        action: 'register',
      ),
    ).future,
  );
  futureIsValidCode.then((status) async {
    if (status == true) {
      final userProfile = ref.watch(userProfileNotifierProvider);

      final login = LoginModel(
        email: userProfile.email!,
        password: userProfile.password!,
      );

      final graphqlProvider = ref.watch(gqlClientProvider.future);
      final loginResponse = AuthRepository().login(
        client: await graphqlProvider,
        username: login.email.toLowerCase(),
        password: login.password,
      );
      loginResponse.then((value) {
        if (value.success) {
          final token = ref.watch(
            authTokenMutationProvider(
              LoginModel(
                email: login.email.toLowerCase(),
                password: login.password,
              ),
            ).future,
          );
          token.then((value) {
            if (value != null) {
              ref.read(authTokenProvider.notifier).state = value;
              Navigator.pushNamed(context, '/v2/form_personal_data');
            } else {
              CustomSnackbar.show(
                context,
                "Error al procesar la solicitud token error",
                'error',
              );
            }
          });
        } else {
          CustomSnackbar.show(
            context,
            "Error al procesar la solicitud d loginResponse false",
            'error',
          );
        }
      });
    } else {
      Navigator.of(context).pop();
      CustomSnackbar.show(
        context,
        'No se pudo validar el código de verificación',
        'error',
      );
    }
    context.loaderOverlay.hide();
  });
}
