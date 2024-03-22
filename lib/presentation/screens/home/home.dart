import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/infrastructure/repositories/investment_repository.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/empty_message.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/switch.dart';
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
        backgroundColor: Color(currentTheme.isDarkMode ? backgroundColorDark : whiteText),
        bottomNavigationBar: const BottomNavigationBarHome(),
        body: HookBuilder(
          builder: (context) {
            final userProfile = ref.watch(userProfileFutureProvider);

            return userProfile.when(
              data: (profile) {
                return HomeBody(currentTheme: currentTheme, userProfile: profile);
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
        print('hasCompletedOnboarding: $hasCompletedOnboarding');
        if (hasCompletedOnboarding == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/onboarding_questions_start');
          });
        }
        return null;
      },
      [],
    );

    final isSoles = ref.watch(isSolesStateProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 70),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    settingsDialog(context, ref);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularPercentAvatarWidget(),
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
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  child: Image.asset(
                    'assets/images/logo_small.png',
                    width: 60,
                    height: 60,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            HookBuilder(
              builder: (context) {
                final homeReport = ref.watch(homeReportProviderV2);

                return homeReport.when(
                  data: (data) {
                    var reportSoles = data.solesBalance;
                    var reportDolar = data.dolarBalance;
                    var homeReport = isSoles ? data.solesBalance : data.dolarBalance;
                    if (reportSoles.totalBalance == 0 && reportDolar.totalBalance == 0) {
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
// const SizedBox(
//   height: 15,
// ),

            const SizedBox(
              height: 15,
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.8,
              color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
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
  ConsumerState<PendingInvestmentCardWidget> createState() => PendingInvestmentCardWidgetState();
}

class PendingInvestmentCardWidgetState extends ConsumerState<PendingInvestmentCardWidget> {
  // bool hasInvestmentInProcess = false;
  bool isLoading = false;
  PreInvestmentForm? preInvestmentForm;

  @override
  Widget build(BuildContext context) {
    final gqlClient = ref.watch(gqlClientProvider).value;
    final userProfileProvider = ref.watch(userProfileFutureProvider).value;
    final hasPreInvestmentState = ref.watch(hasPreInvestmentProvider);

    void checkInvestmentProcess() {
      setState(() {
        isLoading = true;
      });
      InvestmentRepository().userHasInvestmentInProcess(client: gqlClient!).then(
            (success) => setState(() {
              ref.read(hasPreInvestmentProvider.notifier).state = success;
              if (success) {
                InvestmentRepository()
                    .getLastPreInvestment(
                  client: gqlClient,
                  email: userProfileProvider!.email!,
                )
                    .then((value) {
                  setState(() {
                    preInvestmentForm = value;
                    isLoading = false;
                  });
                });
              } else {
                isLoading = false;
              }
            }),
          );
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
    } else if (hasPreInvestmentState) {
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

class PendingInvestmentCard extends HookConsumerWidget {
  const PendingInvestmentCard({
    super.key,
    required this.currentTheme,
    required this.preInvestmentForm,
    required this.checkInvestmentProcess,
  });
  final currentTheme;
  final PreInvestmentForm preInvestmentForm;
  final void Function() checkInvestmentProcess;
  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 140,
      width: 330,
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          width: 1,
          color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //ROUNDED CONTAINER with purple background
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff9381FF),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Tienes una inversión pendiente",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '¿Deseas continuar con tu proceso de inversión?',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // outline button with an x icon and text "descartar"
              ElevatedButton.icon(
                icon: Icon(Icons.close, color: Colors.red),
                style: ElevatedButton.styleFrom(
                  foregroundColor: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                  backgroundColor: Colors.transparent,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () {
                  // here we discard the preinvestment
                  InvestmentRepository()
                      .discardPreInvestment(
                    client: ref.watch(gqlClientProvider).value!,
                    preInvestmentUUID: preInvestmentForm.uuid!,
                  )
                      .then((value) {
                    if (value) {
                      //call here again to check if there is a preinvestment
                      checkInvestmentProcess();
                    }
                  });
                },
                label: Text(
                  "Descartar",
                  style: TextStyle(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.check, color: Colors.green),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () async {
                  final preInvestment = PreInvestmentEntity(
                    uuid: preInvestmentForm.uuid!,
                    amount: preInvestmentForm.amount,
                    bankAccountTypeUuid: preInvestmentForm.bankAccountTypeUuid,
                    deadLineUuid: preInvestmentForm.deadLineUuid,
                    planUuid: preInvestmentForm.planUuid,
                    coupon: preInvestmentForm.coupon,
                  );

                  final inputCalculator = CalculatorInput(
                    amount: preInvestmentForm.amount,
                    months: preInvestmentForm.months!,
                    coupon: preInvestmentForm.coupon,
                    currency: preInvestmentForm.currency,
                  );

                  final calculatorResult = await ref.watch(
                    calculateInvestmentFutureProvider(
                      inputCalculator,
                    ).future,
                  );

                  Navigator.pushNamed(
                    context,
                    '/investment_step2',
                    arguments: PreInvestmentStep2Arguments(
                      plan: calculatorResult.plan!,
                      preInvestment: preInvestment,
                      resultCalculator: calculatorResult,
                    ),
                  );
                },
                label: Text(
                  "Continuar",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SimulationCardWidget extends StatelessWidget {
  const SimulationCardWidget({
    super.key,
    required this.currentTheme,
  });

  final SettingsProviderState currentTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      // height: ,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxWidth: 330, maxHeight: 147),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLightAlternative)
                    : const Color(primaryLightAlternative),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 144,
                width: 141,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/home/person.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 320,
                height: 147,
                padding: const EdgeInsets.only(
                  left: 60,
                  top: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Simula tu inversión aquí",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(primaryDark),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Descubre como simular el",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(grayText2),
                      ),
                    ),
                    Text(
                      "retorno de tu inversión",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(grayText2),
                      ),
                    ),
                    CustomButtonRoundedDark(
                      pushName: '/calculator_tool',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineReportHomeWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;
  final double totalPlans;
  final bool isSoles;

  const LineReportHomeWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
    required this.totalPlans,
    required this.isSoles,
  });

  @override
  _LineReportHomeWidgetState createState() => _LineReportHomeWidgetState();
}

class _LineReportHomeWidgetState extends ConsumerState<LineReportHomeWidget> {
  final List<String> _darkImages = [
    "assets/reports/night/step_1.png",
    "assets/reports/night/step_3.png",
    "assets/reports/night/step_3.png",
    "assets/reports/night/step_4.png",
    "assets/reports/night/step_5.png",
    "assets/reports/night/step_6.png",
  ];
  final List<String> _lightImages = [
    "assets/reports/light/step_1.png",
    "assets/reports/light/step_2.png",
    "assets/reports/light/step_3.png",
    "assets/reports/light/step_4.png",
    "assets/reports/light/step_5.png",
    "assets/reports/light/step_6.png",
  ];
  int _currentPageIndex = 0;
  Timer? _timer;
  List<String>? images;

  @override
  void initState() {
    super.initState();
    // final settings = ref.watch(settingsNotifierProvider);
    // images = ref.watch(settingsNotifierProvider).isDarkMode
    //     ? _darkImages
    //     : _lightImages;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_currentPageIndex < 5) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final theme = ref.watch(settingsNotifierProvider);
    final images = theme.isDarkMode ? _darkImages : _lightImages;
    final String moneySymbol = widget.isSoles ? 'S/' : '\$';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  'Resumen de mis inversiones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                  ),
                ),
                const Spacer(),
                const SwitchMoney(
                  switchHeight: 34,
                  switchWidth: 67,
                )
              ],
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            ...images.map((image) {
              int index = images.indexOf(image);
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: index == _currentPageIndex ? 1.0 : 0.0,
                child: Image.asset(
                  image,
                  // height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              );
            }).toList(),
            Positioned(
              top: 30,
              left: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // width: 130,
                    height: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$moneySymbol ${widget.initialAmount.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              '$moneySymbol ${widget.finalAmount.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Dinero total',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10,
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              'Intereses generados',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10,
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 125,
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.totalPlans.toInt()} ${widget.totalPlans.toInt() == 1 ? "plan" : "planes"}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                          ),
                        ),
                        Text(
                          'Mis inversiones en Curso',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Alinear widgets en el centro horizontalmente
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryDark),
                  ),
                  shape: BoxShape.circle,
                  color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryLight),
                ),
                // Si desea agregar un icono dentro del círculo
              ),
              const SizedBox(width: 5), // Separación entre el círculo y el texto
              Text(
                'Dinero invertido',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(primaryDark)),
                  shape: BoxShape.circle,
                  color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(secondary),
                ),
                // Si desea agregar un icono dentro del círculo
              ),
              // Separación entre el círculo y el texto
              const SizedBox(width: 5),
              Text(
                'Intereses generados',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/plan_list');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/square.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Planes',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/process_investment');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/dollar.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Mis inversiones',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/transfers');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/transferences.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Transferencias',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
