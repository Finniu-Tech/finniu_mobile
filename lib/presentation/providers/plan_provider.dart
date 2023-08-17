import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/plan_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final planListFutureProvider = FutureProvider<PlanList>((ref) async {
  try {
    final planRepository = ref.read(planRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final result = await planRepository.getAll(
      client: client!,
    );
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});
