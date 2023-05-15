import 'package:finniu/infrastructure/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class UserProfileDataSource {
  Future<bool> update({
    required GraphQLClient client,
    required UserProfile userProfile,
  });
}
