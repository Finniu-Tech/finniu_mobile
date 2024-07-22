import 'package:finniu/presentation/screens/catalog/widgets/device_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Rotates given child widget to match
/// device orientation with animation.
/// To use without animation, check [AlwaysDown]
/// widget.
class AnimatedAlwaysDown extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  /// Rotates given [child] according to current device orientation.
  const AnimatedAlwaysDown({
    super.key,
    required this.child,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<DeviceOrientation>(
        stream: deviceOrientation$,
        initialData: deviceOrientation,
        builder: (context, snapshot) => AnimatedRotation(
          curve: curve,
          alignment: alignment,
          duration: duration,
          turns: snapshot.data!.turns,
          child: child,
        ),
      );
}
