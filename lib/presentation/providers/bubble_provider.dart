import 'package:flutter_riverpod/flutter_riverpod.dart';

class PositionState {
  final double left;
  final double top;

  PositionState({
    required this.left,
    required this.top,
  });

  void updatePosition(double value, double value2) {}
}

class PositionNotifier extends StateNotifier<PositionState> {
  PositionNotifier()
      : super(
          PositionState(
            left: 20.0,
            top: 20.0,
          ),
        );

  void updatePosition(
    double newRight,
    double newTop,
  ) {
    state = PositionState(
      left: newRight,
      top: newTop,
    );
  }

  void resetMoveAndHide() {
    state = PositionState(
      left: 20,
      top: 20,
    );
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, PositionState>(
  (ref) => PositionNotifier(),
);
