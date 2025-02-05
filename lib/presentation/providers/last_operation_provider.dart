import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/infrastructure/datasources/last_operation_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final lastOperationDataSourceProvider = Provider<LastOperationDataSource>((ref) {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return LastOperationDataSource(client);
});

final lastOperationsFutureProvider =
    FutureProvider.autoDispose.family<List<LastOperation>, String?>((ref, fundUUID) async {
  final dataSource = ref.watch(lastOperationDataSourceProvider);
  try {
    return await dataSource.getLastOperations(fundUUID);
  } catch (e) {
    return <LastOperation>[];
  }
});
