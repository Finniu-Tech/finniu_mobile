import 'package:flutter/material.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';

class TitleSupport extends StatelessWidget {
  const TitleSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int backgroundColor = 0xff0D3A5C;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      color: const Color(backgroundColor),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            height: 48,
            child: TextPoppins(
              text: "Reporta cualquier problema del sistema",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              textDark: textColor,
              textLight: textColor,
              lines: 2,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
