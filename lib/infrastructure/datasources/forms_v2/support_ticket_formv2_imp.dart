import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/presentation/screens/config_v2/helpers/send_ticket.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SupportTicketFormv2Imp extends GraphQLBaseDataSource {
  SupportTicketFormv2Imp(super.client);

  Future<bool> saveSupportTicketV2({
    required DtoSupportForm data,
  }) async {
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.createSupportTicket(),
          ),
          variables: {
            'category': data.category,
            'email': data.email,
            'name': data.firstName,
            'lastName': data.lastName,
            'description': data.message,
            'imageReport': data.imageBase64,
          },
          fetchPolicy: FetchPolicy.noCache,
        ),
      );

      final responseJson = response.data?['createSupportTicket'];
      return responseJson != null;
    } catch (e) {
      return false;
    }
  }
}
