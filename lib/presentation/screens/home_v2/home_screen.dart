import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/last_operation_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/all_investment_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/carrousel_slider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/our_investment_funds.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/custom_app_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/show_draft_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/slider_draft.dart';
import 'package:finniu/presentation/screens/investment_v2/investment_screen_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreenV2 extends HookConsumerWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(navigatorStateProvider.notifier).state = 0;
        });
        return null;
      },
      [],
    );

    return PopScope(
      child: Scaffold(
        appBar: CustomAppBar(
          currentTheme: currentTheme,
          userProfile: userProfile,
        ),
        backgroundColor: Color(currentTheme.isDarkMode ? scaffoldBlackBackground : scaffoldLightGradientPrimary),
        bottomNavigationBar: const NavigationBarHome(),
        body: HookBuilder(
          builder: (context) {
            final userProfile = ref.watch(userProfileFutureProvider);

            return userProfile.when(
              data: (profile) {
                return HomeBody(
                  currentTheme: currentTheme,
                  userProfile: profile,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
            );
          },
        ),
      ),
    );
  }
}

class HomeBody extends HookConsumerWidget {
  const HomeBody({
    super.key,
    required this.currentTheme,
    required this.userProfile,
  });

  final SettingsProviderState currentTheme;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool renderNonInvestment = false;
    final homeReport = ref.watch(homeReportProviderV2);
    homeReport.when(
      data: (data) {
        var reportSoles = data.solesBalance;
        var reportDollar = data.dolarBalance;
        if (reportSoles.totalBalance == 0 && reportDollar.totalBalance == 0) {
          renderNonInvestment = true;
        } else {
          renderNonInvestment = false;
        }
      },
      loading: () => renderNonInvestment = true,
      error: (error, stackTrace) => renderNonInvestment = true,
    );
    useEffect(
      () {
        final hasCompletedOnboarding = ref.read(hasCompletedOnboardingProvider);
        if (hasCompletedOnboarding == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/onboarding_questions_start');
          });
        }
        return null;
      },
      [],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        print('HomeBody constraints: $constraints');
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentTheme.isDarkMode
                    ? [const Color(scaffoldBlackBackground), const Color(backgroundColorNavbar)]
                    : [
                        const Color(scaffoldLightGradientPrimary),
                        const Color(scaffoldLightGradientSecondary),
                      ],
                stops: const [0.4, 0.6],
              ),
            ),
            child: Column(
              children: [
                BodyHomeUpperSectionWidget(currentTheme: currentTheme, renderNonInvestment: renderNonInvestment),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: OurInvestmentFunds(),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (ref.watch(featureFlagsProvider)[FeatureFlags.admin] == true) ...[
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/home_home'),
                    child: const Text('Ir a home normal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/catalog'),
                    child: const Text('Ver Catalogo de Widgets'),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

class BodyHomeUpperSectionWidget extends StatefulHookConsumerWidget {
  const BodyHomeUpperSectionWidget({
    Key? key,
    required this.currentTheme,
    required this.renderNonInvestment,
  }) : super(key: key);

  final SettingsProviderState currentTheme;
  final bool renderNonInvestment;

  @override
  _BodyHomeUpperSectionWidgetState createState() => _BodyHomeUpperSectionWidgetState();
}

class _BodyHomeUpperSectionWidgetState extends ConsumerState<BodyHomeUpperSectionWidget> {
  final PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final fundListAsyncValue = ref.watch(fundListFutureProvider);

    return fundListAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (fundList) {
        List<PageWidget> pageWidgets = fundList.map((fund) {
          return PageWidget(
            title: GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  fundList.indexOf(fund),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                setState(() {
                  selectedPage = fundList.indexOf(fund);
                });
              },
              child: FundTitleAndNavigate(
                isSelect: selectedPage == fundList.indexOf(fund),
                fund: fund,
              ),
            ),
            itemBuilder: FundHomeUpperSectionWidget(fund: fund),
          );
        }).toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            print('BodyHomeUpperSectionWidget constraints: $constraints');
            return Container(
              width: double.infinity,
              height: 450,
              // constraints: BoxConstraints(
              //   minHeight: 300,
              //   maxHeight: 450,
              // ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: widget.currentTheme.isDarkMode
                    ? const Color(scaffoldBlackBackground)
                    : const Color(scaffoldLightGradientPrimary),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: pageWidgets.map((widget) => widget.title).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    fit: FlexFit.loose,
                    child: PageView.builder(
                      itemCount: pageWidgets.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: pageWidgets[index].itemBuilder,
                          ),
                        );
                      },
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedPage = index;
                        });
                      },
                    ),
                  ),
                  if (widget.renderNonInvestment)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (widget.renderNonInvestment)
                    const Center(
                      child: NonInvestmentContainer(),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class FundTitleAndNavigate extends ConsumerWidget {
  final FundEntity fund;
  final bool isSelect;
  const FundTitleAndNavigate({super.key, required this.fund, required this.isSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return fund.fundType == FundTypeEnum.corporate
        ? RealStateTitleAndNavigate(isSelect: isSelect, isDarkMode: isDarkMode, funName: fund.name)
        : BlueGoldTitleAndNavigate(
            isDarkMode: isDarkMode,
            isSelect: isSelect,
            fundName: fund.name,
          );
  }
}

class FundHomeUpperSectionWidget extends ConsumerWidget {
  final FundEntity fund;
  const FundHomeUpperSectionWidget({
    Key? key,
    required this.fund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('fund uuid: ${fund.uuid}');
    final lastOperationsAsyncValue = ref.watch(lastOperationsFutureProvider(fund.uuid));
    List<LastOperation> reinvestmentOperations = [];
    return lastOperationsAsyncValue.when(
      data: (lastOperations) {
        print('lastOperations: $lastOperations');
        if (fund.fundType == FundTypeEnum.corporate) {
          reinvestmentOperations = LastOperation.filterByReInvestmentOperations(lastOperations);
        }
        print('reinvestmentOperations: $reinvestmentOperations');
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const GraphicContainer(),
            const SizedBox(height: 10),
            if (lastOperations.isNotEmpty) ...[
              LastOperationsSlider(
                lastOperations: lastOperations,
              ),
              const SizedBox(height: 10),
            ],
            if (reinvestmentOperations.isNotEmpty) ...[
              ReInvestmentSlider(
                operations: reinvestmentOperations,
              ),
              const SizedBox(height: 10),
            ],
            Center(
              child: AllInvestmentButton(
                text: 'Ver todas mis inversiones',
                onPressed: () {
                  Navigator.pushNamed(context, '/v2/investment');
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class SliderDraftData {
  final String uuid;
  final int amountNumber;
  final bool isReinvest;
  final int profitability;
  final int termMonth;
  final bool moneyIcon;
  final bool cardSend;
  final bool statusUp;
  final String currency;

  SliderDraftData({
    required this.uuid,
    required this.amountNumber,
    required this.isReinvest,
    required this.profitability,
    required this.termMonth,
    required this.moneyIcon,
    required this.cardSend,
    required this.statusUp,
    required this.currency,
  });
}

// class ContainerSliderDraft extends ConsumerWidget {
//   const ContainerSliderDraft({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final SliderDraftData sliderDraftData = SliderDraftData(
//       uuid: '123',
//       amountNumber: 10000,
//       isReinvest: false,
//       profitability: 10,
//       termMonth: 12,
//       moneyIcon: true,
//       cardSend: true,
//       statusUp: true,
//     );
//     return SliderDraft(
//       amountNumber: sliderDraftData.amountNumber,
//       onTap: () => showDraftModal(
//         context,
//         amountNumber: sliderDraftData.amountNumber,
//         isReinvest: sliderDraftData.isReinvest,
//         profitability: sliderDraftData.profitability,
//         termMonth: sliderDraftData.termMonth,
//         uuid: sliderDraftData.uuid,
//         moneyIcon: sliderDraftData.moneyIcon,
//         cardSend: sliderDraftData.cardSend,
//         statusUp: sliderDraftData.statusUp,
//       ),
//     );
//   }
// }

class LastOperationsSlider extends ConsumerStatefulWidget {
  final List<LastOperation> lastOperations;

  const LastOperationsSlider({
    super.key,
    required this.lastOperations,
  });

  @override
  ContainerLastOperationsState createState() => ContainerLastOperationsState();
}

class ContainerLastOperationsState extends ConsumerState<LastOperationsSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<SliderDraftData> sliderItems = widget.lastOperations.map((operation) {
      print('operation rentability: ${operation.enterprisePreInvestment?.rentability}');
      return SliderDraftData(
        uuid: operation.enterprisePreInvestment!.uuidPreInvestment,
        amountNumber: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
        isReinvest: operation.enterprisePreInvestment!.isReInvestment,
        profitability: operation.enterprisePreInvestment!.rentability?.toInt() ?? 0,
        termMonth: operation.enterprisePreInvestment?.deadline ?? 0,
        moneyIcon: false,
        cardSend: false,
        statusUp: operation.enterprisePreInvestment?.status == 'draft',
        currency: operation.enterprisePreInvestment!.currency,
      ); //todo check all status
    }).toList();

    // Limitar a 6 elementos si hay más
    if (sliderItems.length > 15) {
      sliderItems = sliderItems.sublist(0, 15);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: sliderItems.map((item) {
            return SliderDraft(
              amountNumber: item.amountNumber,
              onTap: () => showDraftModal(context,
                  amountNumber: item.amountNumber,
                  isReinvest: item.isReinvest,
                  profitability: item.profitability,
                  termMonth: item.termMonth,
                  uuid: item.uuid,
                  moneyIcon: item.moneyIcon,
                  cardSend: item.cardSend,
                  statusUp: item.statusUp,
                  currency: item.currency),
            );
          }).toList(),
          options: CarouselOptions(
            height: 94,
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // options: CarouselOptions(
          //   height: 94,
          //   viewportFraction: 0.9,
          //   enlargeCenterPage: true,
          //   enableInfiniteScroll: false,
          //   autoPlay: false,
          //   autoPlayInterval: const Duration(seconds: 3),
          //   onPageChanged: (index, reason) {
          //     setState(() {
          //       _currentIndex = index;
          //     });
          //   },
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sliderItems.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => {}, // Aquí puedes implementar la lógica para cambiar de slide al tocar un dot
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),

        // ItemSelectCarrousel(
        //   sliderItems: sliderItems,
        //   currentIndex: _currentIndex,
        // ),
      ],
    );
  }
}

// class _BodyHomeUpperSectionWidgetState extends ConsumerState<BodyHomeUpperSectionWidget> {
//   final PageController pageController = PageController();
//   int selectedPage = 0;
//   @override
//   Widget build(BuildContext context) {
//     List<PageWidget> pageWidgets = [
//       PageWidget(
//         title: GestureDetector(
//           onTap: () {
//             pageController.animateToPage(
//               0,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.ease,
//             );
//             setState(() {
//               selectedPage = 0;
//             });
//           },
//           child: RealStateTitleAndNavigate(
//             isSelect: selectedPage == 0,
//             isDarkMode: widget.currentTheme.isDarkMode,
//           ),
//         ),
//         // itemBuilder: const RealEstateBody(),
//         itemBuilder: Container(),
//       ),
//       PageWidget(
//         title: GestureDetector(
//           onTap: () {
//             pageController.animateToPage(
//               1,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.ease,
//             );
//             setState(() {
//               selectedPage = 1;
//             });
//           },
//           child: BlueGoldTitleAndNavigate(
//             isSelect: selectedPage == 1,
//             isDarkMode: widget.currentTheme.isDarkMode,
//           ),
//         ),
//         // itemBuilder: const BlueGoldBody(),
//         itemBuilder: Container(),
//       ),
//     ];
//     return Container(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.45,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           bottomRight: Radius.circular(50),
//         ),
//         color: widget.currentTheme.isDarkMode
//             ? const Color(scaffoldBlackBackground)
//             : const Color(scaffoldLightGradientPrimary),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               // const Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 20),
//               //   child: Align(
//               //     alignment: Alignment.topLeft,
//               //     child: EnterpriseFundTitle(),
//               //   ),
//               // ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: 45,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     pageWidgets[0].title,
//                     const SizedBox(width: 7),
//                     pageWidgets[1].title,
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.9,
//                 child: PageView.builder(
//                   itemCount: pageWidgets.length,
//                   itemBuilder: (context, index) {
//                     return pageWidgets[index].itemBuilder;
//                   },
//                   controller: pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       selectedPage = index;
//                     });
//                   },
//                 ),
//               ),
//               // const Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 20),
//               //   child: GraphicContainer(),
//               // ),
//               const SizedBox(
//                 height: 10,
//               ),
//               AllInvestmentButton(
//                 text: 'Ver todas mis inversiones',
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/v2/investment');
//                 },
//               ),
//             ],
//           ),
//           widget.renderNonInvestment
//               ? Positioned.fill(
//                   child: IgnorePointer(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.transparent.withOpacity(0.1),
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(50),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           widget.renderNonInvestment
//               ? const Center(
//                   child: NonInvestmentContainer(),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
