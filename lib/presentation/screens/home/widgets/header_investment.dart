import 'package:flutter/material.dart';

class HeaderInvestment extends StatelessWidget {
  const HeaderInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgroud/image-agro-backgroud.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          color: const Color(0xff0D3A5C).withOpacity(0.5), // Capa de opacidad
        ),
      ],
    );
  }
}
