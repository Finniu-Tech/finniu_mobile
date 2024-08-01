import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/title_simulator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ModalInvestmentSummary extends StatelessWidget {
  const ModalInvestmentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonInvestment(
      text: 'Invierte',
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => const BodyModalInvestment(),
      ),
    );
  }
}

class BodyModalInvestment extends ConsumerWidget {
  const BodyModalInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff1A1A1A;
    const backgroundLight = 0xffFFFFFF;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 529,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            CloseButton(),
            SizedBox(height: 10),
            TitleModal(
              status: "En curso",
            ),
            SizedBox(height: 10),
            IconFund(),
            SizedBox(height: 10),
            SizedBox(height: 10),
            SizedBox(height: 10),
            SizedBox(height: 10),
            InvestmentEnds(
              finalDate: "123",
            ),
          ],
        ),
      ),
    );
  }
}

class CloseButton extends ConsumerWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffFFFFFF;
    const int colorLight = 0xff515151;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Transform.rotate(
              angle: math.pi / 4,
              child: Icon(
                Icons.add_circle_outline,
                size: 20,
                color: isDarkMode
                    ? const Color(colorDark)
                    : const Color(colorLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
