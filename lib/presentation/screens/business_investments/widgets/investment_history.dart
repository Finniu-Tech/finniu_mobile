// ignore_for_file: unused_local_variable

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentHistoryBusiness extends ConsumerStatefulWidget {
  const InvestmentHistoryBusiness({super.key});

  @override
  ConsumerState<InvestmentHistoryBusiness> createState() =>
      _InvestmentHistoryBusiness();
}

class _InvestmentHistoryBusiness
    extends ConsumerState<InvestmentHistoryBusiness> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    final List<String> porValidarList = ["Card 1", "Card 2", "Card 3"];
    final List<String> enCursoList = ["Card 4", "Card 5"];
    final List<String> finalizadasList = [
      "Card 6",
      "Card 7",
      "Card 8",
      "Card 9",
      "Card 6",
      "Card 7",
      "Card 8",
      "Card 9"
    ];

    return SizedBox(
      height: 355,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonHistory(
                text: 'Por validar',
                isSelected: _selectedIndex == 0,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              ButtonHistory(
                text: 'En curso',
                isSelected: _selectedIndex == 1,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              ButtonHistory(
                text: 'Finalizadas',
                isSelected: _selectedIndex == 2,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                CardList(list: porValidarList),
                CardList(list: enCursoList),
                CardList(list: finalizadasList),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CardList extends StatelessWidget {
  final List<String> list;
  const CardList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(list[index]),
          ),
        );
      },
    );
  }
}

class ButtonHistory extends ConsumerWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  const ButtonHistory({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    int textDark = isSelected ? 0xff0D3A5C : 0xffFFFFFF;
    int textLight = isSelected ? 0xffffffff : 0xff000000;
    int backgroundDark = isSelected ? 0xffA2E6FA : 0xff0E0E0E;
    int backgroundLight = isSelected ? 0xff0D3A5C : 0xffF8F8F8;
    const int borderDark = 0xffA2E6FA;
    const int borderLight = 0xff0D3A5C;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 5).copyWith(),
        decoration: BoxDecoration(
          color: isDarkMode ? Color(backgroundDark) : Color(backgroundLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color:
                isDarkMode ? const Color(borderDark) : const Color(borderLight),
            width: 1.0,
          ),
        ),
        child: TextPoppins(
          text: text,
          fontSize: 12,
          isBold: true,
          textDark: textDark,
          textLight: textLight,
        ),
      ),
    );
  }
}
