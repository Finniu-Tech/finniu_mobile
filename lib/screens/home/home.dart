import 'package:finniu/constants/colors.dart';
import 'package:finniu/models/user.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/home/widgets/cards.dart';
import 'package:finniu/screens/home/widgets/modals.dart';
import 'package:finniu/use_cases/ui/modals/complete_profile.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/providers/user_provider.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});
  bool show = true;

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: HookBuilder(
        builder: (context) {
          ref.watch(userProfileFutureProvider.future);
          // userProfile.then((user) {
          //   ref.read(userProfileNotifierProvider.notifier).updateFields(
          //         nickName: user.nickName,
          //         email: user.email,
          //         phoneNumber: user.phoneNumber,
          //       );
          //   if (showCompleteProfileModal(user)) {
          //     completeProfileDialog(context, ref);
          //   }
          // });
          // userProfile.when(
          //   data: (user) {
          //     ref.read(userProfileNotifierProvider.notifier).updateFields(
          //           nickName: user.nickName,
          //           email: user.email,
          //           phoneNumber: user.phoneNumber,
          //         );
          //     if (showCompleteProfileModal(user)) {
          //       completeProfileDialog(context, ref);
          //     }
          //   },
          //   error: (error, stackTrace) {},
          //   loading: () {},
          // );

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
                          "Hola ${ref.watch(userProfileNotifierProvider).nickName ?? ''}!",
                          // userProfile.when(data: (user) {
                          //   return 'Hola, ${user.nickName}!';
                          // }, error: (error, stackTrace) {
                          //   return 'Hola!';
                          // }, loading: () {
                          //   return 'Hola!';
                          // }),
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
        },
      ),
    );
  }
}
