import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FrequentlyQuestionsScreen extends ConsumerWidget {
  const FrequentlyQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Preguntas frecuentes",
      children: Column(),
    );
  }
}
