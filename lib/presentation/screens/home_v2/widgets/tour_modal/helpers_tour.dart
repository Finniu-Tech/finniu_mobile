import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void seeAnotherTime(BuildContext context, WidgetRef ref, {idFinal = false}) {
  if (idFinal) {
    print("es el ulitmo");
    ref.read(seeLaterProvider.notifier).state = true;
  } else {
    print("no es el ulitmo");
    ref.read(seeLaterProvider.notifier).state = true;
  }
  Navigator.pop(context);
}
