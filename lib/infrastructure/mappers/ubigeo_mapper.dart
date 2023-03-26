import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/infrastructure/models/ubigeo.dart';

class UbigeoMapper {
  static List<RegionEntity> toRegionEntityList(RegionData model) {
    return model.regions!
        .map(
          (e) => RegionEntity(
            cod: e.coddpto ?? '',
            name: e.nomDpto ?? '',
            slug: e.slug ?? '',
          ),
        )
        .toList();
  }

  static List<ProvinceEntity> toProvinceEntityList(ProvinceData model) {
    return model.provinces!
        .map(
          (e) => ProvinceEntity(
            id: e.idprov ?? '',
            name: e.nomProv ?? '',
            slug: e.slug ?? '',
            cod: e.codprov ?? '',
            codRegion: e.dpto?.coddpto ?? '',
          ),
        )
        .toList();
  }

  static List<DistrictEntity> toDistrictEntityList(DistrictData model) {
    return model.districts!
        .map(
          (e) => DistrictEntity(
            id: e.iddist ?? '',
            name: e.nomDist ?? '',
            slug: e.slug ?? '',
            cod: e.coddist ?? '',
            codProvince: e.prov?.codprov ?? '',
            codRegion: e.codregion?.coddpto ?? '',
          ),
        )
        .toList();
  }
}
