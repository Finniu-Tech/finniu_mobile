import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/domain/repositories/ubigeo_repository.dart';
import 'package:finniu/infrastructure/datasources/ubigeo_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UbigeoRepositoryImp extends UbigeoRepository {
  final UbigeoDataSourceImp _dataSource;

  UbigeoRepositoryImp(this._dataSource);

  @override
  Future<List<RegionEntity>> getRegions({required GraphQLClient client}) async {
    return await _dataSource.getRegions(client: client);
  }

  @override
  Future<List<ProvinceEntity>> getProvinces({
    required GraphQLClient client,
  }) async {
    return await _dataSource.getProvinces(client: client);
  }

  @override
  Future<List<DistrictEntity>> getDistricts({
    required GraphQLClient client,
  }) async {
    return await _dataSource.getDistricts(client: client);
  }
}
