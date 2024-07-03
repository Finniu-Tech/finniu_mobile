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

    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(backgroundInvestment),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const TitleOfFunds(
            title: "Nuestros Fondos",
            icon: Icons.monetization_on_outlined,
          ),
          const SizedBox(
            height: 10,
          ),
          CardInvestment(
            background: const Color(cardInvestmentBusiness),
            backgroundImage: const Color(cardImageBusiness),
            textBody: "Fondo prestamos \nempresariales",
            onTap: onTapNavigate,
            imageUrl: 'assets/investment/building_investment.png',
          ),
          const SizedBox(
            height: 10,
          ),
          CardInvestment(
            background: const Color(cardInvestmentRealEstate),
            backgroundImage: const Color(cardImageRealEstate),
            textBody: "Fondo inversiones \nagro inmobiliaria ",
            onTap: onTapNavigate,
            imageUrl: 'assets/investment/blueberry_investment.png',
          ),
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
      ),
      height: 130,
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textBody,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Transform.rotate(
              angle: -0.7854,
              child: const Icon(
                Icons.arrow_forward_sharp,
                size: 24,
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
              titleTextInvestment,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 24,
          color: const Color(primaryLight),
        ),
      ],
    );
  }
}
