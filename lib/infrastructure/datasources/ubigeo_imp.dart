import 'package:finniu/domain/datasources/ubigeo.dart';
import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/ubigeo_mapper.dart';
import 'package:finniu/infrastructure/models/ubigeo.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UbigeoDataSourceImp extends UbigeoDataSource {
  @override
  Future<List<RegionEntity>> getRegions({required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.regions,
        ),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    final responseData = RegionData.fromJson(response.data!);
    final regionsParsed = UbigeoMapper.toRegionEntityList(responseData);
    return regionsParsed;
  }

  @override
  Future<List<ProvinceEntity>> getProvinces({required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.provinces,
        ),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    final responseData = ProvinceData.fromJson(response.data!);
    final provincesParsed = UbigeoMapper.toProvinceEntityList(responseData);
    return provincesParsed;
  }

  @override
  Future<List<DistrictEntity>> getDistricts({required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.districts,
        ),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    final responseData = DistrictData.fromJson(response.data!);
    final districtsParsed = UbigeoMapper.toDistrictEntityList(responseData);
    return districtsParsed;
  }
}
