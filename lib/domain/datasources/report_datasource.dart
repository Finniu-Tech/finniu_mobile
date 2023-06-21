import 'package:finniu/domain/entities/userProfileBalance.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ReportDataSource {
  Future<UserProfileBalance> getUserReportHome({
    required GraphQLClient client,
  });
}
