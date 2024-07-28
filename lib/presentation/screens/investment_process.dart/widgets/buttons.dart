import 'package:finniu/constants/colors.dart';
import 'package:finniu/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectBankAccountButtonWidget extends StatelessWidget {
  const SelectBankAccountButtonWidget({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.svgPath,
    required this.backgroundColor,
    required this.isDarkMode,
  });

  final String textButton;
  final VoidCallback onPressed;
  final String svgPath;
  final Color backgroundColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 320,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(38),
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Container(
              child: SvgPicture.asset(
                // 'assets/svg_icons/card-send.svg',
                svgPath,
                width: 20,
                height: 20,
                color: isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
              ),
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: adjustColor(backgroundColor),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              textButton,
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode ? const Color(whiteText) : const Color(primaryDark),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_rounded),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
