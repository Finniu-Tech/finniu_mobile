import 'package:finniu/domain/datasources/bank_datasource.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/repositories/bank_repository.dart';
import 'package:finniu/infrastructure/datasources/bank_datasource_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BankRepositoryImp implements BankRepository {
  final BankDataSource dataSource;
  BankRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<List<BankEntity>> getBanks({required GraphQLClient client}) {
    final BankDataSource dataSource = BankDataSourceImp();
    return dataSource.getBanks(client: client);
  }
}
