import 'package:finniu/domain/repositories/recovery_password.dart';
import 'package:finniu/infrastructure/datasources/recovery_password_datasource_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RecoveryPasswordRepositoryImp implements RecoveryPasswordRepository {
  RecoveryPasswordRepositoryImp({
    required this.dataSource,
  });

  final RecoveryPasswordDataSourceImp dataSource;

  @override
  Future<bool> sendEmailRecoveryPassword({
    required GraphQLClient client,
    required String email,
  }) async {
    return await dataSource.sendEmailRecoveryPassword(
      client: client,
      email: email,
    );
  }
}
