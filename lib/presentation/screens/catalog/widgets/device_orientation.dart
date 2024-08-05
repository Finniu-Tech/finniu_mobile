library device_orientation;

import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

Stream<DeviceOrientation> deviceOrientation$ = accelerometerEventStream()
    .map<DeviceOrientation>(_accelerometerEventToDeviceOrientation)
    .distinct();

DeviceOrientation deviceOrientation = _lastKnownOrientation;

DeviceOrientation _lastKnownOrientation = DeviceOrientation.portraitUp;

DeviceOrientation _accelerometerEventToDeviceOrientation(
  AccelerometerEvent event,
) {
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
