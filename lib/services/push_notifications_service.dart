import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Solicitar permisos
    await _fcm.requestPermission();

    // Esperar un poco antes de solicitar el token
    await Future.delayed(Duration(seconds: 1));

    // Intentar obtener el token APNS primero
    String? apnsToken = await _fcm.getAPNSToken();
    print("APNS Token: $apnsToken");

    // Luego intentar obtener el token FCM
    String? fcmToken = await _fcm.getToken();
    print("FCM Token: $fcmToken");

    if (fcmToken != null) {
      // Aquí deberías enviar este token a tu backend
    } else {
      print("No se pudo obtener el token FCM");
    }

    // Configurar manejadores de notificaciones
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("Notificación recibida: ${message.notification?.title}");
    // Implementa la lógica para manejar la notificación
  }
}
