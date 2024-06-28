import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderInvestment extends StatelessWidget {
  const HeaderInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const double height = 350;
    return SizedBox(
      width: width,
      height: 350,
      child: const Stack(
        children: [
          BackgroudImage(),
          BackgroudOpacity(),
          AppBarInvestment(height: height),
          AboutContainer(height: height),
        ],
      ),
    );
  }
}

class AboutContainer extends StatelessWidget {
  const AboutContainer({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height / 4,
      color: Colors.transparent,
    );
  }
}

class AppBarInvestment extends StatelessWidget {
  const AppBarInvestment({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height / 2,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
      ),
    );
  }
}

class BackgroudOpacity extends StatelessWidget {
  const BackgroudOpacity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff0D3A5C).withOpacity(0.5), // Capa de opacidad
    );
  }
}

class BackgroudImage extends StatelessWidget {
  const BackgroudImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgroud/image-agro-backgroud.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
