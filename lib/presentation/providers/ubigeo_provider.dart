// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/ubigeo_repository_provider.dart';

final regionsFutureProvider = FutureProvider.autoDispose<List<RegionEntity>>(
  (ref) async {
    final ubigeoRepository = ref.watch(ubigeoRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final regions = await ubigeoRepository.getRegions(client: client!);
    return regions;
  },
);

final provincesFutureProvider =
    FutureProvider.autoDispose<List<ProvinceEntity>>(
  (ref) async {
    final ubigeoRepository = ref.watch(ubigeoRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final provinces = await ubigeoRepository.getProvinces(client: client!);
    return provinces;
  },
);

final provincesStateNotifier =
    StateNotifierProvider.family<ProvincesStateNotifier, String>(
  (ref, regionId) => ProvincesStateNotifier(ref, regionId),
);

class ProvincesStateNotifier {
  String regionId;
  List<ProvinceEntity> provinces;
  ProvincesStateNotifier(
    this.regionId,
    this.provinces,
  );

  return provinces.where((province) => province.regionId == regionId).toList();


  // List<ProvinceEntity> get provinces =>
  //     ref.watch(provincesFutureProvider).data?.value ?? [];

  // List<ProvinceEntity> get filteredProvinces =>
  //     provinces.where((province) => province.regionId == regionId).toList();
}
