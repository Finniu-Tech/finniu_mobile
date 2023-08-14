import 'package:finniu/domain/datasources/report_datasource.dart';
import 'package:finniu/domain/entities/userProfileBalance.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReportDataSourceImp extends ReportDataSource {
  @override
  Future<UserProfileBalance> getUserReportHome(
      {required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.userHomeReport,
        ),
      ),
    );

    final balance = UserProfileBalance.fromJson(
      response.data!['userInfoInvestment'] ?? {},
    );

    return balance;
  }

  Future<UserProfileReport> getUserReportHomeV2(
      {required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.userHomeReportV2,
        ),
      ),
    );
    final balance = UserProfileReport.fromJson(
      response.data!['userInfoAllInvestment'] ?? {},
    );
    return balance;
  }
}
