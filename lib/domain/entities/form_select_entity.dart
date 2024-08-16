class GeoLocationItemV2 {
  final String id;
  final String name;
  GeoLocationItemV2({
    required this.id,
    required this.name,
  });
  factory GeoLocationItemV2.fromJson(Map<String, dynamic> json) {
    return GeoLocationItemV2(
      id: json['id'] as String,
      name: json['nomDpto'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomDpto': name,
    };
  }
}

class GeoLocationResponseV2 {
  final List<GeoLocationItemV2> regions;
  GeoLocationResponseV2({
    required this.regions,
  });
  factory GeoLocationResponseV2.fromJson(Map<String, dynamic> json) {
    var list = json['regions'] as List;
    List<GeoLocationItemV2> regionsList =
        list.map((i) => GeoLocationItemV2.fromJson(i)).toList();
    return GeoLocationResponseV2(regions: regionsList);
  }
  Map<String, dynamic> toJson() {
    return {
      'regions': regions.map((e) => e.toJson()).toList(),
    };
  }
}
