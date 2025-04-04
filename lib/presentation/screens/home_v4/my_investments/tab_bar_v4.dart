import 'package:finniu/domain/entities/user_all_investment_v4_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/widgets/complet_list.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/widgets/in_progress_v4.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/widgets/to_validate_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabBarBusinessV4 extends HookConsumerWidget {
  const TabBarBusinessV4({super.key, this.isReinvest});
  final bool? isReinvest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final userInvestment = ref.watch(userInfoAllInvestmentV4FutureProvider);
    final tabController = useTabController(
      initialLength: 3,
      initialIndex: isReinvest == true ? 1 : 0,
    );
    final currentIndex = useState(0);
    final initeState = useState(true);

    List<InvestmentV4> userToValidateList = [];
    List<InvestmentV4> userInProgressList = [];
    List<InvestmentV4> userCompletedList = [];
    useEffect(() {
      void listener() {
        currentIndex.value = tabController.index;
      }

      tabController.addListener(listener);
      return () => tabController.removeListener(listener);
    }, [
      tabController,
    ]);

    return userInvestment.when(
      data: (data) {
        if (isSoles) {
          userToValidateList =
              data?.investmentInSoles.investmentInProcess ?? [];
          userInProgressList = data?.investmentInSoles.investmentInCourse ?? [];
          userCompletedList = data?.investmentInSoles.investmentFinished ?? [];
        } else {
          userToValidateList =
              data?.investmentInDolares.investmentInProcess ?? [];
          userInProgressList =
              data?.investmentInDolares.investmentInCourse ?? [];
          userCompletedList =
              data?.investmentInDolares.investmentFinished ?? [];
        }
        if (userToValidateList.isNotEmpty && initeState.value) {
          initeState.value = false;
          currentIndex.value = 0;
        } else if (userInProgressList.isNotEmpty && initeState.value) {
          initeState.value = false;
          currentIndex.value = 1;
        } else if (userCompletedList.isNotEmpty && initeState.value) {
          initeState.value = false;
          currentIndex.value = 2;
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (tabController.index != currentIndex.value) {
            tabController.animateTo(currentIndex.value);
          }
        });

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                controller: tabController,
                tabs: [
                  ButtonHistory(
                    isSelected: currentIndex.value == 0,
                    text: 'Por validar',
                  ),
                  ButtonHistory(
                    isSelected: currentIndex.value == 1,
                    text: 'En curso',
                  ),
                  ButtonHistory(
                    isSelected: currentIndex.value == 2,
                    text: 'Finalizadas',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                alignment: Alignment.topCenter,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ToValidateListV4(
                      list: userToValidateList,
                    ),
                    InProgressListV4(list: userInProgressList),
                    CompletListV4(list: userCompletedList),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
