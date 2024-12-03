import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';

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
        child: CalendarBody(),
      ),
    );
  }
}

class CalendarBody extends StatelessWidget {
  const CalendarBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(),
      ),
    );
  }
}
