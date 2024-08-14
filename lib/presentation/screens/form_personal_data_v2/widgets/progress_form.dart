import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgressForm extends ConsumerWidget {
  const ProgressForm({
    super.key,
    required this.progress,
  });
  final double progress;
  final int progressDark = 0xffA2E6FA;
  final int progressLight = 0xff0D3A5C;
  final int unSelectDark = 0xff353535;
  final int unSelectLight = 0xffC1F1FF;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Color(unSelectDark) : Color(unSelectLight),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Color(progressDark) : Color(progressLight),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * progress,
          height: 7,
        ),
      ],
    );
  }
}
