import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class HeaderInvestment extends StatelessWidget {
  final String urlIcon;
  final String urlImageBackground;
  final String textTitle;
  final int containerColor;
  final int textColor;
  final int iconColor;
  const HeaderInvestment({
    super.key,
    required this.urlIcon,
    required this.containerColor,
    required this.textColor,
    required this.iconColor,
    required this.urlImageBackground,
    required this.textTitle,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const double height = 211;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          BackgroudImage(
            urlImageBackground: urlImageBackground,
          ),
          const BackgroudOpacity(),
          AboutContainer(
            containerColor: containerColor,
            iconColor: iconColor,
            textColor: textColor,
            urlIcon: urlIcon,
            textTitle: textTitle,
          ),
        ],
      ),
    );
  }
}
//'assets/investment/business_loans_investment_icon.png'

class AboutContainer extends StatelessWidget {
  final String urlIcon;
  final String textTitle;
  final int containerColor;
  final int textColor;
  final int iconColor;
  const AboutContainer({
    super.key,
    required this.urlIcon,
    required this.containerColor,
    required this.textColor,
    required this.iconColor,
    required this.textTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: 150,
                      height: 30,
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(containerColor),
                      ),
                      child: Text(
                        'Acerca de',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(textColor),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(iconColor),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          urlIcon,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 114,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(iconColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 50,
              child: Text(
                textTitle,
                style: const TextStyle(
                  color: Color(backgroundColorLight),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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
      height: height / 3,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
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
  final String urlImageBackground;
  const BackgroudImage({
    super.key,
    required this.urlImageBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(urlImageBackground),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
