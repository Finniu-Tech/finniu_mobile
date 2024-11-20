import 'package:finniu/presentation/screens/home_v4/widget/change_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/invest_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/scaffold_home_v4.dart';
import 'package:flutter/material.dart';

class HomeScreenV4 extends StatelessWidget {
  const HomeScreenV4({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldHomeV4(
      body: HomeBodyV4(),
    );
  }
}

class HomeBodyV4 extends StatelessWidget {
  const HomeBodyV4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InvestContainer(
          isLoaded: false,
        ),
        ChangeContainer(),
      ],
    );
  }
}
