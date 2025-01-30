import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/product_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsV4Screen extends ConsumerWidget {
  const ProductsV4Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(HomeV4Colors.backgroudDark) : const Color(HomeV4Colors.backgroudLight),
      appBar: const AppBarProducts(),
      bottomNavigationBar: const NavBarV4(),
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
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final fundsData = ref.watch(fundListFutureProvider);

    final PageController pageController = PageController(initialPage: isSoles ? 0 : 1);

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
        width: MediaQuery.of(context).size.width * 0.85,
        child: fundsData.when(
          data: (funds) {
            final products = funds.map((fund) => ProductData.fromFund(fund)).toList();
            // print al product minimum text usd

            final soleProducts = products
                .where((p) => p.minimumTextPEN != null && p.minimumTextPEN!.isNotEmpty && p.minimumTextPEN != 'S/0.00')
                .toList();

            final dollarProducts = products
                .where((p) => p.minimumTextUSD != null && p.minimumTextUSD!.isNotEmpty && p.minimumTextUSD != '\$0.00')
                .toList();

            // final soleProducts = products.where((p) => p.isSoles).toList();
            // final dollarProducts = products.where((p) => !p.isSoles).toList();
            // print('sole: ${soleProducts.length}, dollar: ${dollarProducts.length}');

            return ExpandablePageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Column(
                  children: soleProducts
                      .map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ProductContainer(
                            product: product,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/v4/product',
                              arguments: product,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Column(
                  children: dollarProducts
                      .map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ProductContainer(
                            product: product,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/v4/product',
                              arguments: product,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error al cargar los fondos: $error')),
        ),
        // child: fundsData.when(
        //   loading: () => const Center(
        //     child: CircularProgressIndicator(),
        //   ),
        //   error: (error, stack) => Center(
        //     child: Text('Error al cargar los fondos: $error'),
        //   ),
        //   data: (funds) {
        //     // Separar fondos por tipo de moneda
        //     final soleFunds = funds.where((fund) => fund.minAmountInvestmentPEN != null).toList();

        //     final dollarFunds = funds.where((fund) => fund.minAmountInvestmentUSD != null).toList();

        //     return ExpandablePageView(
        //       physics: const NeverScrollableScrollPhysics(),
        //       controller: pageController,
        //       children: [
        //         // Vista de soles
        //         Column(
        //           children: soleFunds
        //               .map(
        //                 (fund) => Padding(
        //                   padding: const EdgeInsets.only(bottom: 20),
        //                   child: ProductContainer(
        //                     colors: productFixedTerm,
        //                     // colors: ProductColors(
        //                     //   backgroundColor: Color(fund.getHexListColorLight()),
        //                     //   backgroundColorDark: Color(fund.getHexListColorDark()),
        //                     // ),
        //                     onPressed: () {
        //                       Navigator.pushNamed(
        //                         context,
        //                         '/v4/product',
        //                         arguments: fund,
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               )
        //               .toList(),
        //         ),
        //         // Vista de dólares
        //         Column(
        //           children: dollarFunds
        //               .map(
        //                 (fund) => Padding(
        //                   padding: const EdgeInsets.only(bottom: 20),
        //                   child: ProductContainer(
        //                     colors: productFixedTerm,
        //                     onPressed: () {
        //                       Navigator.pushNamed(
        //                         context,
        //                         '/v4/product',
        //                         arguments: fund,
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               )
        //               .toList(),
        //         ),
        //       ],
        //     );
        //   },
        // ),
      ),
    );
  }
}

class ProductColors {
  final Color backgroundColor;
  final Color backgroundColorDark;

  ProductColors({
    required this.backgroundColor,
    required this.backgroundColorDark,
  });
}

// class ListProducts extends HookConsumerWidget {
//   const ListProducts({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isSoles = ref.watch(isSolesStateProvider);

//     final PageController pageController = PageController(initialPage: isSoles ? 0 : 1);

//     useEffect(
//       () {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           pageController.animateToPage(
//             duration: const Duration(milliseconds: 500),
//             isSoles ? 0 : 1,
//             curve: Curves.easeInOut,
//           );
//         });
//         return null;
//       },
//       [isSoles],
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.85,
//         child: ExpandablePageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: pageController,
//           children: [
//             Column(
//               children: [
//                 ProductContainer(
//                   colors: productFixedTerm,
//                   onPressed: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/v4/product',
//                       arguments: productFixedTerm,
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ProductContainer(
//                   colors: productRealEstate,
//                   onPressed: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/v4/product',
//                       arguments: productRealEstate,
//                     );
//                   },
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 ProductContainer(
//                   colors: product3,
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/v4/product', arguments: product3);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
            SizedBox(height: 20),
            TextPoppins(
              text: "Nuestros productos",
              fontSize: 20,
              fontWeight: FontWeight.w700,
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
