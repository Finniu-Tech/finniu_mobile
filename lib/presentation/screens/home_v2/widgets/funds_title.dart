import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterpriseFundTitle extends ConsumerWidget {
  const EnterpriseFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 33,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(primaryLight)),
        color: const Color(lightBackgroundTitleFund),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          '🏢 Inversiones empresariales',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class AggroFundTitle extends ConsumerWidget {
  const AggroFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
