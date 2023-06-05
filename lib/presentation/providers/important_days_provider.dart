import 'package:finniu/infrastructure/datasources/important_days_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final importantDaysFutureProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;

    final result = await ImportantDaysDataSourceImp().getImportantDays(
      client: client!,
    );
    print('result!! important days');
    print(result);
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});
