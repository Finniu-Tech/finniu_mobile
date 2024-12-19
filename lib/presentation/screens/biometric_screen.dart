import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricTestPage extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  BiometricTestPage({super.key});

  Future<void> _authenticate(BuildContext context) async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    bool isDeviceSupported = await localAuth.isDeviceSupported();
    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();
    if (canCheckBiometrics) {
      try {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Por favor, autentícate para acceder',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );

        if (didAuthenticate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Autenticación exitosa')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Autenticación fallida')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      if (!isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispositivo no soportado')),
        );
      } else {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason:
              'Por favor, autentícate con tu password para acceder',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Biometría no disponible en este dispositivo')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba Biométrica')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _authenticate(context),
          child: const Text('Autenticar con Biometría'),
        ),
      ),
    );
  }
}
