import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HarvestStatus extends ConsumerWidget {
  const HarvestStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xff5BA9FF;
    const int borderLight = 0xff5BA9FF;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 227,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isDarkMode ? const Color(borderDark) : const Color(borderLight),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ProcessStatus(),
          _ImageStack(),
          _SlideStatus(),
          _DaysPassedMissing(),
        ],
      ),
    );
  }
}

class _DaysPassedMissing extends StatelessWidget {
  const _DaysPassedMissing();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextPoppins(
          text: "2 AÑOS",
          fontSize: 12,
          isBold: true,
        ),
        TextPoppins(
          text: "4 AÑOS",
          fontSize: 12,
          isBold: true,
        ),
      ],
    );
  }
}

class _SlideStatus extends StatefulWidget {
  const _SlideStatus();

  @override
  State<_SlideStatus> createState() => _SlideStatusState();
}

class _SlideStatusState extends State<_SlideStatus> {
  double _widthFactor = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _widthFactor = 0.6;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const int missing = 0xffD6E9FF;
    const int passed = 0xff5BA9FF;

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(missing),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: constraints.maxWidth * _widthFactor,
              height: 5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color(passed),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ImageStack extends StatelessWidget {
  const _ImageStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        children: [
          Center(
            child: Image.asset("assets/blue_gold/line_blue_gold.png"),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/blue_gold/person_blue_gold.png",
              width: 65,
              height: 65,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/blue_gold/detail_blue_gold.png",
              height: 90,
              width: 90,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessStatus extends StatelessWidget {
  const _ProcessStatus();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextPoppins(text: "Proceso de ", fontSize: 11),
        TextPoppins(
          text: "2 cosecha",
          fontSize: 11,
          isBold: true,
        ),
      ],
    );
  }
}
