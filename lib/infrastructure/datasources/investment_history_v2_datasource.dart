import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/blue_gold_investment/progress_blue_gold.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/tab_payments_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvestmentHistoryV2DataSource extends GraphQLBaseDataSource {
  InvestmentHistoryV2DataSource(super.client);

  Future<List<AggroInvestment>> getAggroInvestmentList() async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getAggroInvestmentList,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final List<dynamic> listInvestmentResponse = response.data?['agroInvestmentList'] ?? [];
    final fundList = AggroInvestment.fromJsonList(listInvestmentResponse);
    return fundList;
  }

  Future<List<PaymentData>> getPaymentList() async {
    final response = await client.query(
      QueryOptions(
        document: gql(QueryRepository.getPaymentDaysData),
      ),
    );

    if (response.hasException) {
      throw response.exception!;
    }

    final List<dynamic> corporatePaymentHistory = response.data?['corporatePaymentHistory'] ?? [];

    List<PaymentData> allPayments = [];

    for (var paymentGroup in corporatePaymentHistory) {
      allPayments.addAll(_processPaymentGroup(paymentGroup['passPayments'], PaymentStatus.past));
      allPayments.addAll(_processPaymentGroup(paymentGroup['recentPayments'], PaymentStatus.recent));
      allPayments.addAll(_processPaymentGroup(paymentGroup['nextPayments'], PaymentStatus.upcoming));
    }
    return allPayments;
  }

  List<PaymentData> _processPaymentGroup(List<dynamic> payments, PaymentStatus status) {
    return payments.map((payment) => PaymentData.fromJson(payment, status)).toList();
  }
}
