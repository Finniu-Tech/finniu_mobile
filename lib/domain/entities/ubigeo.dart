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

  static String? getCodeFromName(String name, List<RegionEntity> regions) {
    try {
      return regions.firstWhere((region) => region.name == name).cod;
    } catch (e) {
      return null;
    }
  }

  static String? getNameFromCode(String code, List<RegionEntity> regions) {
    try {
      return regions.firstWhere((region) => region.cod == code).name;
    } catch (e) {
      return null;
    }
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

  static String? getCodeFromName(
    String name,
    String codeRegion,
    List<ProvinceEntity> provinces,
  ) {
    try {
      return provinces
          .firstWhere(
            (province) => province.name == name && province.codRegion == codeRegion,
          )
          .cod;
    } catch (e) {
      return null;
    }
  }

  static String? getNameFromCode(
    String code,
    String codeRegion,
    List<ProvinceEntity> provinces,
  ) {
    try {
      return provinces
          .firstWhere(
            (province) => province.cod == code && province.codRegion == codeRegion,
          )
          .name;
    } catch (e) {
      return null;
    }
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

  static String? getCodeFromName(
    String name,
    String codeProvince,
    String codeRegion,
    List<DistrictEntity> districts,
  ) {
    try {
      return districts
          .firstWhere(
            (district) =>
                district.name == name && district.codProvince == codeProvince && district.codRegion == codeRegion,
          )
          .cod;
    } catch (e) {
      return null;
    }
  }

  static String? getNameFromCode(
    String code,
    String codeProvince,
    String codeRegion,
    List<DistrictEntity> districts,
  ) {
    try {
      return districts
          .firstWhere(
            (district) =>
                district.cod == code && district.codProvince == codeProvince && district.codRegion == codeRegion,
          )
          .name;
    } catch (e) {
      return null;
    }
  }
}
