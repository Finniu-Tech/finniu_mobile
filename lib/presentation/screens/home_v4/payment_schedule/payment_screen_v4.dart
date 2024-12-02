import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
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
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TitleFond(),
            SizedBox(
              height: 20,
            ),
            RentContainer(),
          ],
        ),
      ),
    );
  }
}

class RentContainer extends ConsumerWidget {
  const RentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String rent = "S/70.90";
    const String percent = "+1.40";
    const String dateInfo = "Actualizado Jul/2024";
    const int backgroundDark = 0xffD0FFB5;
    const int backgroundLight = 0xffD0FFB5;
    const int dateDark = 0xff0D3A5C;
    const int dateLight = 0xff0D3A5C;
    const int percentDark = 0xff109B60;
    const int percentLight = 0xff109B60;
    const int precentContainerDark = 0xffBDFF97;
    const int percentContainerLight = 0xffBDFF97;

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              TextPoppins(
                text: "Rentabilidad acumulada",
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextPoppins(
                text: rent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(precentContainerDark)
                      : const Color(percentContainerLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const TextPoppins(
                  text: percent,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  textDark: percentDark,
                  textLight: percentLight,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_sharp,
                size: 15,
                color:
                    isDarkMode ? const Color(dateDark) : const Color(dateLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: dateInfo,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                textDark: dateDark,
                textLight: dateLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TitleFond extends ConsumerWidget {
  const TitleFond({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconBankDark = 0xffBEF0FF;
    const int iconBankLight = 0xffBEF0FF;
    const String icon = "🏢";
    const String title = "Fondo inversión a Plazo Fijo";
    const int titleBankDark = 0xffECFBFF;
    const int titleBankLight = 0xffECFBFF;
    const int titleDark = 0xff0D3A5C;
    const int titleLight = 0xff0D3A5C;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 260),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: isDarkMode
                ? const Color(titleBankDark)
                : const Color(titleBankLight),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const TextPoppins(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode
                ? const Color(iconBankDark)
                : const Color(iconBankLight),
          ),
          child: const TextPoppins(
            text: icon,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
