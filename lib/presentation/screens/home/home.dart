import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/infrastructure/repositories/investment_repository.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/empty_message.dart';
import 'package:finniu/presentation/screens/home/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/home/widgets/linear_report.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/presentation/screens/home/widgets/pending_investment_card.dart';
import 'package:finniu/presentation/screens/home/widgets/reinvestment_available_card.dart';
import 'package:finniu/presentation/screens/home/widgets/simulation_card.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/presentation/providers/user_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return PopScope(
      child: Scaffold(
        backgroundColor:
            Color(currentTheme.isDarkMode ? backgroundColorDark : whiteText),
        bottomNavigationBar: const BottomNavigationBarHome(),
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

    final isSoles = ref.watch(isSolesStateProvider);

    final themeProvider = ref.watch(settingsNotifierProvider);
    final userBalanceReport = ref.watch(userProfileBalanceNotifierProvider);
    final currency = ref.watch(isSolesStateProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);
    final settings = ref.read(settingsNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderInvestment(
              containerColor: aboutContainerBusinessColor,
              iconColor: aboutIconBusinessColor,
              textColor: aboutTextBusinessColor,
              urlIcon: 'assets/investment/business_loans_investment_icon.png',
              urlImageBackground: 'assets/backgroud/image-agro-backgroud.png',
              textTitle: 'Fondo prestamos empresariales',
            ),
            const SizedBox(height: 10),
            const HeaderInvestment(
              containerColor: aboutContainerAgroColor,
              iconColor: aboutIconAgroColor,
              textColor: aboutTextAgroColor,
              urlIcon: 'assets/investment/real_estate_agro_icon.png',
              urlImageBackground: 'assets/backgroud/backgroud_agro.png',
              textTitle: 'Fondo inversión agro inmobiliaria',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    settingsDialog(
                      context,
                      ref,
                      themeProvider,
                      userBalanceReport,
                      currency,
                      userProfile,
                      settings,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularPercentAvatarWidget(
                      userProfile.percentCompleteProfile ?? 0.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hola,${userProfile.nickName ?? ''}!",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  child: Image.asset(
                    'assets/images/logo_small.png',
                    width: 60,
                    height: 60,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ],
            ),
            const ReinvestmentSlider(),

            HookBuilder(
              builder: (context) {
                final homeReport = ref.watch(homeReportProviderV2);

                return homeReport.when(
                  data: (data) {
                    var reportSoles = data.solesBalance;
                    var reportDolar = data.dolarBalance;
                    var homeReport =
                        isSoles ? data.solesBalance : data.dolarBalance;
                    if (reportSoles.totalBalance == 0 &&
                        reportDolar.totalBalance == 0) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const Center(
                          child: EmptyReportMessage(),
                        ),
                      );
                    } else {
                      return LineReportHomeWidget(
                        initialAmount: homeReport.totalBalance,
                        finalAmount: homeReport.totalRevenue,
                        revenueAmount: homeReport.totalRevenue,
                        totalPlans: homeReport.totalPlans.toDouble(),
                        isSoles: isSoles,
                      );
                    }
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: Color(primaryDark),
                    ),
                  ),
                  error: (error, _) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: const Center(
                      child: EmptyReportMessage(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 15,
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.8,
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
            ),
            const SizedBox(
              height: 15,
            ),
            //card with outline blue border with transparent background and two buttons inside
            PendingInvestmentCardWidget(currentTheme: currentTheme),
            const SizedBox(
              height: 15,
            ),
            SimulationCardWidget(currentTheme: currentTheme),
            // const SizedBox(
            //   height: 15,
            // ),
          ],
        ),
      ),
    );
  }
}

class PendingInvestmentCardWidget extends StatefulHookConsumerWidget {
  const PendingInvestmentCardWidget({
    super.key,
    required this.currentTheme,
  });

  final SettingsProviderState currentTheme;

  @override
  ConsumerState<PendingInvestmentCardWidget> createState() =>
      PendingInvestmentCardWidgetState();
}

class PendingInvestmentCardWidgetState
    extends ConsumerState<PendingInvestmentCardWidget> {
  // bool hasInvestmentInProcess = false;
  bool isLoading = false;
  PreInvestmentForm? preInvestmentForm;

  @override
  Widget build(BuildContext context) {
    final gqlClient = ref.watch(gqlClientProvider).value;
    final userProfileProvider = ref.watch(userProfileFutureProvider).value;
    final hasPreInvestmentState = ref.watch(hasPreInvestmentProvider);

    void checkInvestmentProcess() {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
        InvestmentRepository()
            .userHasInvestmentInProcess(client: gqlClient!)
            .then(
          (success) {
            if (mounted) {
              setState(() {
                ref.read(hasPreInvestmentProvider.notifier).state = success;
                if (success) {
                  InvestmentRepository()
                      .getLastPreInvestment(
                    client: gqlClient,
                    email: userProfileProvider!.email!,
                  )
                      .then((value) {
                    if (mounted) {
                      setState(() {
                        preInvestmentForm = value;
                        isLoading = false;
                      });
                    }
                  });
                } else {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              });
            }
          },
        );
      }
    }

    useEffect(
      () {
        checkInvestmentProcess();
        return null;
      },
      [],
    );

    if (isLoading) {
      return const SizedBox(
        height: 135,
        width: 330,
        child: Center(
          child: CircularProgressIndicator(
            color: Color(primaryDark),
          ),
        ),
      );
    } else if (hasPreInvestmentState && preInvestmentForm != null) {
      return PendingInvestmentCard(
        currentTheme: widget.currentTheme,
        preInvestmentForm: preInvestmentForm!,
        checkInvestmentProcess: checkInvestmentProcess,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
