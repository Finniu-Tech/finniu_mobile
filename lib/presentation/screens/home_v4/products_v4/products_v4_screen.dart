import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class ListProducts extends HookConsumerWidget {
  const ListProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);

    final PageController pageController =
        PageController(initialPage: isSoles ? 0 : 1);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          pageController.animateToPage(
            duration: const Duration(milliseconds: 500),
            isSoles ? 0 : 1,
            curve: Curves.easeInOut,
          );
        });
        return null;
      },
      [isSoles],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ExpandablePageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Column(
              children: [
                ProductContainer(
                  colors: product,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductContainer(
                  colors: product2,
                  onPressed: () {},
                ),
              ],
            ),
            Column(
              children: [
                ProductContainer(
                  colors: product3,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
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
