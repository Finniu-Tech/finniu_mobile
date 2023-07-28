import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isSolesStateProvider = StateNotifierProvider<SwitchMoneyNotifier, bool>(
  (ref) => SwitchMoneyNotifier(),
);

class SwitchMoneyNotifier extends StateNotifier<bool> {
  SwitchMoneyNotifier() : super(true);

  void toggleSwitch(bool value) {
    state = value;
  }
}
