import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/scan_document_v2/widgets/custom_border_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScanBack extends ConsumerWidget {
  const ScanBack({
    super.key,
    required this.onTap,
  });
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xffA2E6FA;
    const int borderLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onTap,
      child: CustomBorderContainer(
        borderColorDark: borderDark,
        borderColorLight: borderLight,
        isDarkMode: isDarkMode,
        height: 170,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: Center(
            child: Image.asset(
              "assets/images/document_back_image.png",
              width: 87,
              height: 55,
            ),
          ),
        ),
      ),
    );
  }
}
