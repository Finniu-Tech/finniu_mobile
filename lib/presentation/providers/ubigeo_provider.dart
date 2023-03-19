import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/ubigeo_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final regionsFutureProvider = FutureProvider.autoDispose<List<RegionEntity>>(
  (ref) async {
    final ubigeoRepository = ref.watch(ubigeoRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final regions = await ubigeoRepository.getRegions(client: client!);
    return regions;
  },
);
