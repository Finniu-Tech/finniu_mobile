import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:finniu/infrastructure/datasources/notifications_datasource_imp.dart';
import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:finniu/infrastructure/models/notifications/notification_model.dart';
// import 'package:finniu/main.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/notification_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/utils/debug_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final pushNotificationRouteProvider = StateProvider<String?>((ref) => null);

final pushNotificationServiceProvider = Provider((ref) {
  final navigatorKey = ref.watch(globalNavigatorKeyProvider);
  return PushNotificationService(ref, navigatorKey);
});

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await DebugLogger.log('Received background message: ${message.messageId}');
  await DebugLogger.log('Message data: ${message.data}');
}

class PushNotificationService {
  final Ref _ref;
  final GlobalKey<NavigatorState> navigatorKey;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final _pendingNavigation = <String>[];
  RemoteMessage? _pendingLogMessage;

  PushNotificationService(this._ref, this.navigatorKey);

  NotificationsDataSource get _notificationDataSource =>
      _ref.read(notificationsDataSourceProvider);

  Future<void> initialize() async {
    await Firebase.initializeApp();

    // Solo inicializar lo básico, sin solicitar permisos
    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  Future<String?> initializeAfterLogin() async {
    NotificationSettings settings = await requestPermissions();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await getToken();
      if (token != null) {
        await _fcm.subscribeToTopic('all');
        return token;
      }
    } else {
      bool reminderShown = await _hasReminderBeenShown();
      if (!reminderShown) {
        throw PushNotificationPermissionDeniedException();
      }
    }
    return null;
  }

