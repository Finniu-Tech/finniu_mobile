import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LocationFormV2Imp extends GraphQLBaseDataSource {
  LocationFormV2Imp(super.client);

  Future<RegisterUserV2Response> saveLocationDataUserV2({
    required DtoLocationForm data,
  }) async {
    print('data save location ${data.toJson()}');

    final isPeru = data.country == "Peru";

    final Map<String, dynamic> variables = {
      "country": data.country,
      "address": data.address,
    };

    if (isPeru) {
      variables.addAll({
        "region": data.region,
        "province": data.province,
        "district": data.district,
      });
    } else {
      variables.addAll({
        "regionExt": data.extRegion,
        "provinceExt": data.extProvince,
        "districtExt": data.extDistrict,
      });
    }

    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.saveLocationDataV2(),
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

      return RegisterUserV2Response.fromJson(
        response.data?["registerUserUbication"] ?? {},
      );
    } catch (e) {
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
