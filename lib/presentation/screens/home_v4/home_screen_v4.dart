import 'package:finniu/presentation/screens/home_v4/widget/invest_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/scaffold_home_v4.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        InvestContainer(),
        Center(
          child: Text('Home Screen V4'),
        ),
        Skeletonizer(
          enabled: true,
          ignoreContainers: false,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Text(
              'Home Screen V4',
            ),
          ),
        ),
      ],
    );
  }
}
