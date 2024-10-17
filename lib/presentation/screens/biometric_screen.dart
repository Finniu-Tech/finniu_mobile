import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricTestPage extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<void> _authenticate(BuildContext context) async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    bool isDeviceSupported = await localAuth.isDeviceSupported();
    print('canCheckBiometrics: $canCheckBiometrics');
    print('isDeviceSupported: $isDeviceSupported');

    final List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();

    print('availableBiometrics: $availableBiometrics');

    if (canCheckBiometrics) {
      try {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Por favor, autentícate para acceder',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );

        print('didAuthenticate: $didAuthenticate');

        if (didAuthenticate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Autenticación exitosa')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Autenticación fallida')),
          );
        }
      } catch (e) {
        print('Error en autenticación biométrica: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      if (!isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dispositivo no soportado')),
        );
      } else {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Por favor, autentícate con tu password para acceder',
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
      appBar: AppBar(title: Text('Prueba Biométrica')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _authenticate(context),
          child: Text('Autenticar con Biometría'),
        ),
      ),
    );
  }
}
