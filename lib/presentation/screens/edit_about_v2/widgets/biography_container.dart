import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class BiographyContainer extends StatelessWidget {
  const BiographyContainer({
    super.key,
    required this.biography,
  });

  final String? biography;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TextPoppins(
            text: "Biografía",
            fontSize: 16,
            isBold: true,
          ),
          TextPoppins(
            text: biography ?? "",
            fontSize: 12,
            lines: 5,
          ),
        ],
      ),
    );
  }
}
