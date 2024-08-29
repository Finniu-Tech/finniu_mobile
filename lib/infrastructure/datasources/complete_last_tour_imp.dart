import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CompleteLastTourImp extends GraphQLBaseDataSource {
  CompleteLastTourImp(super.client);

  Future<bool> completeLastTour() async {
    await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.completeLastTour(),
        ),
        variables: const {'hasCompletedTour': true},
      ),
    );
    return true;
  }
}