  Future<void> _initializeLocalNotifications() async {
    // Crear el canal de Android con configuración completa
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      showBadge: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        if (payload != null) {
          _handleNotificationNavigation(json.decode(payload));
        }
      },
      notificationCategories: [
        DarwinNotificationCategory(
          'default',
          actions: [
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain('id_2', 'Action 2'),
          ],
        ),
      ],
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          _handleNotificationNavigation(json.decode(payload));
        }
      },
    );
  }

  Future<NotificationSettings> requestPermissions() async {
    // Solicitar permisos de FCM
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Solicitar permisos locales
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return settings;
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _showNotification(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) async {
    await DebugLogger.log('App opened from notification: ${message.toMap()}');
    try {
      if (checkAuthentication()) {
        await DebugLogger.log('User is authenticated');
        _logNotificationOpenAsync(message);
        _handleNotificationNavigation(message.data);
      } else {
        await DebugLogger.log(
            'User not authenticated, saving message for later');
        _pendingLogMessage = message;
        _handleNotificationNavigation(message.data);
      }
    } catch (e) {
      await DebugLogger.log('Error in handleMessageOpenedApp: $e');

      // En caso de error, asumimos que el usuario no está autenticado
      _pendingLogMessage = message;
      _handleNotificationNavigation(message.data);
    }
  }

  void _handleMessage(RemoteMessage message) {
    _handleMessageOpenedApp(message);
  }

  void _handleInitialMessage(RemoteMessage message) {
    _handleNotificationNavigation(message.data);
  }

  void _showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      // Configuración específica para iOS
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        badgeNumber: 1,
        threadIdentifier: 'thread_id',
        attachments: null,
        categoryIdentifier: 'default',
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      // Configuración específica para Android
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: json.encode(message.data),
      );
    }
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) async {
    await DebugLogger.log('Starting navigation with data: $data');
    String route = data['deep_link'] ?? '/v2/notifications';

    // Guardar la ruta en preferences
    Preferences.pendingNotificationRoute = route;
    await DebugLogger.log('Route saved: $route');

    bool isAuthenticated = false;
    try {
      isAuthenticated = checkAuthentication();
      await DebugLogger.log('Authentication status: $isAuthenticated');
    } catch (e) {
      await DebugLogger.log('Error checking authentication: $e');
    }

    if (!isAuthenticated) {
      _scheduleNavigation('/v2/login_email');
    } else {
      if (_pendingLogMessage != null) {
        _logNotificationOpenAsync(_pendingLogMessage!);
        _pendingLogMessage = null;
      }
      _scheduleNavigation(route);
      Preferences.pendingNotificationRoute =
          null; // Limpiar la ruta después de usarla
    }
  }

  Future<bool> checkSavedNotificationRoute() async {
    await DebugLogger.log('Checking saved notification route');

    try {
      final savedRoute = Preferences.pendingNotificationRoute;
      final isAuthenticated = checkAuthentication();

      await DebugLogger.log(
          'Saved route: $savedRoute, authenticated: $isAuthenticated');

      if (savedRoute != null && isAuthenticated) {
        if (_pendingLogMessage != null) {
          await _logNotificationOpen(_pendingLogMessage!);
          _pendingLogMessage = null;
        }

        // Programar la navegación para el siguiente frame
        Future.microtask(() {
          performNavigation(savedRoute);
          Preferences.pendingNotificationRoute = null;
        });

        return true;
      }
    } catch (e) {
      await DebugLogger.log('Error checking saved route: $e');
      print('Error checking saved route: $e');
    }

    return false;
  }

  Future<void> processPendingNotificationLog() async {
    if (_pendingLogMessage == null) return;

    try {
      final isAuthenticated = checkAuthentication();
      if (isAuthenticated) {
        await _logNotificationOpen(_pendingLogMessage!);
        _pendingLogMessage = null;
      }
    } catch (e) {
      print('Error processing pending notification log: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      // Intentar obtener el token APNS primero (para iOS)
      String? apnsToken = await _fcm.getAPNSToken();

      // Luego intentar obtener el token FCM
      String? fcmToken = await _fcm.getToken();

      return fcmToken;
    } catch (e) {
      print('Error al obtener token: $e');
      if (e.toString().contains('TOO_MANY_REGISTRATIONS')) {
        print('Error: Demasiadas solicitudes de registro');
        await _cleanupOldTokens();
        return await _fcm.getToken();
      }
      return null;
    }
  }

  void _scheduleNavigation(String route) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (navigatorKey.currentState == null) {
        _pendingNavigation.add(route);
      } else {
        performNavigation(route);
      }
    });
  }

  void performNavigation(String route) {
    if (navigatorKey.currentState == null) {
      _pendingNavigation.add(route);
      return;
    }

    try {
      // Reemplazar pushReplacementNamed por pushNamedAndRemoveUntil
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        route,
        (route) => false, // Esto remueve todas las rutas previas
      );
    } catch (e) {
      print('Navigation error: $e');
      // Intentar navegar a la ruta por defecto
      try {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/v2/home',
          (route) => false, // También limpiar stack en caso de fallback
        );
      } catch (e) {
        print('Fallback navigation also failed: $e');
      }
    }
  }

  void processPendingNavigations() {
    while (_pendingNavigation.isNotEmpty) {
      final route = _pendingNavigation.removeAt(0);
      performNavigation(route);
    }
  }

  // Método check authentication similar al DeepLinkHandler
  bool checkAuthentication() {
    final token = _ref.read(authTokenProvider);

    if (token == '') {
      return false;
    } else {
      return true;
    }
  }

  void showLaterReminderModal(BuildContext context) {
    showThanksInvestmentDialog(
      context,
      textTitle: 'Entendemos!',
      textTanks: '',
      textBody:
          'Puedes activar las notificaciones cuando quieras, o en cualquier momento desde tu perfil.',
      textButton: 'Ok',
      onPressed: () => Navigator.pop(context),
      onClosePressed: () => Navigator.pop(context),
    );
  }

  Future<void> _cleanupOldTokens() async {
    await _fcm.deleteToken();
  }

  Future<bool> _hasReminderBeenShown() async {
    return Preferences.showedPushNotificationReminder;
  }

  Future<void> setReminderShown() async {
    Preferences.showedPushNotificationReminder = true;
  }

  Future<bool> hasRequestedPermission() async {
    return Preferences.hasRequestedPushNotificationPermission;
  }

  Future<void> setRequestedPermission() async {
    Preferences.hasRequestedPushNotificationPermission = true;
  }

  void _logNotificationOpenAsync(RemoteMessage message) {
    unawaited(_logNotificationOpen(message));
  }

  Future<void> _logNotificationOpen(RemoteMessage message) async {
    // try {
    final dataSource = _notificationDataSource;
    final String userID = message.data['user_id'] ?? '';
    final deviceInfo = await DeviceInfoService().getDeviceInfo(userID);
    final token = await getToken();
    final extraData = message.data['extra_data'] != null
        ? json.decode(message.data['extra_data'])
        : null;

    await dataSource.saveNotificationLog(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      userId: message.data['user_id'] ?? '',
      notificationType: message.data['notification_type'] ?? 'operational',
      campaignId: message.data['campaign_id'] ?? '',
      status: 'open',
      deviceId: deviceInfo.deviceId,
      token: token ?? '',
      parentNotificationUuid: message.data['notification_uuid'],
      extraData: extraData,
    );
  }

  Future<bool> areNotificationsEnabled() async {
    final settings = await _fcm.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<bool> requestNativePermissions(
      BuildContext context, PushNotificationService pushService) async {
    if (Platform.isIOS) {
      final goToSettings = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Activar Notificaciones'),
          content: const Text(
            'Para recibir notificaciones, necesitas activarlas en la configuración de tu iPhone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Ir a Configuración'),
            ),
          ],
        ),
      );

      if (goToSettings == true) {
        await openAppSettings();
        // Esperar a que el usuario regrese y verificar el estado de los permisos
        return await _checkPermissionsAfterSettings();
      }
      return false;
    } else {
      // En Android
      final settings = await requestPermissions();
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    }
  }

  Future<bool> _checkPermissionsAfterSettings() async {
    await Future.delayed(const Duration(seconds: 1));
    return await areNotificationsEnabled();
  }

  Future<NotificationPreferences> getDevicePreferences(
      {required String deviceId}) async {
    try {
      final device =
          await _notificationDataSource.getDeviceById(deviceId: deviceId);
      return device?.notificationPreferences ??
          NotificationPreferences(
              acceptsMarketing: true, acceptsOperational: true);
    } catch (e) {
      print('Error getting device preferences: $e');
      return NotificationPreferences(
          acceptsMarketing: true, acceptsOperational: true);
    }
  }

  void startPermissionListener({
    required BuildContext context,
    required VoidCallback onPermissionGranted,
  }) {
    bool wasInBackground = false;

    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.paused.toString()) {
        wasInBackground = true;
      }

      if (msg == AppLifecycleState.resumed.toString() && wasInBackground) {
        final isEnabled = await areNotificationsEnabled();
        if (isEnabled) {
          onPermissionGranted();
        }
        wasInBackground = false;
      }
      return null;
    });
  }

  Future<void> updateDevicePreferences({
    required String deviceId,
    required NotificationPreferences preferences,
  }) async {
    try {
      await _notificationDataSource.updateDevice(
          deviceId: deviceId, updates: preferences.toJson());
    } catch (e) {
      print('Error updating device preferences: $e');
      DebugLogger.log('Error updating device preferences: $e');
      rethrow;
    }
  }

  Future<void> updateDevice(
      {required String deviceId, required Map<String, dynamic> updates}) async {
    try {
      await _notificationDataSource.updateDevice(
          deviceId: deviceId, updates: updates);
    } catch (e) {
      print('Error updating device: $e');
      DebugLogger.log('Error updating device: $e');
      rethrow;
    }
  }

  Future<void> registerDevice({required DeviceRegistrationModel device}) async {
    try {
      await _notificationDataSource.saveDeviceToken(device);
    } catch (e) {
      print('Error registering device: $e');
      DebugLogger.log('Error registering device: $e');
      rethrow;
    }
  }

  Future<DeviceRegistrationModel?> getDeviceById(
      {required String deviceId}) async {
    try {
      return await _notificationDataSource.getDeviceById(deviceId: deviceId);
    } catch (e) {
      print('Error registering device: $e');
      DebugLogger.log('Error registering device: $e');
      rethrow;
    }
  }
}

class PushNotificationPermissionDeniedException implements Exception {
  final String message = 'Push notification permissions were denied';
}
