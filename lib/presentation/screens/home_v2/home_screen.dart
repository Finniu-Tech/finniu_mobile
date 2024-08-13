import 'dart:ui';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/feature_flag_entity.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/feature_flags_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/carrousel_slider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/our_investment_funds.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/all_investment_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/custom_app_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/show_draft_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/slider_draft.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/show_tour.dart';
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
        backgroundColor: Color(currentTheme.isDarkMode
            ? scaffoldBlackBackground
            : scaffoldLightGradientPrimary),
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
            Navigator.of(context)
                .pushReplacementNamed('/onboarding_questions_start');
          });
        }
        return null;
      },
      [],
    );
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showTourV2(context);
        });
        return null;
      },
      [],
    );

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentTheme.isDarkMode
                ? [
                    const Color(scaffoldBlackBackground),
                    const Color(backgroundColorNavbar)
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
                color: currentTheme.isDarkMode
                    ? const Color(scaffoldBlackBackground)
                    : const Color(scaffoldLightGradientPrimary),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: EnterpriseFundTitle(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GraphicContainer(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AllInvestmentButton(
                        text: 'Ver todas mis inversiones',
                        onPressed: () {
                          Navigator.pushNamed(context, '/v2/investment');
                        },
                      ),
                      const CarrouselSlider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const ContainerSliderDraft(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.close,
                        ),
                        label: Text("ver tour"),
                        onPressed: () => showTourV2(context),
                      )
                    ],
                  ),
                  renderNonInvestment
                      ? Positioned.fill(
                          child: IgnorePointer(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
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
                        )
                      : const SizedBox(),
                  renderNonInvestment
                      ? const Center(
                          child: NonInvestmentContainer(),
                        )
                      : const SizedBox(),
                ],
              ),
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
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/catalog'),
                child: const Text('Ver Catalogo de Widgets'),
              ),
            ],
          ],
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

  SliderDraftData({
    required this.uuid,
    required this.amountNumber,
    required this.isReinvest,
    required this.profitability,
    required this.termMonth,
    required this.moneyIcon,
    required this.cardSend,
    required this.statusUp,
  });
}

class ContainerSliderDraft extends ConsumerWidget {
  const ContainerSliderDraft({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SliderDraftData sliderDraftData = SliderDraftData(
      uuid: '123',
      amountNumber: 10000,
      isReinvest: false,
      profitability: 10,
      termMonth: 12,
      moneyIcon: true,
      cardSend: true,
      statusUp: true,
    );
    return SliderDraft(
      amountNumber: sliderDraftData.amountNumber,
      onTap: () => showDraftModal(
        context,
        amountNumber: sliderDraftData.amountNumber,
        isReinvest: sliderDraftData.isReinvest,
        profitability: sliderDraftData.profitability,
        termMonth: sliderDraftData.termMonth,
        uuid: sliderDraftData.uuid,
        moneyIcon: sliderDraftData.moneyIcon,
        cardSend: sliderDraftData.cardSend,
        statusUp: sliderDraftData.statusUp,
      ),
    );
  }
}
