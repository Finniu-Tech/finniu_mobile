import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/infrastructure/models/onboarding_finish_response.dart';
import 'package:finniu/infrastructure/models/plan_response.dart';

class PlanMapper {
  static PlanEntity toEntity(FinishOnboardingResponseModel finishResponse) {
    final planModel = finishResponse.finishOnboarding?.plan;

    return PlanEntity(
      uuid: planModel?.uuid ?? '',
      name: planModel?.name ?? '',
      minAmount: double.parse(planModel?.minAmount ?? '0'),
      value: planModel?.value?.toDouble() ?? 0,
      twelveMonthsReturn: double.parse(planModel?.twelveMonthsReturn ?? '0'),
      sixMonthsReturn: double.parse(planModel?.sixMonthsReturn ?? '0'),
      description: planModel?.description ?? '',
    );
  }

  static List<PlanEntity> listToEntity(
    PlanListResponse planListResponse,
  ) {
    return planListResponse.planData!
        .map(
          (e) => PlanEntity(
            uuid: e.uuid ?? '',
            name: e.name ?? '',
            minAmount: double.parse(e.minAmount ?? '0'),
            value: e.value?.toDouble() ?? 0,
            twelveMonthsReturn: double.parse(e.twelveMonthsReturn ?? '0'),
            sixMonthsReturn: double.parse(e.sixMonthsReturn ?? '0'),
            description: e.description ?? '',
            imageUrl: e.planImageUrl,
            objective: e.objective,
            imgDistribution: e.imgDistribution,
            features: e.features,
          ),
        )
        .toList();
  }
}
