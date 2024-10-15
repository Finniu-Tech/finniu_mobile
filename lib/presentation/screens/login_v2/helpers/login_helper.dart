import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/domain/entities/routes_entity.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/infrastructure/repositories/auth_repository_imp.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/network_warning.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/services/deep_link_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';

void loginEmailHelper({
  required BuildContext context,
  required WidgetRef ref,
  required String email,
  required String password,
  required bool rememberPassword,
  required FlutterSecureStorage secureStorage,
}) async {
  try {
    final graphqlProvider = ref.watch(gqlClientProvider.future);
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      context.loaderOverlay.hide();
      showNetworkWarning(context: context);
      return;
    }

    final loginResponse = AuthRepository().login(
      client: await graphqlProvider,
      username: email.toLowerCase(),
      password: password,
    );
    loginResponse.then((value) {
      if (value.success == true) {
        final token = ref.watch(
          authTokenMutationProvider(
            LoginModel(
              email: email.toLowerCase(),
              password: password,
            ),
          ).future,
        );
        token.then(
          (value) async {
            if (value != null) {
              ref.read(firebaseAnalyticsServiceProvider).logLogin(email);
              showSnackBarV2(
                context: context,
                title: "Inicio de sesión exitoso",
                message: "Bienvenido $email",
                snackType: SnackType.success,
              );
              ref.read(authTokenProvider.notifier).state = value;
              Preferences.username = email.toLowerCase();
              context.loaderOverlay.hide();
              if (rememberPassword) {
                await secureStorage.write(
                  key: 'password',
                  value: password,
                );
              }

              final featureFlags = await ref.read(userFeatureFlagListFutureProvider.future);
              ref.read(featureFlagsProvider.notifier).setFeatureFlags(featureFlags);

              final String route = ref.watch(featureFlagsProvider.notifier).isEnabled(FeatureFlags.homeV2)
                  ? FeatureRoutes.getRouteForFlag(
                      FeatureFlags.homeV2,
                      defaultHomeRoute,
                    )
                  : defaultHomeRoute;

              final deepLinkHandler = ref.read(deepLinkHandlerProvider);
              bool hadDeepLink = await deepLinkHandler.checkSavedDeepLink();

              if (!hadDeepLink) {
                print('is null stored deep link');
                Navigator.pushNamed(
                  context,
                  route,
                );
              }
            }
          },
          onError: (err) {
            context.loaderOverlay.hide();
          },
        );
      } else {
        context.loaderOverlay.hide();
        if (value.error == 'Su usuario no a sido activado') {
          showSnackBarV2(
            context: context,
            title: value.error ?? 'Su usuario no a sido activado',
            message: "Por favor, revisa tu correo para activar tu cuenta",
            snackType: SnackType.error,
          );

          ref.read(userProfileNotifierProvider.notifier).updateFields(
                email: email,
                password: password,
              );
          final user = ref.read(userProfileNotifierProvider);
          print(user.email);
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushNamed(context, '/v2/send_code');
          });
        } else {
          showSnackBarV2(
            context: context,
            title: value.error ?? 'No se pudo validar sus credenciales',
            message: "Por favor, revisa tus credenciales",
            snackType: SnackType.error,
          );
        }
      }
    });
  } catch (e) {
    context.loaderOverlay.hide();
    showSnackBarV2(
      context: context,
      title: 'Error',
      message: 'Ocurrió un problema, vuelva a intentarlo en unos minutos',
      snackType: SnackType.error,
    );
  }
}
