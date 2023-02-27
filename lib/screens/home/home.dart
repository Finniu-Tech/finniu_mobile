import 'package:finniu/constants/colors.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/models/user.dart';
import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/home/widgets/cards.dart';
import 'package:finniu/screens/home/widgets/modals.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/providers/user_provider.dart';

class HomeStart extends HookConsumerWidget {
  HomeStart({super.key});
  bool show = true;

  @override
  Widget build(BuildContext context, ref) {
    // print(userProfileData);
    // final userProvider = ref.watch(userNotifierProvider);
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    if (currentTheme.showWelcomeModal) {
      showWelcomeModal(context, ref);
    }
    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: HookBuilder(builder: (context) {
        final userAPI = ref.watch(userProvider);
        print('userAPI');
        print(userAPI);
        // final profileData = useQuery(
        //   QueryOptions(
        //     document: gql(
        //       QueryRepository.getUserProfile,
        //     ), // this is the query string you just created
        //     // variables: {
        //     //   'nRepositories': 50,
        //     // },
        //     pollInterval: const Duration(seconds: 10),
        //   ),
        // );
        // UserProfile userProfileData =
        //     UserProfile.fromJson(profileData.result.data?['userProfile']);
        // print('userProfileData');
        // print(userProfileData);
        // ref.read(userNotifierProvider).copyWith(
        //       firstName: userProfileData.firstName,
        //       lastName: userProfileData.lastName,
        //       email: userProfileData.email,
        //       nickName: userProfileData.nickName,
        //       phoneNumber: userProfileData.phoneNumber,
        //       hasCompletedOnboarding:
        //           userProfileData.hasCompletedOnboarding ?? false,
        //     );

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
                  SizedBox(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // 'Hola',
                        userAPI.when(data: (user) {
                          print('data');
                          print(user);
                          return 'Hola, ${user.nickName}!';
                        }, error: (error, stackTrace) {
                          print('error');
                          print(error);
                          return 'Hola!';
                        }, loading: () {
                          print('loading');
                          return 'Hola!';
                        }),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(primaryDark),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  SizedBox(
                    child: Container(
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
                      showSettingsDialog(context, ref);
                    },
                    child: SizedBox(
                      width: 41,
                      height: 43,
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/home/avatar.png'),
                      ),
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
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: const CardTable(),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              Spacer(),
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
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.9,
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
                          top: 20),
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
      }),
    );
  }
}
