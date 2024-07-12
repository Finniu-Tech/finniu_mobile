import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/image_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/containers.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FundDetailScreen extends ConsumerWidget {
  const FundDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final backgroundColor = isDarkMode ? scaffoldBlackBackground : scaffoldLightGradientPrimary;
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: const FundDetailBody(),
    );
  }
}

class FundDetailBody extends StatelessWidget {
  const FundDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderInvestment(
          containerColor: aboutContainerBusinessColor,
          iconColor: aboutIconBusinessColor,
          textColor: aboutTextBusinessColor,
          urlIcon: 'assets/investment/business_loans_investment_icon.png',
          urlImageBackground: 'assets/backgroud/image-inmobiliaria-backgroud.png',
          textTitle: 'Fondo préstamos empresariales',
        ),
        const ScrollBody(),
        const SizedBox(height: 10),
        ButtonInvestment(
          text: 'Quiero invertir',
          onPressed: () {
            Navigator.pushNamed(context, '/v2/investment/step-1');
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ScrollBody extends ConsumerWidget {
  const ScrollBody({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final mainColor = currentTheme.isDarkMode ? Colors.white : Colors.black;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          //add padding
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descubre el portafolio',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: mainColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const BlueGoldImage(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Ver los beneficios',
                    style: TextStyle(
                      fontSize: 12,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Transform.rotate(
                    angle: -0.7854,
                    child: Icon(
                      Icons.arrow_forward_sharp,
                      size: 24,
                      color: mainColor,
                    ),
                  ),
                  const Spacer(),
                  const SwitchMoney(
                    switchHeight: 34,
                    switchWidth: 67,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: RealStateContainer(),
              ),
              const SizedBox(
                height: 10,
              ),
              const FundInfoSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
