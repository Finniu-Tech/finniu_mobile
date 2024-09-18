import 'package:finniu/domain/entities/legal_document_entity.dart';
import 'package:finniu/infrastructure/datasources/get_legal_documents_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userGetLegalProvider = FutureProvider<UserGetLegalDocuments>((ref) async {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return GetLegalDocumentsImp(client).getLegalDocuments();
});
