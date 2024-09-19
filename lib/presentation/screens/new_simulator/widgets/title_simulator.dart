import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleModal extends ConsumerWidget {
  const TitleModal({
    super.key,
    required this.status,
    this.isReInvestment,
  });
  final String status;
  final bool? isReInvestment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColor = 0xff55B63D;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextPoppins(
            text: isReInvestment == true ? "Resumen de mi reinversión" : "Resumen de mi inversión",
            fontSize: 20,
            isBold: true,
            lines: 2,
          ),
        ),
        Container(
          width: 84,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(backgroundColor),
          ),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                color: isDarkMode ? Colors.black : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
