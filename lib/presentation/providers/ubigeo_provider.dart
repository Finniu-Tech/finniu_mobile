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

final provincesFutureProvider = FutureProvider<List<ProvinceEntity>>(
  (ref) async {
    final ubigeoRepository = ref.watch(ubigeoRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final provinces = await ubigeoRepository.getProvinces(client: client!);
    return provinces;
  },
);

final provincesStateNotifier =
    StateNotifierProvider<ProvincesFilterNotifier, List<ProvinceEntity>>((ref) {
  final provincesFuture = ref.watch(provincesFutureProvider);
  return ProvincesFilterNotifier(provincesFuture);
});

class ProvincesFilterNotifier extends StateNotifier<List<ProvinceEntity>> {
  final AsyncValue<List<ProvinceEntity>> _provinces;

  ProvincesFilterNotifier(this._provinces) : super(_provinces.value ?? []);

  void filterProvinces(String codeRegion) {
    final provinces = <ProvinceEntity>[];
    for (final province in _provinces.value ?? []) {
      if (province.codRegion == codeRegion) {
        provinces.add(province);
      }
    }
    state = provinces;
  }
}

final districtsFutureProvider = FutureProvider<List<DistrictEntity>>(
  (ref) async {
    final ubigeoRepository = ref.watch(ubigeoRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final districts = await ubigeoRepository.getDistricts(client: client!);
    return districts;
  },
);

final districtsStateNotifier =
    StateNotifierProvider<DistrictsFilterNotifier, List<DistrictEntity>>((
  ref,
) {
  final districtsFuture = ref.watch(districtsFutureProvider);
  return DistrictsFilterNotifier(districtsFuture);
});

class DistrictsFilterNotifier extends StateNotifier<List<DistrictEntity>> {
  final AsyncValue<List<DistrictEntity>> _districts;

  DistrictsFilterNotifier(this._districts) : super(_districts.value ?? []);

  void filterDistricts(String codeProvince, String codeRegion) {
    final districts = <DistrictEntity>[];
    for (final district in _districts.value ?? []) {
      if (district.codProvince == codeProvince &&
          district.codRegion == codeRegion) {
        districts.add(district);
      }
    }
    state = districts;
  }
  // void filterDistricts(codProvince) {
  //   _districts.value
  //           ?.where((district) => district.codProvince == codProvince)
  //           .toList() ??
  //       [];
  // }
}
