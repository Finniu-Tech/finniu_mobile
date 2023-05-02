import 'package:finniu/domain/datasources/dead_lines_datasource.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/repositories/dead_line_repository.dart';
import 'package:finniu/infrastructure/datasources/dead_line_datasource_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DeadLineRepositoryImp implements DeadLineRepository {
  final DeadLinesDataSource dataSource;
  DeadLineRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<List<DeadLineEntity>> getDeadLines({required GraphQLClient client}) {
    final DeadLinesDataSource dataSource = DeadLineDataSourceImp();
    return dataSource.getDeadLines(client: client);
  }
}
