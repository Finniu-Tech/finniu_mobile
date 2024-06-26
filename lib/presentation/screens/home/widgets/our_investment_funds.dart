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
      color: const Color(0xFF08273F),
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
            background: const Color(0xFFBEF0FF),
            backgroundImage: const Color(0xFF95E1F8),
            textBody: "Fondo prestamos \nempresariales",
            onTap: onTapNavigate,
          ),
          const SizedBox(
            height: 10,
          ),
          CardInvestment(
            background: const Color(0xFFA2CEFE),
            backgroundImage: const Color(0xFF5BAAFF),
            textBody: "Fondo inversiones \nagro inmobiliaria ",
            onTap: onTapNavigate,
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
  final Function()? onTap;
  const CardInvestment({
    super.key,
    required this.background,
    required this.onTap,
    required this.backgroundImage,
    required this.textBody,
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
              child: const Icon(
                Icons.monetization_on_outlined,
                size: 40,
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
              0xFFC5E9EF,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 24,
          color: const Color(0xFFA2E6FA),
        ),
      ],
    );
  }
}
