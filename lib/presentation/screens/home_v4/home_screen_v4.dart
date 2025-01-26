import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/last_operation_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/home_v2/home_screen.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/complete_profile.dart';
import 'package:finniu/presentation/screens/home_v4/widget/change_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/invest_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/last_operation_slider_v4.dart';
import 'package:finniu/presentation/screens/home_v4/widget/news_container.dart';
import 'package:finniu/presentation/screens/home_v4/widget/scaffold_home_v4.dart';
import 'package:finniu/presentation/screens/home_v4/widget/see_later_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return const Stack(
      children: [
        Column(
          children: [
            InvestContainer(),
            SizedBox(
              height: 20,
            ),
            GetFundToSlider(),
            ProfileCompletenessSection(),
            ChangeContainer(),
            DividerHome(),
            NewsContainer(),
            SizedBox(height: 80),
          ],
        ),
        SeeLaterWidgetV4(),
      ],
    );
  }
}

class GetFundToSlider extends ConsumerWidget {
  const GetFundToSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundListAsyncValue = ref.watch(fundListFutureProvider);

    return fundListAsyncValue.when(
      loading: () => const Center(
          child: CircularLoader(
        width: 50,
        height: 50,
      )),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (fundList) {
        return SliderContainer(fund: fundList.first);
      },
    );
  }
}

class SliderContainer extends ConsumerWidget {
  const SliderContainer({super.key, required this.fund});
  final FundEntity fund;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastOperationsAsyncValue = ref.watch(lastOperationsFutureProvider(fund.uuid));
    // List<LastOperation> reinvestmentOperations = [];
    final isSoles = ref.watch(isSolesStateProvider);
    final selectedCurrency = isSoles ? 'nuevo sol' : 'dolar';
    List<LastOperation> filteredOperations = [];

    return lastOperationsAsyncValue.when(
      data: (lastOperations) {
        if (fund.fundType == FundTypeEnum.corporate) {
          // reinvestmentOperations = LastOperation.filterByReInvestmentOperations(lastOperations);
          filteredOperations =
              lastOperations.where((element) => element.enterprisePreInvestment?.currency == selectedCurrency).toList();

          lastOperations = filteredOperations;
        }
        return filteredOperations.isNotEmpty
            ? LastOperationsSliderV4(
                fund: fund,
                lastOperations: filteredOperations,
              )
            : const SizedBox.shrink();
      },
      loading: () => const Center(
        child: CircularLoader(
          width: 50,
          height: 50,
        ),
      ),
      error: (error, stack) => SizedBox(
        height: 300,
        child: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class SliderInvest extends ConsumerWidget {
  const SliderInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> items = [
      SliderInCourse(
        amount: 500,
        fundName: "Inversion empresarial",
        onPressed: () {},
      ),
      const ToValidateSlider(
        amount: 500,
        fundName: "Inversion empresarial",
      ),
    ];

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 94,
        viewportFraction: 0.9,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
      ),
    );
  }
}

class DividerHome extends ConsumerWidget {
  const DividerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
      child: Divider(
        thickness: 2,
        color: isDarkMode ? const Color(HomeV4Colors.dividerDark) : const Color(HomeV4Colors.dividerLight),
      ),
    );
  }
}
