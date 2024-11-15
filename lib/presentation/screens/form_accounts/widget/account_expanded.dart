import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountExpanded extends HookConsumerWidget {
  AccountExpanded({super.key, required this.children});
  final List<Widget> children;
  final controller = ExpansionTileController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> extended = useState(false);

    return ExpansionTile(
      controller: controller,
      trailing: SwitchWidget(
        value: extended.value,
        onTap: () {
          extended.value = !extended.value;
          extended.value ? controller.expand() : controller.collapse();
        },
      ),
      onExpansionChanged: (bool expanded) {},
      shape: const Border(),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPoppins(
            text: '¿Es una cuenta mancomunada?',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            align: TextAlign.start,
          ),
        ],
      ),
      children: children,
    );
  }
}
