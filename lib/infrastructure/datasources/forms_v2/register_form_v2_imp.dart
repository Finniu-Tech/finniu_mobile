import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegisterFormV2Impl extends GraphQLBaseDataSource {
  RegisterFormV2Impl(super.client);

  Future<RegisterUserV2Response> saveCreateUserV2({
    required DtoRegisterForm data,
  }) async {
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.saveCreateUserV2(),
          ),
          variables: {
            "nickName": data.nickName,
            "countryPrefix": data.countryPrefix,
            "phoneNumber": data.phoneNumber,
            "email": data.email,
            "password": data.password,
            "confirmPassword": data.confirmPassword,
            "acceptTermsConditions": data.acceptTermsConditions,
            "acceptPrivacyPolicy": data.acceptPrivacyPolicy,
          },
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
        response.data?['registerUserV2'] ?? {},
      );
      return registerUserV2Response;
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
