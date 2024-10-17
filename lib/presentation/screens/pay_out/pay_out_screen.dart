import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PayOutScreen extends StatelessWidget {
  const PayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      floatingActionButton: ButtonInvestment(
        text: 'Entendido',
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: const _BodyPayOut(),
    );
  }
}

class _BodyPayOut extends StatelessWidget {
  const _BodyPayOut();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          IconsRow(),
        ],
      ),
    );
  }
}

class IconsRow extends StatelessWidget {
  const IconsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int iconColor = 0xff03253E;
    return Row(
      children: [
        Image.asset(
          "assets/images/rextie_image.png",
          width: 70,
          height: 45,
        ),
        SvgPicture.asset(
          "assets/svg_icons/refresh_icon.svg",
          width: 20,
          height: 20,
          color: const Color(iconColor),
        ),
        SvgPicture.asset(
          "assets/svg_icons/logo_finniu_icon.svg",
          width: 40,
          height: 40,
          color: const Color(iconColor),
        ),
      ],
    );
  }
}
