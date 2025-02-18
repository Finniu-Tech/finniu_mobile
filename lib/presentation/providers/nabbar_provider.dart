import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NabbarProvider {
  final String title;
  final VoidCallback onTap;

  NabbarProvider({
    required this.title,
    required this.onTap,
  });
  NabbarProvider copyWith({
    String? title,
    VoidCallback? onTap,
  }) {
    return NabbarProvider(
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
    );
  }
}

class NabbarNotifier extends StateNotifier<NabbarProvider> {
  NabbarNotifier()
      : super(
          NabbarProvider(
            title: 'Simular',
            onTap: () => {
              print('Default OnTap'),
            },
          ),
        );

  void updateTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void updateOnTap(VoidCallback newOnTap) {
    state = state.copyWith(onTap: newOnTap);
  }

  void updateNabbar(NabbarProvider newNabbar) {
    state = state.copyWith(
      title: newNabbar.title,
      onTap: newNabbar.onTap,
    );
  }

  void onPressed() {
    state.onTap();
  }
}

final nabbarProvider =
    StateNotifierProvider<NabbarNotifier, NabbarProvider>((ref) {
  return NabbarNotifier();
});
