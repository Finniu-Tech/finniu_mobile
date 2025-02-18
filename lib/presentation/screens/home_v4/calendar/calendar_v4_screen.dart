import 'package:finniu/presentation/providers/calendar_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/calendar/widgets/calendar_container.dart';
import 'package:finniu/presentation/screens/home_v4/calendar/widgets/list_invest_month.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/rent_contaiener.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarScreenV4 extends StatelessWidget {
  const CalendarScreenV4({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return const Scaffold(
      appBar: AppBarProducts(
        title: "Mi calendario de pagos",
      ),
      body: SingleChildScrollView(
        child: CalendarColumn(),
      ),
    );
  }
}

class CalendarColumn extends StatelessWidget {
  const CalendarColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const CalendarContainer(),
            const SizedBox(
              height: 15,
            ),
            const TitleRent(),
            const SizedBox(
              height: 15,
            ),
            const RentContainer(
              isRender: false,
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer(
              builder: (context, ref, _) {
                final selectedDate = ref.watch(selectedCalendarDateProvider);
                return ListInvestMonth(
                  selectedDate: selectedDate,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleRent extends StatelessWidget {
  const TitleRent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String title = "Rentabilidad generada en el mes";
    return const TextPoppins(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
}
