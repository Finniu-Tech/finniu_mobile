import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/infrastructure/models/investment_history_response.dart';

class InvestmentHistoryMapper {
  static InvestmentHistoryResumeEntity responseGraphToEntity(HistoryInvestmentResponse response) {
    final history = response.userInfoInvestment;
    InvestmentHistoryResumeEntity historyResumeEntity = InvestmentHistoryResumeEntity(
      totalAmount: history?.totalBalanceAmount?.toDouble() ?? 0.0,
      totalPlans: history?.countPlanesActive ?? 0,
    );
    final inCourseInvestment = InvestmentMapper.responseListToEntity(history?.invesmentInCourse ?? []);
    final finishedInvestment = InvestmentMapper.responseListToEntity(history?.invesmentFinished ?? []);
    final inProcessInvestment = InvestmentMapper.responseListCanceledToEntity(
      history?.invesmentInProcess ?? [],
    );
    final canceledInvestment = InvestmentMapper.responseListCanceledToEntity(
      history?.invesmentCanceled ?? [],
    );
    final pendingInvestment = InvestmentMapper.responseListToEntity(
      history?.investmentPending ?? [],
    );
    historyResumeEntity.investmentsInCourse = inCourseInvestment;
    historyResumeEntity.investmentsFinished = finishedInvestment;
    historyResumeEntity.investmentsInProcess = inProcessInvestment;
    historyResumeEntity.investmentsCanceled = canceledInvestment;
    historyResumeEntity.investmentsPending = pendingInvestment;
    return historyResumeEntity;
  }
}

class InvestmentMapper {
  static List<InvestmentHistoryEntity> responseListToEntity(
    List<InvesmentFinishedElement> investments,
  ) {
    return investments
        .map(
          (investment) => responseToEntity(investment),
        )
        .toList();
  }

  static InvestmentHistoryEntity responseToEntity(
    InvesmentFinishedElement investment,
  ) {
    return InvestmentHistoryEntity(
      uuid: investment.uuid!,
      planName: investment.planName!,
      totalAmount: double.parse(investment.amount!),
      startDate: investment.startDateInvestment,
      endDate: investment.finishDateInvestment,
      deadLineName: investment.deadline?.name!,
      deadLineValue: investment.deadline?.value!,
      rentabilityPercent: double.parse(investment.rentabilityPercent!),
    );
  }

  static List<InvestmentHistoryEntity> responseListCanceledToEntity(
    List<InvesmentCanceledElement> investments,
  ) {
    return investments
        .map(
          (investment) => responseCanceledToEntity(investment),
        )
        .toList();
  }

  static InvestmentHistoryEntity responseCanceledToEntity(
    InvesmentCanceledElement investment,
  ) {
    return InvestmentHistoryEntity(
      uuid: investment.uuid!,
      planName: investment.planName!,
      totalAmount: double.parse(investment.amount!),
    );
  }
}
