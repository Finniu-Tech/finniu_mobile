class RegionEntity {
  final String cod;
  final String name;
  final String slug;
  final List<ProvinceEntity?> provinces;

  RegionEntity({
    required this.cod,
    required this.name,
    required this.slug,
    this.provinces = const [],
  });
}

class ProvinceEntity {
  final String id;
  final String codRegion;
  final String cod;
  final String name;
  final String slug;
  final List<DistrictEntity?> districts;

  ProvinceEntity({
    required this.id,
    required this.cod,
    required this.name,
    required this.slug,
    required this.codRegion,
    this.districts = const [],
  });
}

class DistrictEntity {
  final String id;
  final String codProvince;
  final String cod;
  final String name;
  final String slug;

  DistrictEntity({
    required this.id,
    required this.codProvince,
    required this.cod,
    required this.name,
    required this.slug,
  });
}
