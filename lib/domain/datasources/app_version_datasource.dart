import 'package:finniu/domain/entities/app_version_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class AppVersionDataSource {
  Future<AppVersionEntity> getLastVersion({
    required GraphQLClient client,
  });
}
