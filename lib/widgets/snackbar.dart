import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, String type) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width / 2 - 140,
        width: 280,
        height: 90,
        child: Material(
          color: Colors.transparent,
          child: SnackBarBody(
            message: message,
            type: type,
            onDismiss: () => overlayEntry.remove(),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
  }
}

class SnackBarBody extends HookConsumerWidget {
  final String message;
  final String type;
  final VoidCallback onDismiss;

  const SnackBarBody({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(40),
          ),
          color: themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              _getBackgroundImage(type),
              semanticsLabel: 'Error',
            ),
            Positioned(
              left: 50,
              child: SizedBox(
                height: 55,
                width: 45,
                child: Image.asset(_getImage(type)),
              ),
            ),
            Positioned(
              left: 90,
              top: 10,
              child: _getTitle(type),
            ),
            Positioned(
              left: 90,
              top: 30,
              child: Center(
                child: Container(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 4),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 2,
              child: InkWell(
                onTap: onDismiss,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getBackgroundImage(String type) {
    switch (type) {
      case 'success':
        return 'assets/svg/snackbar-success.svg';
      case 'error':
        return 'assets/svg/snackbar-error.svg';
      case 'info':
        return 'assets/svg/snackbar-info.svg';
      default:
        return 'assets/svg/snackbar-info.svg';
    }
  }

  static String _getImage(String type) {
    switch (type) {
      case 'success':
        return 'assets/images/happy-face.png';
      case 'error':
        return 'assets/images/sad-face.png';
      case 'info':
        return 'assets/images/rocket.png';
      default:
        return 'assets/images/rocket.png';
    }
  }

  static Widget _getTitle(String type) {
    switch (type) {
      case 'success':
        return const Text(
          'Completado con éxito',
          style: TextStyle(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        );
      case 'error':
        return const Text('Upss, algo salió mal',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ));
      case 'info':
        return const Text('Bienvenido a Finniu!',
            style: TextStyle(
              color: Color(0xff0D3A5C),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ));
      default:
        return const Text('Info');
    }
  }
}
