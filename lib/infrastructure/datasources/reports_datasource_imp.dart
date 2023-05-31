import 'package:finniu/domain/datasources/report_datasource.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReportDataSourceImp extends ReportDataSource {
  @override
  Future<Map> getUserReportHome({required GraphQLClient client}) {
    final response = client.query(
      QueryOptions(
        document: gql(
          QueryRepository.userHomeReport,
        ),
      ),
    );

    return response.then((value) => value.data!['userInfoInvestment'] as Map);
  }
}
