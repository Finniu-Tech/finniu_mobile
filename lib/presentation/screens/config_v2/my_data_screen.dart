import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDataScreen extends ConsumerWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Mis datos",
      children: _BodyMyData(),
    );
  }
}

class _BodyMyData extends StatelessWidget {
  const _BodyMyData();

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
