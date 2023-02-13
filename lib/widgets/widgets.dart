import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoaderOverlay extends StatelessWidget {
  dynamic _child;
  CustomLoaderOverlay({super.key, child}) {
    _child = child;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: _child,
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitCircle(
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}
// Widget CustomLoaderOverlay(child) {
//   return LoaderOverlay(
//     child: child,
//     useDefaultLoading: false,
//     overlayWidget: Center(
//       child: SpinKitRotatingCircle(
//         color: Colors.grey,
//         size: 50.0,
//       ),
//     ),
//   );
// }
