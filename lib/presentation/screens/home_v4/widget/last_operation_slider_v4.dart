import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/presentation/screens/home_v2/home_screen.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/show_draft_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/slider_draft.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastOperationsSliderV4 extends ConsumerStatefulWidget {
  final List<LastOperation> lastOperations;

  const LastOperationsSliderV4({
    super.key,
    required this.lastOperations,
  });

  @override
  ContainerLastOperationsState createState() => ContainerLastOperationsState();
}

class ContainerLastOperationsState extends ConsumerState<LastOperationsSliderV4> {
  int _currentIndex = 0;

  Widget _buildSliderWidget(LastOperation operation) {
    switch (operation.enterprisePreInvestment?.status) {
      case 'draft':
        return SliderDraft(
          amountNumber: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          isReInvestment: operation.enterprisePreInvestment?.isReInvestment ?? false,
          onTap: () => showDraftModal(
            context,
            amountNumber: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
            isReinvest: operation.enterprisePreInvestment?.isReInvestment ?? false,
            profitability: operation.enterprisePreInvestment?.rentability?.toInt() ?? 0,
            termMonth: operation.enterprisePreInvestment?.deadline ?? 0,
            uuid: operation.enterprisePreInvestment?.uuidPreInvestment ?? '',
            moneyIcon: true,
            cardSend: false,
            statusUp: false,
            currency: operation.enterprisePreInvestment?.currency ?? '',
            fund: operation.investmentFund,
          ),
        );
      case 'pending':
        if (operation.enterprisePreInvestment?.isReInvestment == true &&
                operation.enterprisePreInvestment?.actionStatus == ActionStatusEnum.defaultReInvestment ||
            operation.enterprisePreInvestment?.actionStatus == ActionStatusEnum.defaultReInvestment.toLowerCase()) {
          return ReinvestmentPendingSlider(
            amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
            fundName: operation.investmentFund.titleText,
          );
        }
        return ToValidateSlider(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: operation.investmentFund.titleText,
        );
      case 'in_process':
        return ToValidateSlider(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: operation.investmentFund.titleText,
        );

      case 'active':
        return SliderInCourse(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: operation.investmentFund.titleText,
          onPressed: () {},
        );

      default:
        return Text('Un widget vacío para ${operation.enterprisePreInvestment?.status} no manejado');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LastOperation> filteredOperations = widget.lastOperations;

    if (filteredOperations.length > 15) {
      filteredOperations = filteredOperations.sublist(0, 15);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: filteredOperations.map((operation) => _buildSliderWidget(operation)).toList(),
          options: CarouselOptions(
            height: 94,
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: filteredOperations.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = entry.key;
                });
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
