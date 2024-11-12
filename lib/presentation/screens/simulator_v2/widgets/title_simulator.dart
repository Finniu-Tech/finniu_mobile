import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class TitleSimulator extends StatelessWidget {
  const TitleSimulator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int textDark = 0xffA2E6FA;
    const int textLight = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppins(
              text: 'Simula tu inversión de manera',
              fontSize: 20,
              lines: 2,
              textDark: textDark,
              textLight: textLight,
              fontWeight: FontWeight.w500,
            ),
            TextPoppins(
              text: 'rápida y sencilla 📈 💰',
              fontSize: 20,
              lines: 2,
              textDark: textDark,
              textLight: textLight,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
