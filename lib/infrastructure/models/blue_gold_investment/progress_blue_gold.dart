import 'package:finniu/presentation/screens/catalog/widgets/completed_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/init_progress_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/less_year_progress_card.dart';
import 'package:flutter/material.dart';

enum ProgressStatus { init, inLastYear, completed }

class AggroInvestment {
  final String? uuid;
  final String? fundName;
  final double parcelAmount;
  late int totalDays;
  late int totalPassedDays;
  late double advancePercent;
  final int parcelNumber;
  final int installmentsNumber;
  final double monthlyPayment;
  final List<ProgressBlueGold> progressList;

  AggroInvestment({
    required this.uuid,
    required this.fundName,
    required this.parcelAmount,
    required this.parcelNumber,
    required this.installmentsNumber,
    required this.monthlyPayment,
    required this.progressList,
    this.totalDays = 0,
    this.advancePercent = 0,
    this.totalPassedDays = 0,
  });

  factory AggroInvestment.fromJson(Map<String, dynamic> data) {
    return AggroInvestment(
      uuid: data['uuid'],
      fundName: data['investmentFundName'],
      parcelAmount: double.parse(data['parcelAmount']),
      parcelNumber: int.parse(data['parcelNumber']),
      installmentsNumber: int.parse(data['numberOfInstallments']),
      monthlyPayment: double.parse(data['parcelMonthlyInstallment']),
      progressList: ProgressBlueGold.fromJsonList(data['progressInvestment']) ?? [],
      totalDays: data["progressInvestment"].isNotEmpty
          ? ProgressBlueGold.countTotalDays(ProgressBlueGold.fromJsonList(data['progressInvestment']))
          : 0,
      totalPassedDays: data["progressInvestment"].isNotEmpty
          ? ProgressBlueGold.countTotalPassedDays(ProgressBlueGold.fromJsonList(data['progressInvestment']))
          : 0,
      advancePercent: data["progressInvestment"].isNotEmpty
          ? ProgressBlueGold.countAdvancePercent(ProgressBlueGold.fromJsonList(data['progressInvestment']))
          : 0,
    );
  }

  static List<AggroInvestment> fromJsonList(List<dynamic> data) {
    return data.map((json) => AggroInvestment.fromJson(json)).toList();
  }
}

class ProgressBlueGold {
  final int daysPassed;
  final int daysMissing;
  final int uuidVoucher;
  final int uuidReport;
  final ProgressStatus status;
  final int totalDays;
  final int startDay;
  final int year;

  ProgressBlueGold({
    required this.daysPassed,
    required this.daysMissing,
    required this.totalDays,
    required this.uuidVoucher,
    required this.uuidReport,
    required this.status,
    required this.startDay,
    required this.year,
  });

  factory ProgressBlueGold.fromJson(Map<String, dynamic> data, int index) {
    return ProgressBlueGold(
      daysPassed: data['daysPassed'],
      daysMissing: data['daysRemaining'],
      totalDays: data['totalDays'],
      startDay: data['startDay'],
      uuidVoucher: 1,
      uuidReport: 1,
      status: getStatus(data['daysPassed']),
      year: index + 1,
    );
  }

  static List<ProgressBlueGold> fromJsonList(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> e = entry.value as Map<String, dynamic>;
      return ProgressBlueGold.fromJson(e, index);
    }).toList();
  }

  static int countTotalDays(List<ProgressBlueGold> progressList) {
    return progressList.isNotEmpty ? progressList.last.totalDays : 0;
  }

  static int countTotalPassedDays(List<ProgressBlueGold> progressList) {
    int totalDays = 0;
    progressList.forEach((element) {
      totalDays += element.daysPassed;
    });
    return totalDays;
  }

  static double countAdvancePercent(List<ProgressBlueGold> progressList) {
    final int totalDays = countTotalDays(progressList);
    final int totalPassedDays = countTotalPassedDays(progressList);
    return (totalPassedDays / totalDays) * 100;
  }
}

ProgressStatus getStatus(int daysPassed) {
  if (daysPassed >= 365) {
    return ProgressStatus.completed;
  } else if (daysPassed >= 60) {
    return ProgressStatus.inLastYear;
  } else {
    return ProgressStatus.init;
  }
}

final List<ProgressBlueGold> progressBlueGold = [
  ProgressBlueGold(
    daysPassed: 365,
    daysMissing: 0,
    uuidVoucher: 15,
    uuidReport: 15,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.completed,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 720,
    daysMissing: 0,
    uuidVoucher: 12,
    uuidReport: 12,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.completed,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 210,
    daysMissing: 155,
    uuidVoucher: 13,
    uuidReport: 13,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.inLastYear,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 60,
    daysMissing: 305,
    uuidVoucher: 2,
    uuidReport: 2,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.inLastYear,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 10,
    daysMissing: 730,
    uuidVoucher: 1,
    uuidReport: 1,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.init,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 365,
    daysMissing: 0,
    uuidVoucher: 15,
    totalDays: 365,
    uuidReport: 15,
    startDay: 1,
    status: ProgressStatus.completed,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 720,
    daysMissing: 0,
    uuidVoucher: 12,
    totalDays: 365,
    startDay: 1,
    uuidReport: 12,
    status: ProgressStatus.completed,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 210,
    daysMissing: 155,
    uuidVoucher: 13,
    totalDays: 365,
    uuidReport: 13,
    startDay: 1,
    status: ProgressStatus.inLastYear,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 60,
    daysMissing: 305,
    uuidVoucher: 2,
    uuidReport: 2,
    totalDays: 365,
    startDay: 1,
    status: ProgressStatus.inLastYear,
    year: 1,
  ),
  ProgressBlueGold(
    daysPassed: 10,
    daysMissing: 730,
    uuidVoucher: 1,
    totalDays: 365,
    startDay: 1,
    uuidReport: 1,
    status: ProgressStatus.init,
    year: 1,
  ),
];

Widget getCardWidget(ProgressBlueGold item) {
  switch (item.status) {
    case ProgressStatus.completed:
      return CompletedBlueGoldCard(
        daysPassed: item.daysPassed,
        daysMissing: item.daysMissing,
        uuidReport: item.uuidReport,
        uuidVoucher: item.uuidVoucher,
      );
    case ProgressStatus.inLastYear:
      return LessYearBlueGoldCard(
        daysPassed: item.daysPassed,
        daysMissing: item.daysMissing,
        uuidReport: item.uuidReport,
        uuidVoucher: item.uuidVoucher,
      );
    case ProgressStatus.init:
      return InitProgressBlueGoldCard(
        daysPassed: item.year,
        daysMissing: item.daysMissing,
        uuidReport: item.uuidReport,
        uuidVoucher: item.uuidVoucher,
      );
    default:
      return Container();
  }
}
