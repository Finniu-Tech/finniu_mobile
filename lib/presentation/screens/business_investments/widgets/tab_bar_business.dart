import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/user_all_investment_entity.dart';
import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_info_all_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/to_validate_investment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabBarBusiness extends ConsumerStatefulWidget {
  const TabBarBusiness({super.key, this.isReinvest});
  final bool? isReinvest;

  @override
  ConsumerState<TabBarBusiness> createState() => _InvestmentHistoryBusiness();
}

class _InvestmentHistoryBusiness extends ConsumerState<TabBarBusiness>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.isReinvest == true ? 1 : 0,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInvestment = ref.watch(userInfoAllInvestmentFutureProvider);
    final isSoles = ref.watch(isSolesStateProvider);
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
          userCompletedList = data?.investmentInSoles.investmentFinished ?? [];
          userInPendingList = data?.investmentInSoles.investmentPending ?? [];
        } else {
          userToValidateList =
              data?.investmentInDolares.investmentInProcess ?? [];
          userInProgressList =
              data?.investmentInDolares.investmentInCourse ?? [];
          userCompletedList =
              data?.investmentInDolares.investmentFinished ?? [];
          userInPendingList = data?.investmentInDolares.investmentPending ?? [];
        }

        return Column(
          children: [
            TabBar(
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              controller: _tabController,
              isScrollable: true,
              tabs: [
                ButtonHistory(
                  isSelected: _tabController.index == 0,
                  text: 'Por validar',
                ),
                ButtonHistory(
                  isSelected: _tabController.index == 1,
                  text: 'En curso',
                ),
                ButtonHistory(
                  isSelected: _tabController.index == 2,
                  text: 'Pendientes',
                ),
                ButtonHistory(
                  isSelected: _tabController.index == 3,
                  text: 'Finalizadas',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 336,
              height: MediaQuery.of(context).size.height * 0.4,
              constraints: const BoxConstraints(minHeight: 300),
              alignment: Alignment.topCenter,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ToValidateList(
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

class CompletedList extends StatelessWidget {
  final List<Investment> list;
  const CompletedList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones finalizadas",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones finalizadas cuando finaliza el plazo de tu inversión",
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/v2/summary',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.finished,
                        ),
                      );
                    },
                    child: CompleteInvestment(
                      dateEnds: list[index].finishDateInvestment,
                      amount: list[index].amount,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class InProgressList extends StatelessWidget {
  final List<Investment> list;
  const InProgressList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones en curso",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones finalizadas cuando finaliza el plazo de tu inversión",
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/v2/summary',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.in_course,
                          isReinvestAvailable:
                              list[index].isReinvestAvailable ?? false,
                          actionStatus: list[index].actionStatus ?? "",
                        ),
                      );
                    },
                    child: ProgressBarInProgress(
                      dateEnds: list[index].finishDateInvestment,
                      amount: list[index].amount,
                      isReinvestmentAvailable:
                          list[index].isReinvestAvailable ?? false,
                      actionStatus: list[index].actionStatus ?? "",
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/v2/summary',
                          arguments: ArgumentsNavigator(
                            uuid: list[index].uuid,
                            status: StatusInvestmentEnum.in_course,
                            isReinvestAvailable:
                                list[index].isReinvestAvailable ?? false,
                            actionStatus: list[index].actionStatus ?? "",
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ToValidateList extends StatelessWidget {
  final List<Investment> list;
  const ToValidateList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones por validar",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones por validar cuando hayas realizado una inversión reciente y no ha sido aprobada aún",
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/v2/summary',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.in_process,
                        ),
                      );
                    },
                    child: ToValidateInvestment(
                      dateEnds: list[index].finishDateInvestment,
                      amount: list[index].amount,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PendingList extends StatelessWidget {
  final List<Investment> list;
  const PendingList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones pendientes",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones por validar cuando hayas realizado una inversión reciente y no ha sido aprobada aún",
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                print('is reinvest 11111${list[index].isReinvestment}');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/v2/summary',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.pending,
                        ),
                      );
                    },
                    child: ToValidateInvestment(
                      dateEnds: list[index].finishDateInvestment,
                      amount: list[index].amount,
                      isReinvestment:
                          list[index].isReinvestment == true ? true : false,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ButtonHistory extends ConsumerWidget {
  final String text;
  final bool isSelected;
  const ButtonHistory({
    super.key,
    required this.text,
    required this.isSelected,
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

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5).copyWith(),
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
      child: Center(
        child: TextPoppins(
          text: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textDark: textDark,
          textLight: textLight,
        ),
      ),
    );
  }
}
