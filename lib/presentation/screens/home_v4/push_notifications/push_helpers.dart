// ignore_for_file: use_build_context_synchronously

import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:finniu/infrastructure/models/notifications/notification_model.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/notification_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/utils/debug_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> initializeNotifications(
  BuildContext context,
  WidgetRef ref,
  UserProfile profile,
) async {
  // await DebugLogger.log('Initializing notifications');
  await handleNotificationPermission(context, ref, profile);
  await handlePendingNavigation(ref);
  ref.read(notificationSetupStateNotifierProvider.notifier).markInitialized();
}

Future<void> handleNotificationPermission(
  BuildContext context,
  WidgetRef ref,
  UserProfile profile,
) async {
  await DebugLogger.log('Starting notification permission handling');
  final pushNotificationService = ref.read(pushNotificationServiceProvider);
  final setupNotifier =
      ref.read(notificationSetupStateNotifierProvider.notifier);

  try {
    final deviceInfo = await DeviceInfoService().getDeviceInfo(profile.id!);
    late NotificationPreferences preferences;
    await DebugLogger.log('Device info obtained: ${deviceInfo.toJson()}');

    final existingDevice = await pushNotificationService.getDeviceById(
      deviceId: deviceInfo.deviceId,
    );

    await DebugLogger.log('Existing device check: ${existingDevice != null}');
    if (existingDevice != null) {
      await DebugLogger.log(
        'Existing device found: ${existingDevice.toJson()}',
      );
      return;
    }
    final settings = await pushNotificationService.requestPermissions();
    // String? token;

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // token = await pushNotificationService.getToken();
      preferences = NotificationPreferences(
        acceptsOperational: true,
        acceptsMarketing: true,
        permissionState: PushStatus.active,
      );
    } else {
      preferences = NotificationPreferences(
        acceptsOperational: false,
        acceptsMarketing: false,
        permissionState: PushStatus.denied,
      );
    }
    await registerNewDevice(
      pushNotificationService,
      deviceInfo,
      preferences,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await showSuccessDialog(context);
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      await showDeniedDialog(context, ref);
    }
    setupNotifier.markDialogShown();
  } catch (e, stackTrace) {
    await DebugLogger.log('Error in notification handling: $e\n$stackTrace');

    if (!ref.read(notificationSetupStateNotifierProvider).hasShownDialog) {
      await showErrorDialog(context);
      setupNotifier.markDialogShown();
    }
  }
}

Future<void> updateExistingDevice(
  PushNotificationService service,
  String deviceId,
  String? token,
  NotificationPreferences preferences,
) async {
  await service.updateDevice(
    deviceId: deviceId,
    updates: {
      'token': token,
      'last_used': DateTime.now().toIso8601String(),
      'state': preferences.permissionState.name,
      'accepts_operational': preferences.acceptsOperational,
      'accepts_marketing': preferences.acceptsMarketing,
    },
  );
}

Future<void> handlePendingNavigation(WidgetRef ref) async {
  final pushNotificationService = ref.read(pushNotificationServiceProvider);
  final savedRoute = Preferences.pendingNotificationRoute;

  // await DebugLogger.log(
  //     'Checking for pending navigation. Saved route: $savedRoute');

  if (savedRoute != null) {
    await pushNotificationService.processPendingNotificationLog();
    pushNotificationService.performNavigation(savedRoute);
    Preferences.pendingNotificationRoute = null;
  }
}

Future<void> registerNewDevice(
  PushNotificationService service,
  DeviceInfoModel deviceInfo,
  NotificationPreferences preferences,
) async {
  final registration = DeviceRegistrationModel(
    deviceInfo: deviceInfo,
    notificationPreferences: preferences,
  );
  await service.registerDevice(device: registration);
}

Future<void> showSuccessDialog(BuildContext context) async {
  showThanksInvestmentDialog(
    context,
    textTitle: '¡Notificaciones activadas!',
    textBody:
        'Ahora recibirás actualizaciones importantes sobre tus inversiones.',
    textButton: 'Entendido',
    onPressed: () => Navigator.pop(context),
    textTanks: '',
  );
}

Future<void> showDeniedDialog(BuildContext context, WidgetRef ref) async {
  ref.read(pushNotificationServiceProvider).showLaterReminderModal(context);
}

Future<void> showErrorDialog(BuildContext context) async {
  showThanksInvestmentDialog(
    context,
    textTitle: 'Notificaciones',
    textBody:
        'No pudimos completar la configuración de notificaciones. Puedes intentarlo más tarde desde tu perfil.',
    textButton: 'Entendido',
    onPressed: () => Navigator.pop(context),
    textTanks: '',
  );
}
