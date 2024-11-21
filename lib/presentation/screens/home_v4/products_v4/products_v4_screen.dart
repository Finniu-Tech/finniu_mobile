import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsV4Screen extends StatelessWidget {
  const ProductsV4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Productos'),
      ),
      body: const SingleChildScrollView(
        child: ProductsBody(),
      ),
    );
  }
}

class ProductsBody extends StatelessWidget {
  const ProductsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: const Column(
          children: [
            OurProducts(),
            ListProducts(),
          ],
        ),
      ),
    );
  }
}

class ListProducts extends ConsumerWidget {
  const ListProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ProductContainerStyles(
      backgroundContainerDark: 0xffE9FAFF,
      backgroundContainerLight: 0xffE9FAFF,
      imageProduct: "🏢",
      titleText: "Producto de inversión a Plazo Fijo",
      minimumText: "1.000",
      profitabilityText: "19",
      titleDark: 0xff0D3A5C,
      titleLight: 0xff0D3A5C,
      minimumDark: 0xffBBF0FF,
      minimumLight: 0xffBBF0FF,
      profitabilityDark: 0xffD2FDBA,
      profitabilityLight: 0xffD2FDBA,
    );
    final product2 = ProductContainerStyles(
      backgroundContainerDark: 0xffE9E5FF,
      backgroundContainerLight: 0xffE9E5FF,
      imageProduct: "🏡",
      titleText: "Producto de inversión con Garantía Inmobiliaria",
      minimumText: "50.000",
      profitabilityText: "16",
      titleDark: 0xff0D3A5C,
      titleLight: 0xff0D3A5C,
      minimumDark: 0xffBBF0FF,
      minimumLight: 0xffBBF0FF,
      profitabilityDark: 0xffD2FDBA,
      profitabilityLight: 0xffD2FDBA,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProductContainer(
            colors: product,
            onPressed: () {
              print(" ver mas info");
            },
          ),
          const SizedBox(height: 20),
          ProductContainer(
            colors: product2,
            onPressed: () {
              print(" ver mas info");
            },
          ),
        ],
      ),
    );
  }
}

class ProductContainer extends ConsumerWidget {
  const ProductContainer({
    super.key,
    required this.colors,
    required this.onPressed,
  });
  final Function()? onPressed;
  final ProductContainerStyles colors;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isDarkMode
            ? Color(colors.getBackgroundContainerDark)
            : Color(colors.getBackgroundContainerLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: colors.getImageProduct,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextPoppins(
                  text: colors.getTitleText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  lines: 2,
                  textDark: colors.getTitleDark,
                  textLight: colors.getTitleLight,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 95,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? Color(colors.getMinimumDark)
                        : Color(colors.getMinimumLight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextPoppins(
                        text: "Puedes comenzar a Invertir desde",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        lines: 2,
                      ),
                      TextPoppins(
                        text: "S/${colors.getMinimumText}",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        lines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 95,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? Color(colors.getProfitabilityDark)
                        : Color(colors.getProfitabilityLight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextPoppins(
                        text: "Con una rentabilidad de hasta",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        lines: 2,
                      ),
                      Row(
                        children: [
                          TextPoppins(
                            text: "${colors.getProfitabilityText}% ",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          const TextPoppins(
                            text: "anual",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(5),
              backgroundColor: WidgetStateProperty.all(
                Color(
                  isDarkMode
                      ? buttonBackgroundColorDark
                      : buttonBackgroundColorLight,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ver más información",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color(colorTextButtonDarkColor)
                        : const Color(colorTextButtonLightColor),
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Color(colorTextButtonLightColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OurProducts extends StatelessWidget {
  const OurProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppins(
              text: "Nuestros productos",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            TextPoppins(
              text: "Conoce los fondos de inversión",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        SwitchMoney(
          switchHeight: 30,
          switchWidth: 67,
        ),
      ],
    );
  }
}
