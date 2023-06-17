import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/infrastructure/models/calculate_investment_response.dart';
import 'package:finniu/infrastructure/models/onboarding_finish_response.dart';
import 'package:finniu/infrastructure/models/onboarding_response.dart';

class CalculateInvestmentMapper {
  static PlanSimulation toEntity(
    initialAmount,
    months,
    CalculateInvestmentResponse investmentResponse,
  ) {
    final planModel = investmentResponse.calculateInvestment?.plan;
    if (planModel == null) {
      throw Exception('Invalid CalculateInvestmentResponse object');
    }

    return PlanSimulation(
      initialAmount: initialAmount,
      months: months,
      profitability: investmentResponse
          .calculateInvestment!.profitability!.preInvestmentAmount
          ?.toDouble(),
      plan: PlanEntity(
        uuid: planModel?.uuid ?? '',
        name: planModel?.name ?? '',
        minAmount: double.parse(planModel?.minAmount ?? '0'),
        value: planModel?.value?.toDouble() ?? 0,
        twelveMonthsReturn: double.parse(planModel?.twelveMonthsReturn ?? '0'),
        sixMonthsReturn: double.parse(planModel?.sixMonthsReturn ?? '0'),
        description: planModel?.description ?? '',
        returnEstimatedDate: planModel.returnDateEstimate,
      ),
    );
  }
}
