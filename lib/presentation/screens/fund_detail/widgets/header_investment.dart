import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/labels.dart';
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
          BackgroundImage(
            urlImageBackground: urlImageBackground,
          ),
          const BackgroundOpacity(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //CustomButtonRoundedDark(), //transform  to 90 degrees

          // Transform(transform: Matrix4.rotationZ(1.5708), child: CustomButtonRoundedDark()),
          Transform.rotate(
            angle: -3,
            child: CustomButtonRoundedDark(
              color: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LabelWithRoundedImage(
                  containerColor: containerColor,
                  textColor: textColor,
                  iconColor: iconColor,
                  urlIcon: urlIcon,
                  labelText: 'Acerca de',
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

class BackgroundOpacity extends StatelessWidget {
  const BackgroundOpacity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff0D3A5C).withOpacity(0.5),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String urlImageBackground;
  const BackgroundImage({
    super.key,
    required this.urlImageBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          // image: AssetImage(urlImageBackground),
          image: NetworkImage(urlImageBackground),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
