import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class UbigeoRepository {
  Future<List<RegionEntity>> getRegions({
    required GraphQLClient client,
  });

  Future<List<ProvinceEntity>> getProvinces({
    required GraphQLClient client,
  });

  Future<List<DistrictEntity>> getDistricts({
    required GraphQLClient client,
  });
}
