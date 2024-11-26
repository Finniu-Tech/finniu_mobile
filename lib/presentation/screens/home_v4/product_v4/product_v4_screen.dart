import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/app_bar_product.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailV4 extends ConsumerWidget {
  const ProductDetailV4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff000000;
    const int colorLight = 0xffFFFFFF;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(colorDark) : const Color(colorLight),
      appBar: const AppBarProduct(),
      body: const SingleChildScrollView(
        child: ProductBody(),
      ),
    );
  }
}

class ProductBody extends StatelessWidget {
  const ProductBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
