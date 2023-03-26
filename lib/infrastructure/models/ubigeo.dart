import 'dart:convert';

class RegionData {
  RegionData({
    this.regions,
  });

  List<Region>? regions;

  factory RegionData.fromJson(Map<String, dynamic> json) => RegionData(
        regions: json["regions"] == null
            ? []
            : List<Region>.from(
                json["regions"]!.map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regions": regions == null
            ? []
            : List<dynamic>.from(regions!.map((x) => x.toJson())),
      };
}

class Region {
  Region({
    this.coddpto,
    this.nomDpto,
    this.slug,
  });

  String? coddpto;
  String? nomDpto;
  String? slug;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        coddpto: json["coddpto"],
        nomDpto: json["nomDpto"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "coddpto": coddpto,
        "nomDpto": nomDpto,
        "slug": slug,
      };
}

class ProvinceData {
  ProvinceData({
    this.provinces,
  });

  List<Province>? provinces;

  factory ProvinceData.fromJson(Map<String, dynamic> json) => ProvinceData(
        provinces: json["provincias"] == null
            ? []
            : List<Province>.from(
                json["provincias"]!.map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "provincias": provinces == null
            ? []
            : List<dynamic>.from(provinces!.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.idprov,
    this.codprov,
    this.nomProv,
    this.dpto,
    this.slug,
  });

  String? idprov;
  String? codprov;
  String? nomProv;
  Dpto? dpto;
  String? slug;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        idprov: json["idprov"],
        codprov: json["codprov"],
        nomProv: json["nomProv"],
        dpto: json["dpto"] == null ? null : Dpto.fromJson(json["dpto"]),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "idprov": idprov,
        "codprov": codprov,
        "nomProv": nomProv,
        "dpto": dpto?.toJson(),
        "slug": slug,
      };
}

class Dpto {
  Dpto({
    this.coddpto,
  });

  String? coddpto;

  factory Dpto.fromJson(Map<String, dynamic> json) => Dpto(
        coddpto: json["coddpto"],
      );

  Map<String, dynamic> toJson() => {
        "coddpto": coddpto,
      };
}

class DistrictData {
  DistrictData({
    this.districts,
  });

  List<District>? districts;

  factory DistrictData.fromJson(Map<String, dynamic> json) => DistrictData(
        districts: json["distritos"] == null
            ? []
            : List<District>.from(
                json["distritos"]!.map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "distritos": districts == null
            ? []
            : List<dynamic>.from(
                districts!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class District {
  District({
    this.prov,
    this.iddist,
    this.coddist,
    this.nomDist,
    this.codregion,
    this.slug,
  });

  Prov? prov;
  String? iddist;
  String? coddist;
  Dpto? codregion;
  String? nomDist;
  String? slug;

  factory District.fromJson(Map<String, dynamic> json) => District(
        prov: json["prov"] == null ? null : Prov.fromJson(json["prov"]),
        iddist: json["iddist"],
        coddist: json["coddist"],
        nomDist: json["nomDist"],
        codregion:
            json["prov"] == null ? null : Dpto.fromJson(json["prov"]["dpto"]),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "prov": prov?.toJson(),
        "iddist": iddist,
        "coddist": coddist,
        "nomDist": nomDist,
        "codregion": codregion,
        "slug": slug,
      };
}

class Prov {
  Prov({
    this.codprov,
  });

  String? codprov;

  factory Prov.fromJson(Map<String, dynamic> json) => Prov(
        codprov: json["codprov"],
      );

  Map<String, dynamic> toJson() => {
        "codprov": codprov,
      };
}
