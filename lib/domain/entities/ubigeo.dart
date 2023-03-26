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

  static String getCodeFromName(String name, List<RegionEntity> regions) {
    return regions.firstWhere((region) => region.name == name).cod;
  }
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

  static getCodeFromName(
    String name,
    String codeRegion,
    List<ProvinceEntity> provinces,
  ) {
    print('name: $name, codeRegion: $codeRegion');
    return provinces
        .firstWhere(
          (province) =>
              province.name == name && province.codRegion == codeRegion,
        )
        .cod;
  }
}

class DistrictEntity {
  final String id;
  final String codProvince;
  final String codRegion;
  final String cod;
  final String name;
  final String slug;

  DistrictEntity({
    required this.id,
    required this.codProvince,
    required this.codRegion,
    required this.cod,
    required this.name,
    required this.slug,
  });
}
