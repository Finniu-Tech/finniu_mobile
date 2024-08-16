import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final regionsSelectProvider =
    FutureProvider.autoDispose<GeoLocationResponseV2>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.regionsV2,
        ),
      ),
    );

    final data = result.data;
    if (data == null) {
      return GeoLocationResponseV2(
        regions: [
          GeoLocationItemV2(
            id: "Error de carga data null",
            name: "Error de carga",
          ),
        ],
      );
    }
    GeoLocationResponseV2 regions =
        GeoLocationResponseV2.fromJson(data, TypeList.regions.name);
    return regions;
  } catch (e) {
    return GeoLocationResponseV2(
      regions: [
        GeoLocationItemV2(
          id: "Error de carga catch",
          name: "Error de carga",
        ),
      ],
    );
  }
});

final provincesSelectProvider =
    FutureProvider.autoDispose.family<GeoLocationResponseV2, String>((
  ref,
  regionId,
) async {
  if (regionId == "") {
    return GeoLocationResponseV2(
      regions: [
        GeoLocationItemV2(
          id: "debe selecionar una region",
          name: "debe selecionar una region",
        ),
      ],
    );
  }
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.getProvincesByIdV2,
        ),
        variables: {
          "idDpto": regionId,
        },
      ),
    );
    final data = result.data;
    if (data == null) {
      return GeoLocationResponseV2(
        regions: [
          GeoLocationItemV2(
            id: "Error de carga data null",
            name: "Error de carga",
          ),
        ],
      );
    }
    GeoLocationResponseV2 regions =
        GeoLocationResponseV2.fromJson(data, TypeList.provinces.name);
    return regions;
  } catch (e) {
    print(e);
    return GeoLocationResponseV2(
      regions: [
        GeoLocationItemV2(
          id: "Error de carga catch",
          name: "Error de carga",
        ),
      ],
    );
  }
});
