import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_list.dart';
import 'package:flutter/material.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/rent_contaiener.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/title_fond.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentScreenV4 extends StatelessWidget {
  const PaymentScreenV4({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return const Scaffold(
      appBar: AppBarProducts(
        title: "Cronograma de pagos",
      ),
      body: SingleChildScrollView(
        child: PaymentBody(),
      ),
    );
  }
}

class PaymentBody extends StatelessWidget {
  const PaymentBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProfitabilityItem> list = [
      ProfitabilityItem(
        paymentDate: DateTime(2023, 7, 1),
        amount: 50,
        numberPayment: 1,
        isPaid: true,
      ),
      ProfitabilityItem(
        paymentDate: DateTime(2023, 8, 1),
        amount: 50,
        numberPayment: 1,
        isPaid: true,
      ),
      ProfitabilityItem(
        paymentDate: DateTime(2023, 9, 1),
        amount: 50,
        numberPayment: 1,
      ),
      ProfitabilityItem(
        paymentDate: DateTime(2023, 10, 1),
        amount: 50,
        numberPayment: 1,
      ),
      ProfitabilityItem(
        paymentDate: DateTime(2023, 11, 1),
        amount: 50,
        numberPayment: 1,
      ),
      ProfitabilityItem(
        paymentDate: DateTime.now(),
        amount: 50,
        numberPayment: 1,
      ),
    ];
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const TitleFond(),
            const SizedBox(
              height: 15,
            ),
            const RentContainer(),
            const SizedBox(
              height: 15,
            ),
            const TitleTable(),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const TitleDataV4(),
                ProfitabilityListV4(
                  list: list,
                ),
              ],
            ),
            Column(
              children: [
                const TitleDataV4(),
                ProfitabilityListV4(
                  list: list,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TitleTable extends ConsumerWidget {
  const TitleTable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      children: [
        Icon(
          Icons.table_chart_outlined,
          size: 20,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
        ),
        const SizedBox(
          width: 10,
        ),
        const TextPoppins(
          text: "Tabla de pagos",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
