import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupportTicketScreen extends ConsumerWidget {
  const SupportTicketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Ticket de soporte",
      children: _BodySupportTicket(),
    );
  }
}

class _BodySupportTicket extends StatelessWidget {
  const _BodySupportTicket();

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
