import 'package:finniu/presentation/screens/catalog/widgets/completed_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/init_progress_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/less_year_progress_card.dart';
import 'package:flutter/material.dart';

enum ProgressStatus { init, inLastYear, completed }

class ProgressBlueGold {
  final int daysPassed;
  final int daysMissing;
  final int uuidVoucher;
  final int uuidReport;
  final ProgressStatus status;

  ProgressBlueGold({
    required this.daysPassed,
    required this.daysMissing,
    required this.uuidVoucher,
    required this.uuidReport,
    required this.status,
  });
}

final List<ProgressBlueGold> progressBlueGold = [
  ProgressBlueGold(
    daysPassed: 365,
    daysMissing: 0,
    uuidVoucher: 15,
    uuidReport: 15,
    status: ProgressStatus.completed,
  ),
  ProgressBlueGold(
    daysPassed: 720,
    daysMissing: 0,
    uuidVoucher: 12,
    uuidReport: 12,
    status: ProgressStatus.completed,
  ),
  ProgressBlueGold(
    daysPassed: 210,
    daysMissing: 155,
    uuidVoucher: 13,
    uuidReport: 13,
    status: ProgressStatus.inLastYear,
  ),
  ProgressBlueGold(
    daysPassed: 60,
    daysMissing: 305,
    uuidVoucher: 2,
    uuidReport: 2,
    status: ProgressStatus.inLastYear,
  ),
  ProgressBlueGold(
    daysPassed: 10,
    daysMissing: 730,
    uuidVoucher: 1,
    uuidReport: 1,
    status: ProgressStatus.init,
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
        daysPassed: item.daysPassed,
        daysMissing: item.daysMissing,
        uuidReport: item.uuidReport,
        uuidVoucher: item.uuidVoucher,
      );
    default:
      return Container();
  }
}
