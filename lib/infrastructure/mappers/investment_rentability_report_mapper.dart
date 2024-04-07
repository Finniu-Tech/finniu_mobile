import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/infrastructure/models/investment_rentability_report_response.dart';

class InvestmentRentabilityReportMapper {
  static InvestmentRentabilityResumeEntity graphResponseToEntity(UserInfoInvestmentReportResponse response) {
    final userInvestmentData = response.userInfoInvestment;
    InvestmentRentabilityResumeEntity resumeEntity = InvestmentRentabilityResumeEntity(
      totalAmount: userInvestmentData!.totalBalanceAmmount?.toDouble() ?? 0.0,
      totalRentabilityAmount: double.parse(userInvestmentData.totalBalanceRentability!),
      totalPlans: userInvestmentData.countPlanesActive!,
    );
    final inCoursePlans = InvestmentRentabilityMapper.responseListToEntity(
      userInvestmentData.invesmentInCourse!,
    );
    final finishedPlans = InvestmentRentabilityMapper.responseListToEntity(
      userInvestmentData.invesmentFinished!,
    );
    resumeEntity.investmentsInCourse = inCoursePlans;
    resumeEntity.investmentsFinished = finishedPlans;
    return resumeEntity;
  }
}

class InvestmentRentabilityMapper {
  static List<InvestmentRentabilityEntity> responseListToEntity(
    List<Investment> investments,
  ) {
    return investments
        .map(
          (investment) => responseToEntity(investment),
        )
        .toList();
  }

  static InvestmentRentabilityEntity responseToEntity(Investment investment) {
    return InvestmentRentabilityEntity(
      uuid: investment.uuid!,
      planName: investment.planName,
      amount: double.parse(investment.amount!),
      createdAt: investment.createdAt!,
      isActive: investment.isActive!,
      deadLineUuid: investment.deadline!.uuid!,
      deadLineName: investment.deadline!.name!,
      deadLineValue: investment.deadline!.value!,
      statusInvestment: investment.status!,
      startDateInvestment: investment.startDateInvestment,
      endDateInvestment: investment.finishDateInvestment,
      rentabilityAmount: double.parse(investment.rentabilityAmmount!),
      rentabilityPercent: double.parse(investment.rentabilityPercent!),
      reinvestmentAvailable: investment.reinvestmentAvailable,
      partnerCouponTag:
          investment.partnerTag?.map((e) => InvestmentCouponPartnerTagMapper.responseToEntity(e!)).toList(),
      partner: investment.partner != null ? InvestmentPartnerMapper.responseToEntity(investment.partner!) : null,
    );
  }
}

class InvestmentCouponPartnerTagMapper {
  static InvestmentCouponPartnerTagEntity responseToEntity(PartnerTagResponse tagResponse) {
    return InvestmentCouponPartnerTagEntity(
      partnerTag: tagResponse.partnerTag,
      hexColor: tagResponse.hexColor,
    );
  }
}

class InvestmentPartnerMapper {
  static InvestmentPartnerEntity responseToEntity(PartnerResponse partnerResponse) {
    return InvestmentPartnerEntity(
      partnerName: partnerResponse.partnerName,
      partnerLogoUrl: partnerResponse.partnerLogoUrl,
      partnerHexColor: partnerResponse.partnerHexColor,
      activateLogo: partnerResponse.activateLogo,
    );
  }
}
