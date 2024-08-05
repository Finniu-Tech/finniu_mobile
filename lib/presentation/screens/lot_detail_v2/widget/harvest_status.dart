import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HarvestStatus extends ConsumerWidget {
  const HarvestStatus({
    super.key,
    required this.harvestNumber,
    required this.passedDays,
    required this.missingDays,
    required this.progress,
  });
  final String harvestNumber;
  final String passedDays;
  final String missingDays;
  final double progress;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ProcessStatus(
            harvestNumber: harvestNumber,
          ),
          const _ImageStack(),
          _SlideStatus(
            progress: progress,
          ),
          _DaysPassedMissing(
            passedDays: passedDays,
            missingDays: missingDays,
          ),
        ],
      ),
    );
  }
}

class _DaysPassedMissing extends StatelessWidget {
  const _DaysPassedMissing({
    required this.passedDays,
    required this.missingDays,
  });
  final String passedDays;
  final String missingDays;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextPoppins(
          text: passedDays,
          fontSize: 12,
          isBold: true,
        ),
        TextPoppins(
          text: missingDays,
          fontSize: 12,
          isBold: true,
        ),
      ],
    );
  }
}

class _SlideStatus extends StatefulWidget {
  const _SlideStatus({
    required this.progress,
  });
  final double progress;
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
        _widthFactor = widget.progress;
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
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Image.asset(
        "assets/blue_gold/image_detail.png",
        width: MediaQuery.of(context).size.width,
        height: 90,
      ),
    );
  }
}

class _ProcessStatus extends StatelessWidget {
  const _ProcessStatus({required this.harvestNumber});
  final String harvestNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextPoppins(text: "Proceso de ", fontSize: 11),
        TextPoppins(
          text: "$harvestNumber cosecha",
          fontSize: 11,
          isBold: true,
        ),
      ],
    );
  }
}
