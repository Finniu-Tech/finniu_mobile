import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class ButtonIconTour extends StatelessWidget {
  const ButtonIconTour({
    super.key,
    required this.widthPercent,
    required this.onPressed,
    required this.label,
  });
  final double widthPercent;
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    const int buttonColor = 0xffA2E6FA;
    const int textButtonColor = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthPercent,
      height: 40,
      child: TextButton.icon(
        iconAlignment: IconAlignment.end,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(buttonColor),
          ),
        ),
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_forward_sharp,
          color: Color(textButtonColor),
        ),
        label: TextPoppins(
          text: label,
          fontSize: 16,
          isBold: false,
          textDark: textButtonColor,
          textLight: textButtonColor,
        ),
      ),
    );
  }
}

class ButtonCloseTour extends StatelessWidget {
  const ButtonCloseTour({
    super.key,
    required this.widthPercent,
    required this.onPressed,
    required this.label,
  });
  final double widthPercent;
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    const int buttonColor = 0xff0E4D7D;
    const int textButtonColor = 0xffFFFFFF;
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthPercent,
      height: 40,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(buttonColor),
          ),
        ),
        onPressed: onPressed,
        child: TextPoppins(
          text: label,
          fontSize: 16,
          isBold: false,
          textDark: textButtonColor,
          textLight: textButtonColor,
        ),
      ),
    );
  }
}
