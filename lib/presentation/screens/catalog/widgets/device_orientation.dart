library device_orientation;

import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Absolute device orientation stream.
///
/// It's not dependent on current app rotation mode
/// rather reflects physical device orientation.
///
/// Emits only changes in orientation, no two identical
/// orientation readings will ever be emitted.
///
/// On devices that does not support
/// sensors it will default to [DeviceOrientation.portraitUp].
Stream<DeviceOrientation> deviceOrientation$ = accelerometerEventStream()
    .map<DeviceOrientation>(_accelerometerEventToDeviceOrientation)
    .distinct();

/// Current absolute device orientation.
///
/// The last known device orientation. On devices that does not support
/// sensors it will default to [DeviceOrientation.portraitUp].
DeviceOrientation deviceOrientation = _lastKnownOrientation;

DeviceOrientation _lastKnownOrientation = DeviceOrientation.portraitUp;

/// Given that accelerometer event includes gravity force
/// and assuming that user will not shake the device
/// like crazy we can calculate device rotation
/// by looking for the most accelerated axis.
///
/// The axis are x, y, and z where (when holding the device portrait up):
/// - x is the acceleration to the right, -x is the acceleration to the left,
/// - y is the acceleration to the top, -y is the acceleration to the bottom,
/// - z is the acceleration to the back of the device, -z is the acceleration to front.
///
/// When one of x or y is the largest, we can calculate the rotation.
/// When z is the largest, we will return last x, y reading
/// because it probably means that the device is laying on the table
/// and the user does not want to change the orientation.
DeviceOrientation _accelerometerEventToDeviceOrientation(
    AccelerometerEvent event) {
  final absoluteX = event.x.abs();
  final absoluteY = event.y.abs();
  final absoluteZ = event.z.abs();

  if (absoluteZ > absoluteX && absoluteZ > absoluteY) {
    return _lastKnownOrientation;
  }

  late DeviceOrientation orientation;
  if (absoluteX > absoluteY) {
    orientation = event.x > 0
        ? DeviceOrientation.landscapeRight
        : DeviceOrientation.landscapeLeft;
  } else {
    orientation = event.y > 0
        ? DeviceOrientation.portraitUp
        : DeviceOrientation.portraitDown;
  }

  _lastKnownOrientation = orientation;
  return orientation;
}

extension RotationValue on DeviceOrientation {
  double get turns {
    switch (this) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeLeft:
        return -.25;
      case DeviceOrientation.landscapeRight:
        return .25;
      case DeviceOrientation.portraitDown:
        return .5;
    }
  }
}
