import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseTokenScreen extends StatefulWidget {
  @override
  _FirebaseTokenScreenState createState() => _FirebaseTokenScreenState();
}

class _FirebaseTokenScreenState extends State<FirebaseTokenScreen> {
  String _fcmToken = 'Cargando...';
  String _apnsToken = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _getTokens();
  }

  Future<void> _getTokens() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    await _fcm.requestPermission();

    await Future.delayed(Duration(seconds: 1));

    String? apnsToken = await _fcm.getAPNSToken();

    String? fcmToken = await _fcm.getToken();

    setState(() {
      _apnsToken = apnsToken ?? 'No se pudo obtener el token APNS';
      _fcmToken = fcmToken ?? 'No se pudo obtener el token FCM';
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Token copiado al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Token'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Token APNS:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(_apnsToken, style: TextStyle(fontSize: 12))),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () => _copyToClipboard(_apnsToken),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('Token FCM:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(_fcmToken, style: TextStyle(fontSize: 12))),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () => _copyToClipboard(_fcmToken),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _getTokens,
              child: Text('Actualizar Tokens'),
            ),
          ],
        ),
      ),
    );
  }
}
