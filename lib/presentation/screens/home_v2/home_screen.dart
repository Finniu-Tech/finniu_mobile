import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/last_operation_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
// import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar/slider_bar.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/home/widgets/reinvestment_available_card.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/all_investment_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/complete_profile.dart';
// import 'package:finniu/presentation/screens/home_v2/widgets/carrousel_slider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/our_investment_funds.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/custom_app_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/show_draft_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/slider_draft.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/show_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/show_tour_container.dart';
import 'package:finniu/presentation/screens/investment_v2/investment_screen_v2.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Scaffold(
      appBar: CustomAppBar(
        currentTheme: currentTheme,
        userProfile: userProfile,
      ),
      backgroundColor: Color(
        currentTheme.isDarkMode
            ? scaffoldBlackBackground
            : scaffoldLightGradientPrimary,
      ),
      bottomNavigationBar: const NavigationBarHome(),
      extendBody: true,
      body: HookBuilder(
        builder: (context) {
          final userProfile = ref.watch(userProfileFutureProvider);

          return userProfile.when(
            data: (profile) {
              _setUserAnalytics(ref, profile);
              _handleTourAndNotifications(context, ref, profile);
              return Stack(
                children: [
                  HomeBody(
                    currentTheme: currentTheme,
                    userProfile: profile,
                  ),
                  if (ref.read(seeLaterProvider) == true &&
                      profile.hasCompletedTour == false)
                    Positioned(
                      left: 0,
                      top: MediaQuery.of(context).size.height * 0.2,
                      child: const ShowTourContainer(),
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text(error.toString())),
          );
        },
      ),
    );
  }

  void _setUserAnalytics(WidgetRef ref, UserProfile profile) {
    final analytics = ref.read(firebaseAnalyticsServiceProvider);
    analytics.setUserId(
      "${profile.firstName}_${profile.lastName}${profile.email}_${profile.documentNumber}_${profile.phoneNumber}",
    );
    analytics.setUserProperty(
      name: "first_name",
      value: "${profile.firstName}_${profile.lastName}",
    );
    analytics.setUserProperty(
      name: "document_number",
      value: "${profile.documentNumber}",
    );
    analytics.setUserProperty(
      name: "email",
      value: "${profile.email}",
    );
    analytics.setUserProperty(
      name: "phone_number",
      value: "${profile.phoneNumber}",
    );
  }

  void _handleTourAndNotifications(
      BuildContext context, WidgetRef ref, UserProfile profile) {
    if (profile.hasCompletedTour != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        bool seeLaterTour = ref.watch(seeLaterProvider);

        if (profile.hasCompletedTour == false && seeLaterTour == false) {
          showTourV2(context);
        }

        if (profile.hasCompletedTour == true) {
          final pushNotificationService = PushNotificationService();
          await pushNotificationService.requestPermissions(context);
          String? token = await pushNotificationService.getToken();

          if (token != null) {
            // TODO: set user token to the backend
            // ref.read(firebaseAnalyticsServiceProvider).setUserProperty(
            //       name: "fcm_token",
            //       value: token,
            //     );
          }
        }
      });
    }
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

    // useEffect(
    //   () {
    //     final hasCompletedOnboarding = ref.read(hasCompletedOnboardingProvider);
    //     if (hasCompletedOnboarding == false) {
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         Navigator.of(context).pushReplacementNamed('/onboarding_questions_start');
    //       });
    //     }
    //     return null;
    //   },
    //   [],
    // );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentTheme.isDarkMode
                    ? [
                        const Color(scaffoldBlackBackground),
                        const Color(backgroundColorNavbar),
                      ]
                    : [
                        const Color(scaffoldLightGradientPrimary),
                        const Color(scaffoldLightGradientSecondary),
                      ],
                stops: const [0.4, 0.6],
              ),
            ),
            child: Column(
              children: [
                const ProfileCompletenessSection(),
                BodyHomeUpperSectionWidget(
                  currentTheme: currentTheme,
                  renderNonInvestment: renderNonInvestment,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: OurInvestmentFunds(),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (ref.watch(featureFlagsProvider)[FeatureFlags.admin] ==
                    true) ...[
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/home_home'),
                    child: const Text('Ir a home normal'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/catalog'),
                    child: const Text('Ir a catalogo'),
                  )
                ],
                const SizedBox(
                  height: 120,
                ),
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
    super.key,
    required this.currentTheme,
    required this.renderNonInvestment,
  });

  final SettingsProviderState currentTheme;
  final bool renderNonInvestment;

  @override
  _BodyHomeUpperSectionWidgetState createState() =>
      _BodyHomeUpperSectionWidgetState();
}

