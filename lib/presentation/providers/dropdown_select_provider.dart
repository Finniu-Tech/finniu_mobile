import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/infrastructure/datasources/dropdown_geo_location_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final regionsSelectProvider =
    FutureProvider.autoDispose<GeoLocationResponseV2>((ref) async {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return DropdownGeoLocationImp(client).getRegions();
});

final provincesSelectProvider =
    FutureProvider.autoDispose.family<GeoLocationResponseV2, String>((
  ref,
  regionId,
) async {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return DropdownGeoLocationImp(client).getProvinces(regionId);
});

final districtsSelectProvider =
    FutureProvider.autoDispose.family<GeoLocationResponseV2, String>((
  ref,
  regionId,
) async {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return DropdownGeoLocationImp(client).getDistricts(regionId);
});
