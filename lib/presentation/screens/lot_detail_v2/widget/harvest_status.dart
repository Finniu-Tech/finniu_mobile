import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HarvestStatus extends ConsumerWidget {
  const HarvestStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xff5BA9FF;
    const int borderLight = 0xff5BA9FF;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 227,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isDarkMode ? const Color(borderDark) : const Color(borderLight),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: const Column(
        children: [
          _ProcessStatus(),
          _ImageStack(),
        ],
      ),
    );
  }
}

class _ImageStack extends StatelessWidget {
  const _ImageStack();

  @override
  Widget build(BuildContext context) {
    return Stack(children: []);
  }
}

class _ProcessStatus extends StatelessWidget {
  const _ProcessStatus();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextPoppins(text: "Proceso de ", fontSize: 11),
        TextPoppins(
          text: "2 cosecha",
          fontSize: 11,
          isBold: true,
        ),
      ],
    );
  }
}
