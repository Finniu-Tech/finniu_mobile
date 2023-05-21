import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:finniu/infrastructure/datasources/transferences_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transferenceFutureProvider =
    FutureProvider.autoDispose<List<TransferenceEntity>>((ref) async {
  final graphClient = ref.watch(gqlClientProvider).value;
  final transferences =
      TransferenceDataSourceImpl().getBoucherList(client: graphClient!);
  return transferences;
});
