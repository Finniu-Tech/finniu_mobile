import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccointCard extends ConsumerWidget {
  const AccointCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isJoint,
  });
  final String title;
  final String subtitle;
  final bool isJoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff272727;
    const int backgroundLight = 0xffF7F7F7;
    const int iconDark = 0xff000000;
    const int iconLight = 0xff000000;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 101,
      child: Row(
        children: [
          const SizedBox(
            width: 70,
            child: Center(child: Icon(Icons.credit_card, size: 50)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: title,
                fontSize: 15,
                isBold: true,
              ),
              TextPoppins(
                text: subtitle,
                fontSize: 12,
                isBold: true,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg_icons/${isJoint ? "user_joint_icon" : "user_icon"}.svg",
                    width: 20,
                    height: 20,
                    color: isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
                  ),
                  const SizedBox(width: 5),
                  TextPoppins(
                    text: isJoint ? "Cuenta mancomunada" : "Cuenta personal",
                    fontSize: 11,
                    isBold: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
