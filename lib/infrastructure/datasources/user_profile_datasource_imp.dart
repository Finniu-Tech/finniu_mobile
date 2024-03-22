import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileDataSourceImp {
  Future update({required GraphQLClient client, required UserProfile userProfile}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          MutationRepository.updateUserProfile(),
        ),
        variables: {
          'firstName': userProfile.firstName,
          'lastName': userProfile.lastName,
          'docNumber': userProfile.documentNumber,
          'region': userProfile.region,
          'province': userProfile.provincia,
          'distric': userProfile.distrito,
          'civilStatus': userProfile.civilStatus,
          'imageProfile': userProfile.imageProfile,
          'address': userProfile.address,
          'occupation': userProfile.occupation,
        },
      ),
    );

    bool success = response.data?['updateUser']['success'];
    int percentCompleteProfile = response.data?['updateUser']['userProfile']['percentCompleteProfile'];
    return {'success': success, 'percentCompleteProfile': percentCompleteProfile};
  }

  Future<String?> updateAvatar({required GraphQLClient client, required String imageProfile}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          MutationRepository.updateAvatar(),
        ),
        variables: {'imageProfile': imageProfile},
      ),
    );
    bool success = response.data?['updateUserImageProfile']['success'];
    String imageProfileUrl = response.data?['updateUserImageProfile']['userProfile']['imageProfileUrl'];
    return success ? imageProfileUrl : null;
  }
}
