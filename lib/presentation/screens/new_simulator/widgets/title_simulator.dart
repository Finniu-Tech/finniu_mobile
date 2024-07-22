import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleModal extends ConsumerWidget {
  const TitleModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColor = 0xff55B63D;
    const int textColorDark = 0xffFFFFFF;
    const int textColorLight = 0xff0D3A5C;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Resumen de mi inversión",
          style: TextStyle(
            color: isDarkMode
                ? const Color(textColorDark)
                : const Color(textColorLight),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          width: 73,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(backgroundColor),
          ),
          child: Center(
            child: Text(
              "En curso",
              style: TextStyle(
                color: isDarkMode ? Colors.black : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
