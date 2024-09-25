import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DropdownGeoLocationImp extends GraphQLBaseDataSource {
  DropdownGeoLocationImp(super.client);
  Future<GeoLocationResponseV2> getRegions() async {
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(
            QueryRepository.regionsV2,
          ),
        ),
      );
      final data = result.data;
      if (data == null || data.isEmpty) {
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
  }

  Future<GeoLocationResponseV2> getProvinces(String regionId) async {
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
      final result = await client.query(
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
      if (data == null || data.isEmpty) {
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
      return GeoLocationResponseV2(
        regions: [
          GeoLocationItemV2(
            id: "Error de carga catch",
            name: "Error de carga",
          ),
        ],
      );
    }
  }

  Future<GeoLocationResponseV2> getDistricts(String regionId) async {
    if (regionId == "") {
      return GeoLocationResponseV2(
        regions: [
          GeoLocationItemV2(
            id: "Debe selecionar una provincia",
            name: "Debe selecionar una provincia",
          ),
        ],
      );
    }
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(
            QueryRepository.getDistrictsByProvinceIdV2,
          ),
          variables: {
            "idProv": regionId,
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
          GeoLocationResponseV2.fromJson(data, TypeList.districts.name);
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
  }
}
