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
    // return response.then((value) => value.data!['userInfoInvestment'] as Map);
    // return response.then(
    //   (value) => UserProfileBalance.fromJson(value.data!['userInfoInvestment']),
    // );
  }
}
