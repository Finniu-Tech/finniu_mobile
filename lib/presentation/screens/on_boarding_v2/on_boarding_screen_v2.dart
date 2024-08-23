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
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            child: const PositionedColumn(),
          ),
        ],
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
          PageSelect(isDarkMode: true),
        ],
      ),
    );
  }
}

class PageSelect extends ConsumerWidget {
  const PageSelect({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ItemSelect(isSelected: true, isDarkMode: isDarkMode),
          ItemSelect(isSelected: false, isDarkMode: isDarkMode),
          ItemSelect(isSelected: false, isDarkMode: isDarkMode),
          ItemSelect(isSelected: false, isDarkMode: isDarkMode),
          ItemSelect(isSelected: false, isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}

class ItemSelect extends StatelessWidget {
  const ItemSelect({
    super.key,
    required this.isSelected,
    required this.isDarkMode,
  });
  final bool isSelected;
  final bool isDarkMode;
  final int itemDarkSelect = 0xffA2E6FA;
  final int itemLightSelect = 0xff0D3A5C;
  final int itemDarkNotSelect = 0xff141414;
  final int itemLightNotSelect = 0xffE6E6E6;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 7,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: isDarkMode
            ? isSelected
                ? Color(itemDarkSelect)
                : Color(itemDarkNotSelect)
            : isSelected
                ? Color(itemLightSelect)
                : Color(itemLightNotSelect),
      ),
    );
  }
}
