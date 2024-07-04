import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class OurInvestmentFunds extends StatelessWidget {
  const OurInvestmentFunds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onTapNavigate() {
      print("precione para navegar a la pantalla de inversion");
    }

    final fundCardList = [
      CardInvestment(
        background: const Color(cardInvestmentBusiness),
        backgroundImage: const Color(cardImageBusiness),
        textBody: "Fondo inversiones \nempresariales",
        onTap: onTapNavigate,
        imageUrl: 'assets/investment/building_investment.png',
      ),
      CardInvestment(
        background: const Color(cardInvestmentRealEstate),
        backgroundImage: const Color(cardImageRealEstate),
        textBody: "Fondo inversiones \nagro inmobiliaria ",
        onTap: onTapNavigate,
        imageUrl: 'assets/investment/blueberry_investment.png',
      ),
    ];

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const TitleOfFunds(
            title: "Nuestros Fondos",
            icon: Icons.monetization_on_outlined,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CarouselSlider(
              items: fundCardList,
              options: CarouselOptions(
                height: 150,
                autoPlay: false,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                clipBehavior: Clip.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardInvestment extends StatelessWidget {
  final Color background;
  final Color backgroundImage;
  final String textBody;
  final String imageUrl;
  final Function()? onTap;
  const CardInvestment({
    super.key,
    required this.background,
    required this.onTap,
    required this.backgroundImage,
    required this.textBody,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 130,
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundImage,
                  ),
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    imageUrl,
                  ),
                ),
                const Spacer(),
                Transform.rotate(
                  angle: -0.7854,
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    size: 24,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textBody,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleOfFunds extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleOfFunds({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(
              primaryDark,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 24,
          color: const Color(primaryDark),
        ),
      ],
    );
  }
}
