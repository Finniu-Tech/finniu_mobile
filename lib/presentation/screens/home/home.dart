import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/presentation/providers/user_provider.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    // add flag to check if callback has already been added
    var hasPushedOnboarding = false;
    // final hasCompletedOnboarding = ref.watch(hasCompletedOnboardingProvider);
    var hasCompletedOnboarding = true;
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: HookBuilder(
        builder: (context) {
          final userProfile = ref.watch(userProfileFutureProvider);

          return userProfile.when(
            data: (profile) {
              if (hasCompletedOnboarding == false && !hasPushedOnboarding) {
                hasPushedOnboarding = true; // set flag to true
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed('/onboarding_questions_start');
                });
              }
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
    );
  }
}

class HomeBody extends ConsumerWidget {
  const HomeBody({
    super.key,
    required this.currentTheme,
    required this.userProfile,
  });

  final SettingsProviderState currentTheme;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context, ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),

              Row(children: [
                InkWell(
                  onTap: () {
                    settingsDialog(context, ref);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularPercentAvatarWidget(),
                  ),
                ),
                SizedBox(
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
              ]),
              const SizedBox(width: 30),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Resumen de mis inversiones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
              ),
              const LineReportHomeWidget(
                initialAmount: 550,
                finalAmount: 583,
                revenueAmount: 33,
              ),
              // const Flexible(
              //   flex: 10,
              //   fit: FlexFit.tight,
              //   child: CardTable(),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .end, // Alinear widgets en el centro horizontalmente
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryDark)
                              : const Color(primaryDark),
                        ),
                        shape: BoxShape.circle,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(primaryLight),
                      ),
                      // Si desea agregar un icono dentro del círculo
                    ),
                    const SizedBox(
                        width: 5), // Separación entre el círculo y el texto
                    Text(
                      'Dinero invertido',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(primaryDark)),
                        shape: BoxShape.circle,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(secondary),
                      ),
                      // Si desea agregar un icono dentro del círculo
                    ),
                    // Separación entre el círculo y el texto
                    const SizedBox(width: 5),
                    Text(
                      'Intereses generados',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: const Color(secondary)),
                    width: 98,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/my_investment');
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: const Color(secondary)),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: const Color(secondary)),
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
              SizedBox(
                width: 330,
                // height: ,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        constraints:
                            const BoxConstraints(maxWidth: 330, maxHeight: 147),
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
                          padding: EdgeInsets.only(
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
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineReportHomeWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;

  const LineReportHomeWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
  });

  @override
  _LineReportHomeWidgetState createState() => _LineReportHomeWidgetState();
}

class _LineReportHomeWidgetState extends ConsumerState<LineReportHomeWidget> {
  final List<String> _darkImages = [
    "assets/report_home/dark/step_1.png",
    "assets/report_home/dark/step_2.png",
    "assets/report_home/dark/step_3.png",
    "assets/report_home/dark/step_4.png",
  ];
  final List<String> _lightImages = [
    "assets/report_home/light/step_1.png",
    "assets/report_home/light/step_2.png",
    "assets/report_home/light/step_3.png",
    "assets/report_home/light/step_4.png",
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
        if (_currentPageIndex < 3) {
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
    return Stack(
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
            children: [
              Container(
                width: 122,
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'S/4050',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                    Text(
                      'Balance total',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2 planes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                    Text(
                      'Mis inversiones en Curso',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
