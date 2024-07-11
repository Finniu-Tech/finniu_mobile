import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal_02.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/to_validate_investment.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/image_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/modal_investment_summary.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CatalogScreen extends HookConsumerWidget {
  const CatalogScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarHome(),
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: const CustomReturnButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NoInvestmentsButton(),
            const TabBarBusiness(),
            ButtonInvestment(
              text: "go to businnes investment",
              onPressed: () {
                Navigator.pushNamed(context, '/business_investment');
              },
            ),
            const CompleteInvestment(
              amount: 777,
              dateEnds: '11/11/2022',
              isReInvestment: false,
            ),
            const SizedBox(
              height: 5,
            ),
            const CompleteInvestment(
              amount: 555,
              dateEnds: '10/10/2022',
              isReInvestment: true,
            ),
            const SizedBox(
              height: 5,
            ),
            const ToValidateInvestment(
              amount: 3000,
              dateEnds: '10/10/2022',
            ),
            const SizedBox(
              height: 5,
            ),
            const ProgressBarInProgress(
              amount: 1000,
              dateEnds: '10/10/2022',
            ),
            const SizedBox(
              height: 5,
            ),
            const ProgressBarInProgress(
              amount: 2000,
              dateEnds: '11/10/2022',
            ),
            const ModalBenefitsTwo(),
            const SizedBox(height: 10),
            const ModalBenefits(),
            const SizedBox(height: 10),
            const ModalInvestmentSummary(),
            const SizedBox(height: 10),
            const ValidationModal(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home_home'),
              child: const Text('Ir a home normal'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/catalog'),
              child: const Text('Ver Catalogo de Widgets'),
            ),
            const ButtonSendProof(),
            const BlueGoldImage(),
            const FundInfoSlider(),
            // const SizedBox(height: 70),
            const GraphicContainer(),
            const HeaderInvestment(
              containerColor: aboutContainerBusinessColor,
              iconColor: aboutIconBusinessColor,
              textColor: aboutTextBusinessColor,
              urlIcon: 'assets/investment/business_loans_investment_icon.png',
              urlImageBackground:
                  'assets/backgroud/image-inmobiliaria-backgroud.png',
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
            const NonInvestmentContainer(),
          ],
        ),
      ),
    );
  }
}
