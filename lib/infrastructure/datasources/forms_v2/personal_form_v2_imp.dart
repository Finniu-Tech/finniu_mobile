import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PersonalFormV2Imp extends GraphQLBaseDataSource {
  PersonalFormV2Imp(super.client);

  Future<RegisterUserV2Response> savePersonalDataUserV2({
    required DtoPersonalForm data,
  }) async {
    try {
      final Map<String, dynamic> variables = {
        "firstName": data.firstName,
        "lastNameFather": data.lastNameFather,
        "lastNameMother": data.lastNameMother,
        "documentType": data.documentType.name,
        "documentNumber": data.documentNumber,
        "civilStatus": data.civilStatus.name,
        "gender": data.gender.name,
      };
      if (data.imageProfile != null) {
        variables["imageProfile"] = data.imageProfile;
      }

      if (data.birthday != null) {
        variables["birthdayDate"] = data.birthday;
      }

      final QueryResult<Object?> response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.savePersonalDataV2(),
          ),
          variables: variables,
          fetchPolicy: FetchPolicy.noCache,
        ),
      );

      if (response.data == null) {
        return RegisterUserV2Response(
          success: false,
          messages: [
            Message(
              errorCode: '401',
              field: '',
              message: 'Ocurrio un error, intente nuevamente',
            ),
          ],
        );
      }
      final RegisterUserV2Response registerUserV2Response =
          RegisterUserV2Response.fromJson(
        response.data?["registerPersonalData"] ?? {},
      );
      return registerUserV2Response;
    } catch (e) {
      print(e);
      return RegisterUserV2Response(
        messages: [
          Message(
            errorCode: '401',
            field: '',
            message: 'Ocurrio un error, intente nuevamente',
          ),
        ],
        success: false,
      );
    }
  }
}
