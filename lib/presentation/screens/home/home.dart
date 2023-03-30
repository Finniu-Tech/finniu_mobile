import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/cards.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var hasCompletedOnboarding=true;
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
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            width: 111,
            height: 82,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                currentTheme.isDarkMode
                    ? "assets/images/logo_finniu_home_dark.png"
                    : "assets/images/logo_finniu_home.png",
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 250,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hola ${userProfile.nickName ?? ''}!",
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
              const Expanded(
                child: SizedBox.shrink(),
              ),
              SizedBox(
                child: SizedBox(
                  width: 24,
                  height: 23.84,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home_notification');
                    },
                    child: Container(
                      child: Icon(
                        CupertinoIcons.bell,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              InkWell(
                onTap: () {
                  settingsDialog(context, ref);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: CircularPercentAvatarWidget(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Multiplica tu dinero con nosotros!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
              ),
            ),
          ),
          const Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: CardTable(),
          ),
          // SizedBox(
          //   height: 40,
          // ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 3,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(primaryDark),
                  width: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: currentTheme.isDarkMode
                      ? const Color(secondary)
                      : const Color(primaryLight),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
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
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.2,
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
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(grayText2),
                        ),
                      ),
                      Text(
                        "retorno de tu inversión",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(grayText2),
                        ),
                      ),
                      CustomButtonRoundedDark(
                        pushName: "",
                      )
                    ],
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
