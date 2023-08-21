import 'package:finniu/domain/datasources/app_version_datasource.dart';
import 'package:finniu/domain/entities/app_version_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppVersionDataSourceImp extends AppVersionDataSource {
  @override
  Future<AppVersionEntity> getLastVersion({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.appLastVersion,
        ),
      ),
    );

    return AppVersionEntity.fromJson(
      response.data?['lastVersion'] ?? {},
    );
  }
}
