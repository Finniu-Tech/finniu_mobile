import 'dart:ui';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/home/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home/widgets/our_investment_funds.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/all_investment_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/notification_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreenV2 extends HookConsumerWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0.0,
          backgroundColor: Color(
            currentTheme.isDarkMode
                ? backgroundColorDark
                : scaffoldLightGradientPrimary,
          ),
          leading: Image.asset(
            'assets/images/logo_small.png',
            width: 80,
            height: 80,
            color: currentTheme.isDarkMode
                ? const Color(whiteText)
                : const Color(blackText),
          ),
          title: Text(
            'Hola, ${userProfile.nickName ?? ''}!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(primaryDark),
            ),
          ),
          actions: const [
            NotificationButton(),
            ProfileButton(),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        backgroundColor:
            Color(currentTheme.isDarkMode ? backgroundColorDark : whiteText),
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

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(scaffoldLightGradientPrimary),
              Color(scaffoldLightGradientSecondary),
            ],
            stops: [0.4, 0.6],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: currentTheme.isDarkMode
                    ? const Color(backgroundColorDark)
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
                        onPressed: () {},
                      ),
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
              // child: FundHomeSection(),
              child: OurInvestmentFunds(),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home_home'),
              child: const Text('Ir a home normal'),
            ),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/catalog'),
                child: const Text('Ver Catalogo de Widgets')),
          ],
        ),
      ),
    );
  }
}
