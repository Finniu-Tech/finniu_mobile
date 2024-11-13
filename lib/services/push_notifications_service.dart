import 'dart:async';
import 'dart:convert';
import 'package:finniu/infrastructure/datasources/notifications_datasource_imp.dart';
// import 'package:finniu/main.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/notification_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final pushNotificationRouteProvider = StateProvider<String?>((ref) => null);
// final navigatorKeyProvider = Provider((ref) => GlobalKey<NavigatorState>());

final pushNotificationServiceProvider = Provider((ref) {
  final navigatorKey = ref.watch(globalNavigatorKeyProvider);
  return PushNotificationService(ref, navigatorKey);
});

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  // No manejes la navegación aquí, solo guarda la información si es necesario
}

class PushNotificationService {
  final Ref _ref;
  final GlobalKey<NavigatorState> navigatorKey;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _pendingNavigation = <String>[];
  RemoteMessage? _pendingLogMessage;

  PushNotificationService(this._ref, this.navigatorKey);

  NotificationsDataSource get _notificationDataSource => _ref.read(notificationsDataSourceProvider);

  Future<void> initialize() async {
    await Firebase.initializeApp();

    // Solo inicializar lo básico, sin solicitar permisos
    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }

    // NO solicitar permisos aquí
    // NO suscribir a tópicos aquí
  }

  Future<String?> initializeAfterLogin() async {
    // Solicitar permisos y verificar la respuesta
    NotificationSettings settings = await requestPermissions();

    // Verificar el estado de la autorización
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Solo si los permisos fueron autorizados, obtener y gestionar token
      String? token = await getToken();
      if (token != null) {
        print("FirebaseMessaging token: $token");
        await _fcm.subscribeToTopic('all');
        return token;
      }
    } else {
      // Si los permisos fueron denegados, verificar si debemos mostrar el recordatorio
      bool reminderShown = await _hasReminderBeenShown();
      if (!reminderShown) {
        // Aquí necesitaremos el context, así que modificaremos la firma del método
        throw PushNotificationPermissionDeniedException();
      }
    }
    return null;
  }

