import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

void showChangePassword(BuildContext context) {
  const title = "Te enviamos un correo";
  const subTitle = "Enviamos un correo para que puedas cambiar tu contraseña";
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 325,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                "assets/images/email_image.png",
                width: 40,
                height: 40,
              ),
            ),
            const TextPoppins(
              text: title,
              fontSize: 20,
              isBold: true,
            ),
            const TextPoppins(
              text: subTitle,
              fontSize: 14,
              isBold: false,
              lines: 2,
              align: TextAlign.center,
            ),
            ButtonInvestment(
              text: "Entendido",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ),
  );
}
