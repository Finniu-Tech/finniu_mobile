import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoInvestmentCase extends ConsumerWidget {
  const NoInvestmentCase({
    super.key,
    required this.title,
    required this.textBody,
  });
  final String title;
  final String textBody;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/investment/no_investment_case.png",
            width: 60,
            height: 60,
          ),
          const SizedBox(
            height: 5,
          ),
          TextPoppins(
            text: title,
            fontSize: 14,
            isBold: true,
          ),
          const SizedBox(
            height: 5,
          ),
          TextPoppins(
            text: textBody,
            fontSize: 12,
            isBold: false,
            lines: 3,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
