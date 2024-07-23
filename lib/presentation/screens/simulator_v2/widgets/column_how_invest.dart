import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColumnHowInvest extends ConsumerStatefulWidget {
  const ColumnHowInvest({
    super.key,
  });

  @override
  ConsumerState<ColumnHowInvest> createState() => _ColumnHowInvestState();
}

class _ColumnHowInvestState extends ConsumerState<ColumnHowInvest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int borderDark = 0xff101010;
    const int borderLight = 0xffD9D9D9;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TextPoppins(
          text: "¿Cuánto quiero invertir?",
          fontSize: 17,
          isBold: true,
        ),
        TextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: "${isSoles ? 's/' : '\$'} 10.000,00 ",
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(isDarkMode ? borderDark : borderLight),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(isDarkMode ? borderDark : borderLight),
              ),
            ),
          ),
          onChanged: (value) {
            var newValue = int.tryParse(value) ?? 0.0;
            ref.read(amountValueProvider.notifier).state = newValue.toInt();
          },
        ),
      ],
    );
  }
}
