import 'package:flutter_riverpod/flutter_riverpod.dart';

class PositionState {
  final double right;
  final double top;
  final bool isRender;
  final bool isMove;

  PositionState({
    required this.right,
    required this.top,
    required this.isRender,
    required this.isMove,
  });

  void updatePosition(double value, double value2) {}
}

class PositionNotifier extends StateNotifier<PositionState> {
  PositionNotifier()
      : super(
          PositionState(
            right: 20.0,
            top: 20.0,
            isRender: true,
            isMove: false,
          ),
        );

  void updatePosition(double newRight, double newTop, bool isRender) {
    state = PositionState(
      right: newRight,
      top: newTop,
      isRender: isRender,
      isMove: false,
    );
  }

  void setMove(bool newIsMove) {
    state = PositionState(
      right: state.right,
      top: state.top,
      isRender: state.isRender,
      isMove: newIsMove,
    );
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, PositionState>(
  (ref) => PositionNotifier(),
);