class _BodyHomeUpperSectionWidgetState
    extends ConsumerState<BodyHomeUpperSectionWidget> {
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
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: widget.currentTheme.isDarkMode
                    ? const Color(scaffoldBlackBackground)
                    : const Color(scaffoldLightGradientPrimary),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 35,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: pageWidgets
                              .map((widget) => widget.title)
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ExpandablePageView.builder(
                        itemCount: pageWidgets.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: pageWidgets[index].itemBuilder,
                          );
                        },
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedPage = index;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  // if (widget.renderNonInvestment)
                  //   Positioned.fill(
                  //     child: IgnorePointer(
                  //       child: BackdropFilter(
                  //         filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.transparent.withOpacity(0.1),
                  //             borderRadius: const BorderRadius.only(
                  //               bottomRight: Radius.circular(50),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // if (widget.renderNonInvestment)
                  //   const Center(
                  //     child: NonInvestmentContainer(),
                  //   ),
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
  const FundTitleAndNavigate({
    super.key,
    required this.fund,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return fund.fundType == FundTypeEnum.corporate
        ? RealStateTitleAndNavigate(
            isSelect: isSelect,
            isDarkMode: isDarkMode,
            funName: fund.name,
          )
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
    super.key,
    required this.fund,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print('fund uuid: ${fund.uuid}');
    final lastOperationsAsyncValue =
        ref.watch(lastOperationsFutureProvider(fund.uuid));
    // List<LastOperation> reinvestmentOperations = [];
    final isSoles = ref.watch(isSolesStateProvider);
    final selectedCurrency = isSoles ? 'nuevo sol' : 'dolar';
    List<LastOperation> filteredOperations = [];
    return lastOperationsAsyncValue.when(
      data: (lastOperations) {
        if (fund.fundType == FundTypeEnum.corporate) {
          // reinvestmentOperations = LastOperation.filterByReInvestmentOperations(lastOperations);
          filteredOperations = lastOperations
              .where((element) =>
                  element.enterprisePreInvestment?.currency == selectedCurrency)
              .toList();

          lastOperations = filteredOperations;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (fund.fundType == FundTypeEnum.corporate) ...[
              const SwitchMoney(
                switchHeight: 30,
                switchWidth: 67,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            GraphicContainer(fund: fund),
            const SizedBox(height: 10),
            if (lastOperations.isNotEmpty &&
                fund.fundType == FundTypeEnum.corporate) ...[
              LastOperationsSlider(
                lastOperations: lastOperations,
                fund: fund,
              ),
              const SizedBox(height: 10),
            ],
            const ReinvestmentSlider(
              isV2: true,
            ),

            // if (reinvestmentOperations.isNotEmpty && fund.fundType == FundTypeEnum.corporate) ...[
            //   ReInvestmentSlider(
            //     operations: reinvestmentOperations,
            //   ),
            //   const SizedBox(height: 10),
            // ],
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
      loading: () => const SizedBox(
        height: 450,
        child: Center(
          child: CircularProgressIndicator(),
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

class LastOperationsSlider extends ConsumerStatefulWidget {
  final List<LastOperation> lastOperations;
  final FundEntity fund;

  const LastOperationsSlider({
    Key? key,
    required this.lastOperations,
    required this.fund,
  }) : super(key: key);

  @override
  ContainerLastOperationsState createState() => ContainerLastOperationsState();
}

class ContainerLastOperationsState extends ConsumerState<LastOperationsSlider> {
  int _currentIndex = 0;

  Widget _buildSliderWidget(LastOperation operation) {
    switch (operation.enterprisePreInvestment?.status) {
      case 'draft':
        return SliderDraft(
          amountNumber: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          isReInvestment:
              operation.enterprisePreInvestment?.isReInvestment ?? false,
          onTap: () => showDraftModal(
            context,
            amountNumber:
                operation.enterprisePreInvestment?.amount.toInt() ?? 0,
            isReinvest:
                operation.enterprisePreInvestment?.isReInvestment ?? false,
            profitability:
                operation.enterprisePreInvestment?.rentability?.toInt() ?? 0,
            termMonth: operation.enterprisePreInvestment?.deadline ?? 0,
            uuid: operation.enterprisePreInvestment?.uuidPreInvestment ?? '',
            moneyIcon: true,
            cardSend: false,
            statusUp: false,
            currency: operation.enterprisePreInvestment?.currency ?? '',
            fund: widget.fund,
          ),
        );
      case 'pending':
        if (operation.enterprisePreInvestment?.isReInvestment == true &&
                operation.enterprisePreInvestment?.actionStatus ==
                    ActionStatusEnum.defaultReInvestment ||
            operation.enterprisePreInvestment?.actionStatus ==
                ActionStatusEnum.defaultReInvestment.toLowerCase()) {
          return ReinvestmentPendingSlider(
            amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
            fundName: widget.fund.name,
          );
        }
        return ToValidateSlider(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: widget.fund.name,
        );
      case 'in_process':
        return ToValidateSlider(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: widget.fund.name,
        );

      case 'active':
        return SliderInCourse(
          amount: operation.enterprisePreInvestment?.amount.toInt() ?? 0,
          fundName: widget.fund.name,
          onPressed: () {},
        );

      default:
        return Text(
            'Un widget vacío para ${operation.enterprisePreInvestment?.status} no manejado');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LastOperation> filteredOperations = widget.lastOperations;

    if (filteredOperations.length > 15) {
      filteredOperations = filteredOperations.sublist(0, 15);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: TextPoppins(
            text: 'Mis inversiones recientes',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            align: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        CarouselSlider(
          items: filteredOperations
              .map((operation) => _buildSliderWidget(operation))
              .toList(),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: filteredOperations.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = entry.key;
                  //controller move
                });
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SliderInCourse extends ConsumerWidget {
  final int amount;
  final String fundName;
  final VoidCallback? onPressed;
  const SliderInCourse({
    super.key,
    required this.amount,
    required this.onPressed,
    required this.fundName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundLight = 0xffD6F6FF;
    const backgroundDark = 0xff08273F;
    return Stack(
      children: [
        Container(
          width: 330,
          height: 96,
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                AmountInvestment(
                  amount: amount,
                  fundName: fundName,
                ),
                const SizedBox(height: 1),
                const SliderBar(
                  image: 'assets/images/money_wings_19.png',
                  toValidate: false,
                ),
              ],
            ),
          ),
        ),
        const LabelInCourseState(
          label: "📉 Inversión en curso",
        ),
      ],
    );
  }
}

class ToValidateSlider extends ConsumerWidget {
  final int amount;
  final String fundName;
  const ToValidateSlider({
    super.key,
    required this.amount,
    required this.fundName,
  });

  void contact() async {
    var whatsappNumber = "51952484612";
    var whatsappMessage = "Hola";
    var whatsappUrlAndroid = Uri.parse(
      "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}",
    );
    var whatsappUrlIphone =
        Uri.parse("https://wa.me/$whatsappNumber?text=$whatsappMessage");

    if (defaultTargetPlatform == TargetPlatform.android) {
      await launchUrl(whatsappUrlAndroid);
    } else {
      await launchUrl(whatsappUrlIphone);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void contact() async {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.contactAdviser,
        parameters: {
          "amount": amount.toString(),
          "fundName": fundName,
        },
      );
      var whatsappNumber = "51952484612";
      var whatsappMessage = "Hola";
      var whatsappUrlAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}",
      );
      var whatsappUrlIphone =
          Uri.parse("https://wa.me/$whatsappNumber?text=$whatsappMessage");

      if (defaultTargetPlatform == TargetPlatform.android) {
        await launchUrl(whatsappUrlAndroid);
      } else {
        await launchUrl(whatsappUrlIphone);
      }
    }

    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundLight = 0xffD6F6FF;
    const backgroundDark = 0xff08273F;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.investmentPressValidate,
              parameters: {
                "amount": amount.toString(),
                "fundName": fundName,
              },
            ),
            showValidationModal(
              context,
              contact,
            ),
          },
          child: Container(
            width: 330,
            height: 96,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  AmountInvestment(
                    amount: amount,
                    fundName: fundName,
                  ),
                  const SizedBox(height: 1),
                  const SliderBar(
                    image: 'assets/images/money_bag.png',
                    toValidate: true,
                  ),
                  const SliderValidationText(),
                ],
              ),
            ),
          ),
        ),
        const LabelInCourseState(
          label: "👀 En revisión",
        ),
      ],
    );
  }
}

class SliderValidationText extends ConsumerWidget {
  const SliderValidationText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Validación',
          style: TextStyle(
            fontSize: 7,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 2),
        Icon(
          Icons.help_outline,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          size: 13,
        ),
      ],
    );
  }
}

