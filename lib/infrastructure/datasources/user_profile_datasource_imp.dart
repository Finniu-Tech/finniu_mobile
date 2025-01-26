import 'package:finniu/domain/entities/user_profile_completeness.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileDataSourceImp {
  Future update({required GraphQLClient client, required UserProfile userProfile}) async {
    String? region = userProfile.region;
    if (userProfile.region == '') {
      region = null;
    }
    String? province = userProfile.provincia;
    if (userProfile.provincia == '') {
      province = null;
    }

    String? district = userProfile.distrito;
    if (userProfile.distrito == '') {
      district = null;
    }

    final variables = {
      'firstName': userProfile.firstName,
      'lastName': userProfile.lastName,
      'docNumber': userProfile.documentNumber,
      'region': region,
      'province': province,
      'distric': district,
      'civilStatus': userProfile.civilStatus,
      'imageProfile': userProfile.imageProfile,
      'address': userProfile.address,
      'occupation': userProfile.occupation,
    };
    final response = await client.query(
      QueryOptions(
        document: gql(
          MutationRepository.updateUserProfile(),
        ),
        variables: variables,
      ),
    );
    bool success = response.data?['updateUser']['success'];
    int percentCompleteProfile = response.data?['updateUser']['userProfile']?['percentCompleteProfile'] ?? 0;
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

  Future<UserProfileCompleteness> getUserProfileCompleteness({required GraphQLClient client}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            QueryRepository.getProfileCompleteness,
          ),
          fetchPolicy: FetchPolicy.noCache,
        ),
      );

      if (response.data == null || response.data?['userCompletenessProfile'] == null) {
        throw Exception('No se encontraron datos del perfil');
      }

      final profileData = response.data?['userCompletenessProfile'];

      final profile = UserProfileCompleteness.fromJson(profileData);

      return profile;
    } catch (e, _) {
      rethrow;
    }
  }
}
