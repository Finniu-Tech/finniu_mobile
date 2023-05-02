import 'package:finniu/domain/entities/dead_line.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class DeadLinesDataSource {
  Future<List<DeadLineEntity>> getDeadLines({
    required GraphQLClient client,
  });
}
