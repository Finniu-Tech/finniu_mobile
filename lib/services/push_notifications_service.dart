import 'dart:async';
import 'dart:convert';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/deep_link_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Asegúrate de que esta función esté fuera de cualquier clase
final pushNotificationRouteProvider = StateProvider<String?>((ref) => null);
final navigatorKeyProvider = Provider((ref) => GlobalKey<NavigatorState>());

final pushNotificationServiceProvider = Provider((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
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

  PushNotificationService(this._ref, this.navigatorKey);

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

    // Modificar aquí: establecer todos los request* en false
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false, // Cambiar a false
      requestBadgePermission: false, // Cambiar a false
      requestSoundPermission: false, // Cambiar a false
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

  // Future<void> requestPermissions(BuildContext context) async {
  //   bool reminderShown = await _hasReminderBeenShown();

  //   // Solicitar permisos
  //   NotificationSettings settings = await _fcm.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   // Solicitar permisos de notificaciones locales para iOS
  //   await _flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );

  //   // Solicitar permisos de notificaciones locales para Android
  //   await _flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('Permisos de notificación concedidos');
  //   } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
  //     print('Permisos de notificación denegados');
  //     if (!reminderShown) {
  //       _showLaterReminderModal(context);
  //       await _setReminderShown();
  //     }
  //   }
  // }

  void _handleForegroundMessage(RemoteMessage message) {
    print("onForegroundMessage: $message");
    _showNotification(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print("onMessageOpenedApp: $message");
    _handleNotificationNavigation(message.data);
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
      final DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true, // Muestra la alerta incluso en primer plano
        presentBadge: true, // Actualiza el badge
        presentSound: true, // Reproduce el sonido
        sound: 'default', // Nombre del archivo de sonido
        badgeNumber: 1, // Número que se mostrará en el ícono
        threadIdentifier: 'thread_id', // Identificador para agrupar notificaciones
        attachments: null, // Archivos adjuntos si los hay
        categoryIdentifier: 'default', // Categoría de la notificación
        interruptionLevel: InterruptionLevel.timeSensitive, // Nivel de interrupción
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
    final isAuthenticated = _checkAuthentication();
    print('Is authenticated: $isAuthenticated');

    String route = data['screen'] ?? '/';

    if (!isAuthenticated) {
      print('Not authenticated');
      // _ref.read(pushNotificationRouteProvider.notifier).state = route;
      _scheduleNavigation('/v2/login_email');
    } else {
      print('Authenticated');
      _scheduleNavigation(route);
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
    if (navigatorKey.currentState == null) {
      _pendingNavigation.add(route);
    } else {
      _performNavigation(route);
    }
  }

  void _performNavigation(String route) {
    print('Performing navigation to: $route');
    navigatorKey.currentState?.pushReplacementNamed(route);
  }

  void processPendingNavigations() {
    while (_pendingNavigation.isNotEmpty) {
      final route = _pendingNavigation.removeAt(0);
      _performNavigation(route);
    }
  }

  bool _checkAuthentication() {
    final token = _ref.read(authTokenProvider);
    print('Checking authentication: $token');
    return token != '';
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

  Future<bool> checkSavedNotificationRoute() async {
    return false;
    // final savedRoute = _ref.read(pushNotificationRouteProvider);
    // print('Checking saved notification route: $savedRoute');
    // if (savedRoute != null) {
    //   final isAuthenticated = _checkAuthentication();
    //   if (isAuthenticated) {
    //     _performNavigation(savedRoute);
    //     _ref.read(pushNotificationRouteProvider.notifier).state = null;
    //     return true;
    //   } else {
    //     _performNavigation('/v2/login_email');
    //     return false;
    //   }
    // } else {
    //   print('No saved notification route found');
    //   return false;
    // }
  }
}

class PushNotificationPermissionDeniedException implements Exception {
  final String message = 'Push notification permissions were denied';
}

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   bool _initialized = false;
//   late WidgetRef _ref;

//   Future<void> initialize() async {
//     if (_initialized) return;
//     _initialized = true;

//     FirebaseMessaging.onMessage.listen(_handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }

//   set ref(WidgetRef ref) {
//     _ref = ref;
//   }

//   Future<void> requestPermissions(BuildContext context) async {
//     bool reminderShown = await _hasReminderBeenShown();

//     // Solicitar permisos
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('Permisos de notificación concedidos');
//     } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
//       print('Permisos de notificación denegados');
//       if (!reminderShown) {
//         _showLaterReminderModal(context);
//         await _setReminderShown();
//       }
//     }
//   }

//   Future<String?> getToken() async {
//     try {
//       // Intentar obtener el token APNS primero (para iOS)
//       String? apnsToken = await _fcm.getAPNSToken();
//       print("APNS Token: $apnsToken");

//       // Luego intentar obtener el token FCM
//       String? fcmToken = await _fcm.getToken();
//       print("FCM Token: $fcmToken");

//       return fcmToken;
//     } catch (e) {
//       print('Error al obtener token: $e');
//       if (e.toString().contains('TOO_MANY_REGISTRATIONS')) {
//         print('Error: Demasiadas solicitudes de registro');
//         await _cleanupOldTokens();
//         return await _fcm.getToken();
//       }
//       return null;
//     }
//   }

//   Future<void> _cleanupOldTokens() async {
//     await _fcm.deleteToken();
//     print('Token antiguo eliminado');
//   }

//   void _handleMessage(RemoteMessage message) {
//     // this works for local notifications
//     print("Notificación recibida: ${message.notification?.title}");
//     print('Notificación recibida: ${message}');
//     print('Notificación recibida: ${message.data}');
//     print('Notificación recibida: ${message.messageId}');
//     String? deepLink = message.data['deep_link'];
//     print('deep_link: $deepLink');
//     if (deepLink != null && deepLink.isNotEmpty) {
//       print('Deep link found: $deepLink');
//       final deepLinkHandler = _ref.read(deepLinkHandlerProvider);
//       deepLinkHandler.handleDeepLink(Uri.parse(deepLink));

//       // Implementa la lógica para manejar la notificación
//       // # TODO: add deep link logic here
//     }
//   }

//   void _showLaterReminderModal(BuildContext context) {
//     showThanksInvestmentDialog(
//       context,
//       textTitle: 'Entendemos!',
//       textTanks: '',
//       textBody: 'Puedes activar las notificaciones cuando quieras, o en cualquier momento desde tu perfil.',
//       textButton: 'Ok',
//       onPressed: () => Navigator.pop(context),
//       onClosePressed: () => Navigator.pop(context),
//     );
//   }

//   Future<bool> _hasReminderBeenShown() async {
//     return Preferences.showedPushNotificationReminder;
//   }

//   Future<void> _setReminderShown() async {
//     Preferences.showedPushNotificationReminder = true;
//   }
// }
