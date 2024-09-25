import 'package:finniu/domain/entities/legal_document_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetLegalDocumentsImp extends GraphQLBaseDataSource {
  GetLegalDocumentsImp(super.client);

  Future<UserGetLegalDocuments> getLegalDocuments() async {
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(
            QueryRepository.getLegalDocuments,
          ),
        ),
      );
      final data = result.data;
      if (data == null) {
        return UserGetLegalDocuments(
          legalAcceptance: LegalAcceptance(
            termsAndConditions: '',
            privacyPolicy: '',
          ),
          sunatDeclarations: [],
        );
      }
      UserGetLegalDocuments response =
          UserGetLegalDocuments.fromJson(data["userGetLegalDocuments"]);
      return response;
    } catch (e) {
      return UserGetLegalDocuments(
        legalAcceptance: LegalAcceptance(
          termsAndConditions: '',
          privacyPolicy: '',
        ),
        sunatDeclarations: [],
      );
    }
  }
}
