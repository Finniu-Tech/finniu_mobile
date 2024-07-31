import 'package:finniu/infrastructure/models/lot_detail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final lotDetailProvider = FutureProvider<LotDetail>((ref) async {
  try {
    await Future.delayed(const Duration(seconds: 2));
    return LotDetail(
      title: "11",
      dayToday: "16 de Junio 2024",
      harvestNumber: "13",
      passedDays: "2 años",
      missingDays: "1 mes",
      progress: 0.1,
      investmentAmount: 8200,
      profitabilityAmount: 255,
    );
  } catch (e) {
    return LotDetail(
      title: "--",
      dayToday: "Error al pedir los datos",
      harvestNumber: "--",
      passedDays: "--",
      missingDays: "-- ",
      progress: 0.0,
      investmentAmount: 0,
      profitabilityAmount: 0,
    );
  }
});
