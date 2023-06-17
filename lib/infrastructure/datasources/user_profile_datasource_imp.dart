import 'package:finniu/domain/datasources/user_profile_datasource.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileDataSourceImp extends UserProfileDataSource {
  @override
  Future<bool> update(
      {required GraphQLClient client, required UserProfile userProfile}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          MutationRepository.updateUserProfile(),
        ),
        variables: {
          'firstName': userProfile.firstName,
          'lastName': userProfile.lastName,
          'docNumber': int.parse(userProfile.documentNumber ?? ''),
          'region': userProfile.region,
          'province': userProfile.provincia,
          'distric': userProfile.distrito,
          'civilStatus': userProfile.civilStatus,
          'imageProfile': userProfile.imageProfile
        },
      ),
    );
    bool success = response.data?['updateUser']['success'];
    return success;
  }
}
