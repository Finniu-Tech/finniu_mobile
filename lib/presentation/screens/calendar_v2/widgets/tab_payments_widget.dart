import 'package:finniu/presentation/providers/investment_status_report_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/list_view_payments_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum PaymentStatus {
  past,
  recent,
  upcoming;

  String get displayName {
    switch (this) {
      case PaymentStatus.past:
        return 'Pasados';
      case PaymentStatus.recent:
        return 'Recientes';
      case PaymentStatus.upcoming:
        return 'Próximos';
    }
  }
}

enum PaymentCurrency {
  soles,
  dolares;

  String get displayName {
    switch (this) {
      case PaymentCurrency.soles:
        return 'nuevo sol';
      case PaymentCurrency.dolares:
        return 'dolar';
    }
  }

  String get symbol {
    switch (this) {
      case PaymentCurrency.soles:
        return 'S/';
      case PaymentCurrency.dolares:
        return '\$';
    }
  }
}

class PaymentData {
  final String uuid;
  final double amount;
  final int numberPayment;
  final String? paymentVoucherUrl;
  final PaymentStatus status;
  final DateTime paymentDate;
  final PaymentCurrency currency;
  final String? fundName;
  final bool isCapitalPayment;
  PaymentData({
    required this.uuid,
    required this.amount,
    required this.numberPayment,
    required this.paymentVoucherUrl,
    required this.status,
    required this.paymentDate,
    required this.currency,
    required this.isCapitalPayment,
    this.fundName,
  });

  factory PaymentData.fromJson(
      Map<String, dynamic> json, PaymentStatus status) {
    return PaymentData(
      uuid: json['uuid'],
      amount: double.parse(json['amount']),
      numberPayment: json['numberPayment'],
      paymentVoucherUrl: json['paymentVoucherUrl'],
      status: status,
      paymentDate: DateTime.parse(json['paymentDate']),
      currency: json['currency'] == PaymentCurrency.soles.displayName
          ? PaymentCurrency.soles
          : PaymentCurrency.dolares,
      fundName: json['fundName'],
      isCapitalPayment: json['isCapitalPayment'],
    );
  }
}

class TabPaymentsWidget extends ConsumerStatefulWidget {
  const TabPaymentsWidget({super.key, this.isReinvest});
  final bool? isReinvest;

  @override
  ConsumerState<TabPaymentsWidget> createState() =>
      _InvestmentHistoryBusiness();
}

class _InvestmentHistoryBusiness extends ConsumerState<TabPaymentsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentData = ref.watch(paymentListProvider);
    List<PaymentData> pastList = [];
    List<PaymentData> upcomingList = [];
    List<PaymentData> recentList = [];

    return paymentData.when(
      data: (data) {
        final passPayment = data;

        for (var element in passPayment) {
          if (element.status == PaymentStatus.past) {
            pastList.add(element);
          } else if (element.status == PaymentStatus.recent) {
            recentList.add(element);
          } else if (element.status == PaymentStatus.upcoming) {
            upcomingList.add(element);
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              // labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              controller: _tabController,
              isScrollable: false,
              tabs: [
                ButtonHistory(
                  isSelected: _tabController.index == 0,
                  text: PaymentStatus.past.displayName,
                ),
                ButtonHistory(
                  isSelected: _tabController.index == 1,
                  text: PaymentStatus.recent.displayName,
                ),
                ButtonHistory(
                  isSelected: _tabController.index == 2,
                  text: PaymentStatus.upcoming.displayName,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              constraints: const BoxConstraints(minHeight: 500),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.topCenter,
              child: TabBarView(
                controller: _tabController,
                children: [
                  PaymentListView(
                    list: pastList,
                    status: PaymentStatus.past,
                  ),
                  PaymentListView(
                    list: recentList,
                    status: PaymentStatus.recent,
                  ),
                  PaymentListView(
                    list: upcomingList,
                    status: PaymentStatus.upcoming,
                  ),
                ],
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
