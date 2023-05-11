import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/themes.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, String type,
      {bool isDarkMode = false}) {
    final currentTheme =
        isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme;

    final snackBar = SnackBar(
      backgroundColor: Color(whiteText),
      elevation: 0,
      content: Container(
        alignment: Alignment.center,
        height: 110,
        width: 310,
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
              left: 120,
              top: 20,
              child: _getTitle(type),
            ),
            Positioned(
              left: 110,
              top: 45,
              child: SizedBox(
                width: 200,
                height: 50,
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 2,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const SizedBox(
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getColor(String type) {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'error':
        return Colors.red;
      case 'info':
        return Colors.blue;
      default:
        return Colors.grey;
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
