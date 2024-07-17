import 'package:finniu/app_config.dart';
import 'package:finniu/app_production.dart';
import 'package:finniu/app_staging.dart';
import 'package:finniu/firebase_options.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await initializeDateFormatting();
  await initHiveForFlutter();
  if (config.environment == "production") {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (!kDebugMode) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }
  appConfig = config;
  runApp(ProviderScope(child: config.environment == "production" ? const AppProduction() : const AppStaging()));
}
