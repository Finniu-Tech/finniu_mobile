import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
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
      children: [
        Column(
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
