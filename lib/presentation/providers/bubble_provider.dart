import 'package:flutter_riverpod/flutter_riverpod.dart';

class PositionState {
  final double left;
  final double top;
  final bool isRender;

  PositionState({
    required this.left,
    required this.top,
    this.isRender = true,
  });

  void updatePosition(double value, double value2) {}
}

class PositionNotifier extends StateNotifier<PositionState> {
  PositionNotifier()
      : super(
          PositionState(
            left: 40.0,
            top: 40.0,
          ),
        );

  void updatePosition(
    double newRight,
    double newTop,
  ) {
    state = PositionState(
      left: newRight,
      top: newTop,
      isRender: state.isRender,
    );
  }

  void resetBubble() {
    state = PositionState(left: 20, top: 20, isRender: false);
  }

  void getBubble() {
    state = PositionState(left: 20, top: 20, isRender: true);
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, PositionState>(
  (ref) => PositionNotifier(),
);
