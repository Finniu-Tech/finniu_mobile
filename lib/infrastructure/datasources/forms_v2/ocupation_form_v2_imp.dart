import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OccupationFormV2Imp extends GraphQLBaseDataSource {
  OccupationFormV2Imp(super.client);

  Future<RegisterUserV2Response> saveOccupationDataUserV2({
    required DtoOccupationForm data,
  }) async {
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.saveOccupationDataV2(),
          ),
          variables: {
            "laborSituation": data.laborSituation.name,
            "occupation": data.occupation,
            "companyName": data.companyName,
            "serviceTime": data.serviceTime.name,
          },
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      print(response.data);
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
        response.data?["registerUserOcupation"] ?? {},
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
