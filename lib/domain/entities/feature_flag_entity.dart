// FeatureFlagNameEnum(
//   homeV2,
// )

import 'package:finniu/domain/entities/routes_entity.dart';

class FeatureFlags {
  static const String homeV2 = 'home_v2';
  static const String admin = 'admin';
}

class FeatureRoutes {
  static const Map<String, String> flagToRoute = {
    FeatureFlags.homeV2: Routes.homeV2,
  };

  static String getRouteForFlag(String flag, String defaultRoute) {
    return flagToRoute[flag] ?? defaultRoute;
  }
}

class FeatureFlagEntity {
  final String? uuid;
  final String name;
  final String? slug;
  final String? description;
  final bool isActive;

  FeatureFlagEntity({
    this.uuid,
    required this.name,
    this.slug,
    this.description,
    required this.isActive,
  });

  factory FeatureFlagEntity.fromJson(Map<String, dynamic> data) {
    return FeatureFlagEntity(
      uuid: data['uuid'],
      name: data['name'],
      slug: data['slug'],
      description: data['description'],
      isActive: data['isActive'] ?? false,
    );
  }
  static List<FeatureFlagEntity> listFromJson(List<dynamic> data) {
    return data.map((e) => FeatureFlagEntity.fromJson(e)).toList();
  }
}
