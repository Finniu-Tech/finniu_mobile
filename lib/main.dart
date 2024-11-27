import 'package:finniu/app_config.dart';
import 'package:finniu/app_production.dart';
import 'package:finniu/app_staging.dart';
import 'package:finniu/firebase_options_prod.dart';
import 'package:finniu/firebase_options_staging.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

late AppConfig appConfig;

Future<void> mainCommon(AppConfig config) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.init();
    await initializeDateFormatting();
    await initHiveForFlutter();
    await Firebase.initializeApp(
      options: config.environment == "production"
          ? DefaultFirebaseOptionsProd.currentPlatform
          : DefaultFirebaseOptionsStaging.currentPlatform,
    );

    if (config.environment == "production" || config.environment == "staging") {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
    final container = ProviderContainer();
    final pushService = container.read(pushNotificationServiceProvider);
    await pushService.initialize();

    // final pushNotificationService = PushNotificationService(ref: ref);

    // await pushNotificationService.initialize();

    appConfig = config;
    runApp(
      ProviderScope(
        child: config.environment == "production"
            ? AppProduction(
                // pushNotificationService: pushService,
                )
            : AppStaging(
                // pushNotificationService: pushService,
                ),
      ),
    );
  } catch (error, stack) {
    print('Error during initialization: $error');
    if (config.environment == "production" || config.environment == "staging") {
      await FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
    rethrow;
  }
}
