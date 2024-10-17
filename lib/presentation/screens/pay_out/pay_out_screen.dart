import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/container_pay_out.dart';
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
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconsRow(),
              SizedBox(
                height: 10,
              ),
              TitlePayOut(),
              SizedBox(
                height: 10,
              ),
              SubTitlePayOut(),
              SizedBox(
                height: 10,
              ),
              ContainerPayOut(),
            ],
          ),
        ),
      ),
    );
  }
}

class SubTitlePayOut extends StatelessWidget {
  const SubTitlePayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextPoppins(
      text:
          "Puedes seguir el progreso de tu transacción. Gracias a nuestra alianza con Rextie, lo procesamos de manera segura y automática.",
      fontSize: 14,
      lines: 4,
      align: TextAlign.center,
    );
  }
}

class TitlePayOut extends StatelessWidget {
  const TitlePayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextPoppins(
      text: "¡Tu pago está en proceso!",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      lines: 2,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/rextie_image.png",
          width: 70,
          height: 45,
        ),
        const SizedBox(
          width: 10,
        ),
        SvgPicture.asset(
          "assets/svg_icons/refresh_icon.svg",
          width: 20,
          height: 20,
          color: const Color(iconColor),
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          "assets/images/logo_finniu_light.png",
          width: 70,
          height: 45,
        ),
      ],
    );
  }
}
