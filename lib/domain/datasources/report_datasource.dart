import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ReportDataSource {
  Future<Map> getUserReportHome({
    required GraphQLClient client,
  });
}