class LabelInCourseState extends ConsumerWidget {
  final String label;
  const LabelInCourseState({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const labelLightContainer = 0xff0D3A5C;
    const labelDarkContainer = 0xffA2E6FA;
    const textDark = 0xff0D3A5C;
    const textLight = 0xffFFFFFF;
    return Positioned(
      right: 5,
      child: Container(
        height: 24,
        width: 95,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: isDarkMode
              ? const Color(labelDarkContainer)
              : const Color(labelLightContainer),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    isDarkMode ? const Color(textDark) : const Color(textLight),
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReinvestmentPendingSlider extends ConsumerWidget {
  final int amount;
  final String fundName;
  const ReinvestmentPendingSlider({
    super.key,
    required this.amount,
    required this.fundName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundLight = 0xffD6F6FF;
    const backgroundDark = 0xff08273F;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => () {},
          child: Container(
            width: 330,
            height: 96,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  AmountInvestment(
                    amount: amount,
                    fundName: fundName,
                  ),
                  const SizedBox(height: 1),
                  const SliderBar(
                    image: 'assets/images/money_bag.png',
                    toValidate: true,
                  ),
                  const ReinvestmentValidationText(),
                ],
              ),
            ),
          ),
        ),
        const LabelInCourseState(label: "📉 Inversión en curso"),
      ],
    );
  }
}

class ReinvestmentValidationText extends ConsumerWidget {
  const ReinvestmentValidationText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.sim_card_alert_outlined,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          size: 13,
        ),
        const SizedBox(width: 2),
        Text(
          'Tu reinversión esta a la espera de que finalice la inversión previa',
          style: TextStyle(
            fontSize: 7,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
