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
          ChangeRextie(),
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
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home_v4/sunat_logo_${isDarkMode ? "dark" : "light"}.png",
            width: 64,
            height: 35,
          ),
          const SizedBox(
            width: 30,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: "Compra",
                fontSize: 7,
                fontWeight: FontWeight.w500,
              ),
              TextPoppins(
                text: "3.7890",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: "Venta",
                fontSize: 7,
                fontWeight: FontWeight.w500,
              ),
              TextPoppins(
                text: "3.8520",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChangeRextie extends ConsumerWidget {
  const ChangeRextie({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: isDarkMode
            ? const Color(HomeV4Colors.rextieContainerDark)
            : const Color(HomeV4Colors.rextieContainerLight),
        border: Border.all(
          width: 1.0,
          color: isDarkMode
              ? const Color(HomeV4Colors.changeBorderDark)
              : const Color(HomeV4Colors.changeBorderLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home_v4/rextie_logo_${isDarkMode ? "dark" : "light"}.png",
            width: 64,
            height: 35,
          ),
          const SizedBox(
            width: 30,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: "Compra",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
              TextPoppins(
                text: "3.7890",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieBuyDark,
                textLight: HomeV4Colors.rextieBuyLight,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: "Venta",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
              TextPoppins(
                text: "3.8520",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(HomeV4Colors.rextieButtonDark)
                    : const Color(HomeV4Colors.rextieButtonDark),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: TextPoppins(
                  text: "Cambia ya!",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textDark: HomeV4Colors.rextieButtonTextDark,
                  textLight: HomeV4Colors.rextieButtonTextLight,
                ),
              ),
            ),
          ),
        ],
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
