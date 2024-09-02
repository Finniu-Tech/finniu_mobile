import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FeatureFlagDataSource extends GraphQLBaseDataSource {
  FeatureFlagDataSource(super.client);

  Future<List<FeatureFlagEntity>> getFeatureFlags() async {
    final result = await client.query(
      QueryOptions(
        document: gql(QueryRepository.userFeatureFlags),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    // print('result feature flag: ${result.data}');
    return FeatureFlagEntity.listFromJson(
      result.data?['userProfile']?['featuresFlagsAvailable'] ?? [],
    );
  }
}
