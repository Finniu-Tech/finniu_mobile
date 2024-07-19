import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/image_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/containers.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FundDetailScreen extends ConsumerWidget {
  const FundDetailScreen({super.key, required this.fund});
  final FundEntity fund;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final backgroundColor = isDarkMode ? fund.getHexDetailColorDark() : fund.getHexDetailColorLight();
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: FundDetailBody(
        fund: fund,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class FundDetailBody extends StatelessWidget {
  final FundEntity fund;
  final bool isDarkMode;
  const FundDetailBody({super.key, required this.fund, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderInvestment(
          containerColor: isDarkMode ? fund.getHexDetailColorDark() : fund.getHexDetailColorLight(),
          iconColor: isDarkMode ? fund.getHexDetailColorSecondaryDark() : fund.getHexDetailColorSecondaryLight(),
          textColor: aboutTextBusinessColor,
          urlIcon: fund.iconUrl!,
          urlImageBackground: fund.backgroundImageUrl!,
          textTitle: fund.name,
        ),
        ScrollBody(
          fund: fund,
        ),
        const SizedBox(height: 10),
        ButtonInvestment(
          text: 'Quiero invertir',
          onPressed: () {
            if (fund.fundType == FundTypeEnum.corporate) {
              Navigator.pushNamed(context, '/v2/investment/step-1');
            } else {
              Navigator.pushNamed(context, '/v2/aggro-investment');
            }
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
  final FundEntity fund;
  const ScrollBody({super.key, required this.fund});
  Future<dynamic> showBenefits(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => BodyModalBenefits(
        fundUUID: fund.uuid,
      ),
    );
  }

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
                fund.fundType == FundTypeEnum.corporate ? 'Descubre el portafolio' : 'Nuestro modelo de negocio',
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
                  GestureDetector(
                    onTap: () {
                      showBenefits(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Ver los beneficios',
                          style: TextStyle(
                            fontSize: 12,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Transform.rotate(
                          angle: -0.7854,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 24,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (fund.fundType == FundTypeEnum.corporate) ...[
                    const SwitchMoney(
                      switchHeight: 34,
                      switchWidth: 67,
                    ),
                  ] else ...[
                    TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(const Color(0xff3A66BF))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/contract_view', arguments: {
                          'contractURL': 'https://pdfobject.com/pdf/sample.pdf',
                        });
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Ver más información'),
                          SizedBox(width: 5),
                          Icon(
                            Icons.download_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (fund.fundType == FundTypeEnum.aggro) ...[
                Center(child: BlueGoldContainer(amount: fund.netWorthAmount!)),
              ],
              if (fund.fundType == FundTypeEnum.corporate) ...[
                const Center(
                  child: RealStateContainer(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const FundInfoSlider(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
