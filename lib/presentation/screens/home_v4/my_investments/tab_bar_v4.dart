import 'package:finniu/domain/entities/user_all_investment_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
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
    final userInvestment = ref.watch(userInfoAllInvestmentFutureProvider);
    final tabController = useTabController(
      initialLength: 4,
      initialIndex: isReinvest == true ? 1 : 0,
    );

    List<Investment> userInPendingList = [];
    List<Investment> userToValidateList = [];
    List<Investment> userInProgressList = [];
    List<Investment> userCompletedList = [];

    return userInvestment.when(
      data: (data) {
        if (isSoles) {
          userToValidateList =
              data?.investmentInSoles.investmentInProcess ?? [];
          userInProgressList = data?.investmentInSoles.investmentInCourse ?? [];
          userInPendingList = data?.investmentInSoles.investmentPending ?? [];
          data?.investmentInSoles.investmentFinished.forEach((element) {
            userCompletedList.add(element);
            if (element.rentability != null) {
              userCompletedList.add(
                Investment(
                  uuid: element.uuid,
                  amount: element.rentability!,
                  finishDateInvestment: element.finishDateInvestment,
                  rentability: element.rentability,
                  isCapital: false,
                  boucherImage: null,
                ),
              );
            }
          });
        } else {
          userToValidateList =
              data?.investmentInDolares.investmentInProcess ?? [];
          userInProgressList =
              data?.investmentInDolares.investmentInCourse ?? [];
          userInPendingList = data?.investmentInDolares.investmentPending ?? [];
          data?.investmentInDolares.investmentFinished.forEach((element) {
            userCompletedList.add(element);
            if (element.rentability != null) {
              userCompletedList.add(
                Investment(
                  uuid: element.uuid,
                  amount: element.rentability!,
                  finishDateInvestment: element.finishDateInvestment,
                  rentability: element.rentability,
                  isCapital: false,
                  boucherImage: element.boucherImage,
                ),
              );
            }
          });
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                controller: tabController,
                isScrollable: true,
                tabs: [
                  ButtonHistory(
                    isSelected: tabController.index == 0,
                    text: 'Por validar',
                  ),
                  ButtonHistory(
                    isSelected: tabController.index == 1,
                    text: 'En curso',
                  ),
                  ButtonHistory(
                    isSelected: tabController.index == 2,
                    text: 'Pendientes',
                  ),
                  ButtonHistory(
                    isSelected: tabController.index == 3,
                    text: 'Finalizadas',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                alignment: Alignment.topCenter,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ToValidateListV4(
                      list: userToValidateList,
                    ),
                    InProgressList(list: userInProgressList),
                    PendingList(
                      list: userInPendingList,
                    ),
                    CompletedList(list: userCompletedList),
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
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
