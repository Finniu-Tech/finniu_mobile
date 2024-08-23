import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_select.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: StackOnBoarding(),
      ),
    );
  }
}

class StackOnBoarding extends ConsumerStatefulWidget {
  const StackOnBoarding({
    super.key,
  });

  @override
  StackOnBoardingState createState() => StackOnBoardingState();
}

class StackOnBoardingState extends ConsumerState<StackOnBoarding> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          PageOneContainer(),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            child: const PositionedColumn(),
          ),
        ],
      ),
    );
  }
}

class PageOneContainer extends ConsumerWidget {
  const PageOneContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const List<Color> gradientDark = [
      Color(0xFF0D3A5C),
      Color(0xFF306281),
      Color(0xFFA2E6FA),
    ];
    const List<Color> gradientLight = [
      Color(0xFF9F8FFF),
      Color(0xFFA1D6FB),
      Color(0xFFA2E6FA),
    ];
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode ? gradientDark : gradientLight,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

class PositionedColumn extends StatelessWidget {
  const PositionedColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageSelect(isDarkMode: false),
        ],
      ),
    );
  }
}
