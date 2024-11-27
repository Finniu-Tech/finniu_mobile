import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:finniu/infrastructure/models/notifications/notification_model.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/notification_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/utils/debug_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPermissionHandler extends HookConsumerWidget {
  final UserProfile profile;
  final Widget child;

  const NotificationPermissionHandler({
    Key? key,
    required this.profile,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileFutureProvider);
    final setupState = ref.watch(notificationSetupStateNotifierProvider);

    useEffect(() {
      userProfileAsync.whenData((profile) async {
        if (profile.id != null && !setupState.isInitialized) {
          await _initializeNotifications(context, ref, profile);
        }
      });
      return null;
    }, [userProfileAsync]);

    return child;
  }

  Future<void> _initializeNotifications(BuildContext context, WidgetRef ref, UserProfile profile) async {
    await DebugLogger.log('Initializing notifications');
    await _handleNotificationPermission(context, ref, profile);
    await _handlePendingNavigation(ref);
    ref.read(notificationSetupStateNotifierProvider.notifier).markInitialized();
  }

  Future<void> _handleNotificationPermission(BuildContext context, WidgetRef ref, UserProfile profile) async {
    await DebugLogger.log('Starting notification permission handling');
    final pushNotificationService = ref.read(pushNotificationServiceProvider);
    final setupNotifier = ref.read(notificationSetupStateNotifierProvider.notifier);

    try {
      final deviceInfo = await DeviceInfoService().getDeviceInfo(profile.id!);
      late NotificationPreferences preferences;
      await DebugLogger.log('Device info obtained: ${deviceInfo.toJson()}');

      final existingDevice = await pushNotificationService.getDeviceById(deviceId: deviceInfo.deviceId);
      print('existingDevice: $existingDevice');
      await DebugLogger.log('Existing device check: ${existingDevice != null}');
      if (existingDevice != null) {
        print('Existing device found');
        await DebugLogger.log('Existing device found: ${existingDevice.toJson()}');
        return;
      }
      final settings = await pushNotificationService.requestPermissions();
      String? token;

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('AuthorizationStatus.authorized');
        token = await pushNotificationService.getToken();
        preferences = NotificationPreferences(
          acceptsOperational: true,
          acceptsMarketing: true,
          permissionState: PushStatus.active,
        );
      } else {
        print('AuthorizationStatus.denied');
        preferences = NotificationPreferences(
          acceptsOperational: false,
          acceptsMarketing: false,
          permissionState: PushStatus.denied,
        );
      }
      await _registerNewDevice(
        pushNotificationService,
        deviceInfo,
        preferences,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _showSuccessDialog(context);
      } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
        await _showDeniedDialog(context, ref);
      }
      setupNotifier.markDialogShown();
    } catch (e, stackTrace) {
      print('Error in notification handling: $e');
      print('Error in notification handling: $e\n$stackTrace');
      await DebugLogger.log('Error in notification handling: $e\n$stackTrace');

      if (!ref.read(notificationSetupStateNotifierProvider).hasShownDialog) {
        await _showErrorDialog(context);
        setupNotifier.markDialogShown();
      }
    }
  }

  Future<void> _updateExistingDevice(
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

  Future<void> _handlePendingNavigation(WidgetRef ref) async {
    final pushNotificationService = ref.read(pushNotificationServiceProvider);
    final savedRoute = Preferences.pendingNotificationRoute;

    await DebugLogger.log('Checking for pending navigation. Saved route: $savedRoute');

    if (savedRoute != null) {
      await pushNotificationService.processPendingNotificationLog();
      pushNotificationService.performNavigation(savedRoute);
      Preferences.pendingNotificationRoute = null;
    }
  }

  Future<void> _registerNewDevice(
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

  Future<void> _showSuccessDialog(BuildContext context) async {
    showThanksInvestmentDialog(
      context,
      textTitle: '¡Notificaciones activadas!',
      textBody: 'Ahora recibirás actualizaciones importantes sobre tus inversiones.',
      textButton: 'Entendido',
      onPressed: () => Navigator.pop(context),
      textTanks: '',
    );
  }

  Future<void> _showDeniedDialog(BuildContext context, WidgetRef ref) async {
    ref.read(pushNotificationServiceProvider).showLaterReminderModal(context);
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    print('showErrorDialog xxxx');
    showThanksInvestmentDialog(
      context,
      textTitle: 'Notificaciones',
      textBody: 'No pudimos completar la configuración de notificaciones. Puedes intentarlo más tarde desde tu perfil.',
      textButton: 'Entendido',
      onPressed: () => Navigator.pop(context),
      textTanks: '',
    );
  }
}
