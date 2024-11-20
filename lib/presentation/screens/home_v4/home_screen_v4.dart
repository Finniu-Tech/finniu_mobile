import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/home_v4/widget/scaffold_home_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeScreenV4 extends StatelessWidget {
  const HomeScreenV4({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldHomeV4(
      body: HomeBodyV4(),
    );
  }
}

class HomeBodyV4 extends HookConsumerWidget {
  const HomeBodyV4({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> loader = useState(false);
    void onPressed() {
      loader.value = !loader.value;
    }

    loader.addListener(() {
      if (loader.value) {
        context.loaderOverlay.show();
      } else {
        Future.delayed(const Duration(seconds: 1));
        context.loaderOverlay.hide();
      }
    });

    return Column(
      children: [
        const Center(
          child: Text('Home Screen V4'),
        ),
        ButtonInvestment(text: "loader", onPressed: onPressed),
      ],
    );
  }
}
