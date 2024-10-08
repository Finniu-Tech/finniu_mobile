import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleForm extends ConsumerWidget {
  const TitleForm({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  final String title;
  final String subTitle;
  final String icon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleTextDark = 0xffA2E6FA;
    const int titleTextLight = 0xff0D3A5C;
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              TextPoppins(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textDark: titleTextDark,
                textLight: titleTextLight,
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                color: isDarkMode
                    ? const Color(titleTextDark)
                    : const Color(titleTextLight),
              ),
            ],
          ),
          TextPoppins(text: subTitle, fontSize: 14),
        ],
      ),
    );
  }
}
