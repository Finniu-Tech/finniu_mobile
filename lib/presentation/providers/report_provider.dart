import 'package:finniu/infrastructure/datasources/reports_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeReportProvider = FutureProvider<Map>((ref) async {
  final client = ref.watch(gqlClientProvider).value;
  final response =
      await ReportDataSourceImp().getUserReportHome(client: client!);
  print('response is $response');
  return response;
});
