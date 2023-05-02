import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/infrastructure/repositories/dead_line_repository_imp.dart';
import 'package:finniu/presentation/providers/dead_line_repository_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deadLineFutureProvider =
    FutureProvider<List<DeadLineEntity>>((ref) async {
  final DeadLineRepositoryImp deadLineRepositoryImp =
      ref.read(deadLineRepositoryProvider);
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return deadLineRepositoryImp.getDeadLines(client: client);
});
