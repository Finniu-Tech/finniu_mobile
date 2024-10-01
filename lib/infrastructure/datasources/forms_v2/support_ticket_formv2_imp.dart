import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/presentation/screens/config_v2/helpers/send_ticket.dart';

class SupportTicketFormv2Imp extends GraphQLBaseDataSource {
  SupportTicketFormv2Imp(super.client);

  Future<bool> saveSupportTicketV2({
    required DtoSupportForm data,
  }) async {
    try {
      // final response = await client.mutate(
      //   MutationOptions(
      //     document: gql(
      //       MutationRepository.savePersonalDataV2(),
      //     ),
      //     variables: {
      //       "firstName": data.firstName,

      //     },
      //     fetchPolicy: FetchPolicy.noCache,
      //   ),
      // );
      print(data.category);
      print(data.email);
      print(data.firstName);
      print(data.lastName);
      print(data.message);
      print(data.imageBase64);
      Future.delayed(const Duration(seconds: 2), () {});
      return true;
    } catch (e) {
      return false;
    }
  }
}
