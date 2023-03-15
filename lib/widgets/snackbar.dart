import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

// SnackBar customSnackBar = SnackBar(
//   backgroundColor: const Color(primaryLight),
//   action: SnackBarAction(
//     textColor: const Color(primaryDark),
//     label: 'Cerrar',
//     onPressed: () {},
//   ),
//   content: const Text(
//     'No se pudo validar el código de verificación',
//     textAlign: TextAlign.center,
//   ),
//   duration: const Duration(milliseconds: 3000),
//   width: 280, // Width of the SnackBar.
//   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//   behavior: SnackBarBehavior.floating,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(10.0),
//   ),
// );

// customSnackBar(String message, String type) {
//   return SnackBar(
//     backgroundColor: const Color(primaryLight),
//     action: SnackBarAction(
//       textColor: const Color(primaryDark),
//       label: 'Cerrar',
//       onPressed: () {},
//     ),
//     content: Text(
//       message,
//       textAlign: TextAlign.center,
//     ),
//     duration: const Duration(milliseconds: 3000),
//     width: 280, // Width of the SnackBar.
//     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//   );
// }

import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, String type) {
    final snackBar = SnackBar(
      content: SizedBox(
        height: 110,
        width: 310,
        child: Stack(children: [
          Center(
            child: Container(
              height: 102,
              width: 302,
              decoration: BoxDecoration(
                // border: Border.all(color: _getColor(type)),
                border: Border(
                  top: BorderSide(
                    color: _getColor(type),
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: _getColor(type),
                    width: 2,
                  ),
                  right: BorderSide(
                    color: _getColor(type),
                    width: 2,
                  ),
                  left: BorderSide(
                    color: _getColor(type),
                    width: 2,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(20),
                ),
                // color: _getColor(type),
              ),
              child: Row(
                children: [
                  // Container(
                  //   // margin: const EdgeInsets.only(right: 10),
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(30),
                  //       topRight: Radius.circular(10),
                  //       bottomRight: Radius.circular(30),
                  //       bottomLeft: Radius.circular(10),
                  //     ),
                  //     color: Colors.white,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: _getImage(type),
                  //   ),
                  // ),
                  Container(
                    width: 103,
                    height: 128,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/error_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      duration: const Duration(seconds: 10),
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

  static Widget _getImage(String type) {
    switch (type) {
      case 'success':
        return const Icon(Icons.check, color: Colors.green);
      case 'error':
        return const Icon(Icons.error, color: Colors.red);
      case 'info':
        return const Icon(Icons.info, color: Colors.blue);
      default:
        return Container();
    }
  }
}
