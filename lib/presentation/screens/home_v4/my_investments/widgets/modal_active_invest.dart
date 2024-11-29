import 'dart:async';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void showModalActiveInvest(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const SizedBox(
      height: 450,
      child: ActiveModalBody(),
    ),
  );
}

class ActiveModalBody extends ConsumerWidget {
  const ActiveModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String tesmInvest = "3";
    const String estateInvest = "1";
    final List<ChartData> chartData = [
      ChartData(
        'Plazo Fijo',
        75,
        isDarkMode ? const Color(0xffA2E6FA) : const Color(0xff0D3A5C),
      ),
      ChartData(
        'Inmobiliario',
        25,
        isDarkMode ? const Color(0xff8066E8) : const Color(0xffB9A8FF),
      ),
    ];
    void closeModal() => Navigator.pop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: isDarkMode
            ? const Color(ActiveModal.backgroundDark)
            : const Color(ActiveModal.backgroundLight),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: closeModal,
                icon: Transform.rotate(
                  angle: math.pi / -4,
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 24,
                    color: isDarkMode
                        ? const Color(ActiveModal.iconDark)
                        : const Color(ActiveModal.iconLight),
                  ),
                ),
              ),
            ),
          ),
          const TextPoppins(
            text: "Inversiones activas",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textDark: ActiveModal.textDark,
            textLight: ActiveModal.textLight,
          ),
          const SizedBox(height: 20),
          GrafixInvestUser(
            data: chartData,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 82,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(ActiveModal.borderTermDark)
                          : const Color(ActiveModal.borderTermLight),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TextPoppins(
                            text: tesmInvest,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            textDark: ActiveModal.textDark,
                            textLight: ActiveModal.textLight,
                          ),
                          const TextPoppins(
                            text: " Inversiones",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textDark: ActiveModal.textDark,
                            textLight: ActiveModal.textLight,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: isDarkMode
                                ? const Color(ActiveModal.borderTermDark)
                                : const Color(ActiveModal.borderTermLight),
                          ),
                        ],
                      ),
                      const TextPoppins(
                        text: "Fondo inversión a Plazo Fijo",
                        fontSize: 10,
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
                  height: 82,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(ActiveModal.borderTermDark)
                          : const Color(ActiveModal.borderTermLight),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TextPoppins(
                            text: estateInvest,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            textDark: ActiveModal.textDark,
                            textLight: ActiveModal.textLight,
                          ),
                          const TextPoppins(
                            text: " Inversiones",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textDark: ActiveModal.textDark,
                            textLight: ActiveModal.textLight,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: isDarkMode
                                ? const Color(ActiveModal.borderTermDark)
                                : const Color(ActiveModal.borderTermLight),
                          ),
                        ],
                      ),
                      const TextPoppins(
                        text: "Fondo inversión con garantía inmobiliaria",
                        fontSize: 10,
                        lines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GrafixInvestUser extends HookConsumerWidget {
  const GrafixInvestUser({super.key, required this.data});
  final List<ChartData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final PageController pageController = usePageController();
    final currentPage = useState(0);

    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff000000;

    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (currentPage.value < data.length - 1) {
            currentPage.value++;
          } else {
            currentPage.value = 0;
          }

          pageController.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
        return timer.cancel;
      },
      [],
    );

    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SlideCarouselCard(
            color: isDarkMode
                ? ActiveModal.backgroundDark
                : ActiveModal.backgroundLight,
            body: SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, _) => data.color,
                  innerRadius: '70%',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                  ),
                  selectionBehavior: SelectionBehavior(
                    enable: true,
                    selectedBorderWidth: 2,
                    selectedBorderColor: Colors.black,
                  ),
                  initialSelectedDataIndexes: [currentPage.value],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              children: data.map((e) {
                return SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "${e.value}%",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        textDark: textDark,
                        textLight: textLight,
                      ),
                      TextPoppins(
                        text: e.category,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        textDark: textDark,
                        textLight: textLight,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
