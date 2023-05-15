import 'package:finniu/domain/datasources/user_profile_datasource.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileDataSourceImp extends UserProfileDataSource {
  @override
  Future<bool> update(
      {required GraphQLClient client, required UserProfile userProfile}) async {
    print('user profile in datasource');
    print(userProfile);
    print('first name');
    print(userProfile.firstName);
    print('last name');
    print(userProfile.lastName);
    print('document number');
    print(userProfile.documentNumber);
    print('region');
    print(userProfile.region);
    print('provincia');
    print(userProfile.provincia);
    print('distrito');
    print(userProfile.distrito);
    print('civil status');
    print(userProfile.civilStatus);
    print('image profile');
    print(userProfile.imageProfile);

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
          'district': userProfile.distrito,
          'civilStatus': userProfile.civilStatus,
          'imageProfile': userProfile.imageProfile
        },
      ),
    );
    print('update profile datasource');
    print(response);
    bool success = response.data?['updateUser']['success'];
    return success;
  }
}