// Crear una excepción personalizada

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
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        print("onDidReceiveLocalNotification xxx: $payload");
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

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        print("onDidReceiveNotificationResponse: $notificationResponse");
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          print('notification payload: $payload');
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
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return settings;
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("onForegroundMessage: $message");
    _showNotification(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print("onMessageOpenedApp: $message");
    print('data from message: ${message.data}');

    // Envolver en try-catch para manejar posibles errores de estado
    try {
      if (checkAuthentication()) {
        _logNotificationOpenAsync(message);
        _handleNotificationNavigation(message.data);
      } else {
        print('User not authenticated, saving message for later: ${message.data}');
        _pendingLogMessage = message;
        _handleNotificationNavigation(message.data);
      }
    } catch (e) {
      print('Error in handleMessageOpenedApp: $e');
      // En caso de error, asumimos que el usuario no está autenticado
      _pendingLogMessage = message;
      _handleNotificationNavigation(message.data);
    }
  }

  void _handleMessage(RemoteMessage message) {
    print('handleMessage: $message');
    _handleMessageOpenedApp(message);
  }

  void _handleInitialMessage(RemoteMessage message) {
    print("App opened from terminated state: $message");
    _handleNotificationNavigation(message.data);
  }

  void _showNotification(RemoteMessage message) async {
    print("showNotification: $message");
    print('notification: ${message.notification?.title}');
    print('notification: ${message.notification?.body}');
    print('notification: ${message.data}');

    RemoteNotification? notification = message.notification;

    if (notification != null) {
      // Configuración específica para iOS
      const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
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
      final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      final NotificationDetails platformChannelSpecifics = NotificationDetails(
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

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    print("Handling notification navigation: $data");
    bool isAuthenticated = false;

    try {
      isAuthenticated = checkAuthentication();
    } catch (e) {
      print('Error checking authentication in navigation: $e');
    }

    print('Is authenticated: $isAuthenticated');
    String route = data['deep_link'] ?? '/';

    if (!isAuthenticated) {
      print('Not authenticated, saving route and navigating to login');
      try {
        _ref.read(pushNotificationRouteProvider.notifier).state = route;
      } catch (e) {
        print('Error saving route: $e');
      }
      _scheduleNavigation('/v2/login_email');
    } else {
      print('Authenticated');
      if (_pendingLogMessage != null) {
        _logNotificationOpenAsync(_pendingLogMessage!);
        _pendingLogMessage = null;
      }
      _scheduleNavigation(route);
    }
  }

  Future<bool> checkSavedNotificationRoute() async {
    String? savedRoute;
    bool isAuthenticated = false;

    try {
      savedRoute = _ref.read(pushNotificationRouteProvider);
      isAuthenticated = checkAuthentication();
    } catch (e) {
      print('Error checking saved route: $e');
      return false;
    }

    print('Checking saved notification route: $savedRoute');

    if (savedRoute != null && isAuthenticated) {
      try {
        if (_pendingLogMessage != null) {
          await _logNotificationOpen(_pendingLogMessage!);
          _pendingLogMessage = null;
        }

        _performNavigation(savedRoute);
        _ref.read(pushNotificationRouteProvider.notifier).state = null;
        return true;
      } catch (e) {
        print('Error processing saved route: $e');
        return false;
      }
    }
    return false;
  }

  Future<void> processPendingNotificationLog() async {
    print('processPendingNotificationLog: $_pendingLogMessage');
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
      print("APNS Token: $apnsToken");

      // Luego intentar obtener el token FCM
      String? fcmToken = await _fcm.getToken();
      print("FCM Token: $fcmToken");

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
    print('scheduleNavigation START: $route');
    print('NavigatorKey: $navigatorKey');
    print('NavigatorKey current state: ${navigatorKey.currentState}');
    print('NavigatorKey current context: ${navigatorKey.currentContext}');

    Future.delayed(const Duration(milliseconds: 100), () {
      if (navigatorKey.currentState == null) {
        print('Navigator is null, adding to pending navigation');
        _pendingNavigation.add(route);
      } else {
        print('Navigator is ready, performing navigation');
        _performNavigation(route);
      }
    });
  }

  void _performNavigation(String route) {
    print('performNavigation START: $route');
    if (navigatorKey.currentState == null) {
      print('Navigator still null in perform navigation, adding to pending');
      _pendingNavigation.add(route);
      return;
    }

    try {
      print('Attempting navigation to: $route');
      navigatorKey.currentState!.pushReplacementNamed(route);
      print('Navigation successful');
    } catch (e) {
      print('Navigation error: $e');
      // Intentar navegar a la ruta por defecto
      try {
        navigatorKey.currentState?.pushReplacementNamed('/v2/home');
      } catch (e) {
        print('Fallback navigation also failed: $e');
      }
    }
  }

  void processPendingNavigations() {
    while (_pendingNavigation.isNotEmpty) {
      final route = _pendingNavigation.removeAt(0);
      _performNavigation(route);
    }
  }

  // Método check authentication similar al DeepLinkHandler
  bool checkAuthentication() {
    final token = _ref.read(authTokenProvider);
    print('Checking authentication: $token');
    if (token == '') {
      print('Not authenticated');
      return false;
    } else {
      print('Authenticated');
      return true;
    }
  }

  void showLaterReminderModal(BuildContext context) {
    showThanksInvestmentDialog(
      context,
      textTitle: 'Entendemos!',
      textTanks: '',
      textBody: 'Puedes activar las notificaciones cuando quieras, o en cualquier momento desde tu perfil.',
      textButton: 'Ok',
      onPressed: () => Navigator.pop(context),
      onClosePressed: () => Navigator.pop(context),
    );
  }

  Future<void> _cleanupOldTokens() async {
    await _fcm.deleteToken();
    print('Token antiguo eliminado');
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
    print('message data: ${message.data}');
    // try {
    final dataSource = _notificationDataSource;
    final String userID = message.data['user_id'] ?? '';
    final deviceInfo = await DeviceInfoService().getDeviceInfo(userID);
    final token = await getToken();
    final extraData = message.data['extra_data'] != null ? json.decode(message.data['extra_data']) : null;

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
}

class PushNotificationPermissionDeniedException implements Exception {
  final String message = 'Push notification permissions were denied';
}
