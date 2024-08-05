import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/infrastructure/datasources/feature_flags_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final featureFlagsDataSourceProvider = Provider<FeatureFlagDataSource>((ref) {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return FeatureFlagDataSource(client);
});

final userFeatureFlagListFutureProvider = FutureProvider.autoDispose<List<FeatureFlagEntity>>((ref) async {
  final FeatureFlagDataSource dataSource = ref.watch(featureFlagsDataSourceProvider);
  final List<FeatureFlagEntity> featureFlags = await dataSource.getFeatureFlags();
  return featureFlags;
});

final featureFlagsProvider = StateNotifierProvider<FeatureFlagsNotifier, Map<String, bool>>((ref) {
  return FeatureFlagsNotifier();
});

class FeatureFlagsNotifier extends StateNotifier<Map<String, bool>> {
  FeatureFlagsNotifier() : super({});

  void setFeatureFlags(List<FeatureFlagEntity> flags) {
    state = {for (var flag in flags) flag.name: flag.isActive};
  }

  bool isEnabled(String featureName) {
    return state[featureName] ?? false;
  }
}
