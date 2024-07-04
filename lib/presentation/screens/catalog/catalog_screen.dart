import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/image_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CatalogScreen extends HookConsumerWidget {
  const CatalogScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: const CustomReturnButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home_home'),
              child: Text('Ir a home normal'),
            ),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/catalog'), child: Text('Ver Catalogo de Widgets')),
            const ButtonSendProof(),
            const BlueGoldImage(),
            const CarrouselSlide(),
            // const SizedBox(height: 70),
            const GraphicContainer(),
            const HeaderInvestment(
              containerColor: aboutContainerBusinessColor,
              iconColor: aboutIconBusinessColor,
              textColor: aboutTextBusinessColor,
              urlIcon: 'assets/investment/business_loans_investment_icon.png',
              urlImageBackground: 'assets/backgroud/image-inmobiliaria-backgroud.png',
              textTitle: 'Fondo prestamos empresariales',
            ),
            const SizedBox(height: 10),
            const HeaderInvestment(
              containerColor: aboutContainerAgroColor,
              iconColor: aboutIconAgroColor,
              textColor: aboutTextAgroColor,
              urlIcon: 'assets/investment/real_estate_agro_icon.png',
              urlImageBackground: 'assets/backgroud/backgroud_agro.png',
              textTitle: 'Fondo inversión agro inmobiliaria',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
