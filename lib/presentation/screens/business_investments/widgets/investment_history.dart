// ignore_for_file: unused_local_variable
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/to_validate_investment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToValidateItem {
  final String dateEnds;
  final int amount;
  ToValidateItem({
    required this.dateEnds,
    required this.amount,
  });
}

class InProgressItem {
  final String dateEnds;
  final int amount;
  InProgressItem({
    required this.dateEnds,
    required this.amount,
  });
}

class CompletedItem {
  final String dateEnds;
  final int amount;
  final bool isReInvestment;
  CompletedItem({
    required this.dateEnds,
    required this.amount,
    required this.isReInvestment,
  });
}

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

    final List<ToValidateItem> toValidateList = [
      ToValidateItem(dateEnds: '09/07/2024', amount: 1000),
      ToValidateItem(dateEnds: '10/07/2024', amount: 2000),
      ToValidateItem(dateEnds: '11/07/2024', amount: 3000),
      ToValidateItem(dateEnds: '12/07/2024', amount: 4000),
    ];
    final List<InProgressItem> inProgressList = [
      InProgressItem(dateEnds: '09/07/2024', amount: 1000),
      InProgressItem(dateEnds: '10/07/2024', amount: 2000),
      InProgressItem(dateEnds: '11/07/2024', amount: 3000),
      InProgressItem(dateEnds: '12/07/2024', amount: 4000),
    ];
    final List<CompletedItem> completedList = [
      CompletedItem(dateEnds: '09/07/2024', amount: 1000, isReInvestment: true),
      CompletedItem(
          dateEnds: '09/07/2024', amount: 21000, isReInvestment: false),
      CompletedItem(dateEnds: '09/07/2024', amount: 3000, isReInvestment: true),
      CompletedItem(
          dateEnds: '09/07/2024', amount: 4000, isReInvestment: false),
      CompletedItem(dateEnds: '09/07/2024', amount: 5000, isReInvestment: true),
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
                ToValidateList(list: toValidateList),
                InProgressList(list: inProgressList),
                CompletedList(list: completedList),
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

class CompletedList extends StatelessWidget {
  final List<CompletedItem> list;
  const CompletedList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 336,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CompleteInvestment(
                dateEnds: list[index].dateEnds,
                amount: list[index].amount,
                isReInvestment: list[index].isReInvestment,
              ),
            );
          },
        ),
      ),
    );
  }
}

class InProgressList extends StatelessWidget {
  final List<InProgressItem> list;
  const InProgressList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 336,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ProgressBarInProgress(
                dateEnds: list[index].dateEnds,
                amount: list[index].amount,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ToValidateList extends StatelessWidget {
  final List<ToValidateItem> list;
  const ToValidateList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 336,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ToValidateInvestment(
                dateEnds: list[index].dateEnds,
                amount: list[index].amount,
              ),
            );
          },
        ),
      ),
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
