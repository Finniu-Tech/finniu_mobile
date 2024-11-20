import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeContainer extends StatelessWidget {
  const ChangeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        children: [
          TitleChange(),
          SizedBox(
            height: 10,
          ),
          ChangeSunat(),
        ],
      ),
    );
  }
}

class ChangeSunat extends ConsumerWidget {
  const ChangeSunat({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border.all(
          width: 1.0,
          color: isDarkMode
              ? const Color(HomeV4Colors.changeBorderDark)
              : const Color(HomeV4Colors.changeBorderLight),
        ),
      ),
    );
  }
}

class TitleChange extends StatelessWidget {
  const TitleChange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextPoppins(
          text: "Tipo de cambio hoy!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textDark: HomeV4Colors.changeTitleDark,
          textLight: HomeV4Colors.changeTitleLight,
        ),
        Row(
          children: [
            Icon(Icons.access_time_outlined, size: 15),
            SizedBox(width: 5),
            TextPoppins(
              text: "Actualizado 23 hs",
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}
