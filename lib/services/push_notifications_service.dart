import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> requestPermissions(BuildContext context) async {
    bool reminderShown = await _hasReminderBeenShown();

    // Solicitar permisos
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permisos de notificación concedidos');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('Permisos de notificación denegados');
      if (!reminderShown) {
        _showLaterReminderModal(context);
        await _setReminderShown();
      }
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

  Future<void> _cleanupOldTokens() async {
    await _fcm.deleteToken();
    print('Token antiguo eliminado');
  }

  void _handleMessage(RemoteMessage message) {
    print("Notificación recibida: ${message.notification?.title}");
    // Implementa la lógica para manejar la notificación
  }

  void _showLaterReminderModal(BuildContext context) {
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

  Future<bool> _hasReminderBeenShown() async {
    return Preferences.showedPushNotificationReminder;
  }

  Future<void> _setReminderShown() async {
    Preferences.showedPushNotificationReminder = true;
  }
}
