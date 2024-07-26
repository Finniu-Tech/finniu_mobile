import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MilestonesAchieved extends ConsumerWidget {
  const MilestonesAchieved({
    super.key,
    required this.longShort,
    required this.title,
    required this.date,
  });
  final bool longShort;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff1C1C1C;
    const int containerLight = 0xffE3F0FF;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
      ),
      width: 175,
      height: longShort ? 91 : 69,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPoppins(
            text: title,
            fontSize: 14,
            isBold: true,
            lines: longShort ? 3 : 2,
          ),
          TextPoppins(
            text: date,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
