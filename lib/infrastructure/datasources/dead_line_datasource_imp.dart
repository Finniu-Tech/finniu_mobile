import 'package:finniu/domain/datasources/dead_lines_datasource.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/dead_line_mapper.dart';
import 'package:finniu/infrastructure/models/dead_line_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DeadLineDataSourceImp extends DeadLinesDataSource {
  @override
  Future<List<DeadLineEntity>> getDeadLines({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getDeadLines,
        ),
      ),
    );
    print('get onboarding data******');
    print(response);
    final responseDeadLines = DeadLineResponse.fromJson(
      response.data ?? {},
    );
    return DeadLineMapper.listToEntity(responseDeadLines);
  }
}
