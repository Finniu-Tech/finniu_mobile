import 'package:finniu/infrastructure/datasources/important_days_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final importantDaysFutureProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;

    final resultImportantDays =
        await ImportantDaysDataSourceImp().getImportantDays(
      client: client!,
    );
    final resultPaymentDays =
        await PaymentDaysDataSourceImp().getPaymentDays(client: client);
    final mergedResult = mergeResults(resultImportantDays, resultPaymentDays);
    return mergedResult;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});

List<dynamic> mergeResults(
  List<dynamic> importantDays,
  List<dynamic> paymentDays,
) {
  importantDays.forEach((element) {
    element['date'] = DateFormat('yyyy-MM-dd').parse(element['date']);
  });
  paymentDays.forEach((element) {
    element['date'] = DateFormat('dd-MM-yyyy').parse(element['date']);
  });

  return List.from(importantDays)..addAll(paymentDays);
}
