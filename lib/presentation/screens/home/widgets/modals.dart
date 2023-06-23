import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void settingsDialog(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  final userProvider = ref.watch(userProfileNotifierProvider);
  final userBalanceReport = ref.watch(userProfileBalanceNotifierProvider);

  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (ctx) => Builder(builder: (BuildContext context) {
      return Dialog(
        insetAnimationDuration: const Duration(seconds: 1),
        insetAnimationCurve: Curves.easeInOutCubic,
        backgroundColor: themeProvider.isDarkMode
            ? const Color(primaryDark)
            : const Color(secondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350,
            minWidth: 350,
            maxHeight: 600,
            minHeight: 325,
          ),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 23,
                      width: 23,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: InkWell(
                        child: Icon(
                          size: 17,
                          Icons.close,
                          color: themeProvider.isDarkMode
                              ? const Color(primaryDark)
                              : const Color(primaryLight),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularPercentAvatarWidget(),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    ref
                                            .watch(userProfileNotifierProvider)
                                            .nickName ??
                                        '',
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 16,
                                      color: themeProvider.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                TextPoppins(
                                  text: 'Light mode',
                                  colorText: themeProvider.isDarkMode
                                      ? Colors.white.value
                                      : Colors.black.value,
                                  // colorText: ,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(width: 5),
                                FlutterSwitch(
                                  padding: 2,
                                  width: 35,
                                  height: 16,
                                  value: Preferences.isDarkMode,
                                  inactiveColor: const Color(primaryDark),
                                  activeColor: const Color(primaryLight),
                                  inactiveToggleColor:
                                      const Color(primaryLight),
                                  activeToggleColor: const Color(primaryDark),
                                  onToggle: (value) {
                                    Navigator.of(context).pop();
                                    value
                                        ? ref
                                            .read(settingsNotifierProvider
                                                .notifier)
                                            .setDarkMode()
                                        : ref
                                            .read(settingsNotifierProvider
                                                .notifier)
                                            .setLightMode();
                                    Preferences.isDarkMode = value;
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  ref
                                          .watch(userProfileNotifierProvider)
                                          .email ??
                                      '',
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 12,
                                    color: themeProvider.isDarkMode
                                        ? const Color(primaryLight)
                                        : const Color(grayText1),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            userBalanceReport.totalBalance.toString(),
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Total invertido",
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: themeProvider.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 60,
                        width: 2,
                        color: themeProvider.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            userBalanceReport.totalPlans.toString(),
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Planes invertidos",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: themeProvider.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/profile');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/icon_profile.png',
                            text: "Editar mi perfil",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/privacy');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/padlock.png',
                            text: "Privacidad",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/transfers');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/transferens.png',
                            text: "Mis transferencias",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/languages');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/lenguages.png',
                            text: "Lenguajes",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/help');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/questions.png',
                            text: "Ayuda",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pushNamed('/login_start');
                          },
                          child: ItemSetting(
                            image: 'assets/icons/sign_off.png',
                            text: "Cerrar sesión",
                            onTap: () {
                              ref.invalidate(authTokenProvider);
                              ref.invalidate(gqlClientProvider);
                              ref.invalidate(userProfileFutureProvider);
                              ref.invalidate(userProfileNotifierProvider);
                              // logout(ref);
                              Navigator.of(ctx).pushNamedAndRemoveUntil(
                                  '/login_start', (route) => false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }),
  );
}

class ItemSetting extends ConsumerWidget {
  late String _image;

  late String _text;

  Function? _onTap;

  ItemSetting({
    required String image,
    required String text,
    Function? onTap,
  }) {
    _image = image;
    _text = text;
    _onTap = onTap;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // SettingsProvider themeProvider = Provider.of<SettingsProvider>(context);
    return Row(
      children: [
        Container(
          width: 46,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDarkAlternative),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            child: Image.asset(
              _image,
              color: themeProvider.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLight),
              width: 18,
              height: 18,
            ),
            onTap: _onTap as void Function()?,
          ),
        ),
        const SizedBox(width: 10),
        Text(_text),
      ],
    );
  }
}

void completeProfileDialog(BuildContext ctx, WidgetRef ref) {
  String textDescription = '''
    Hola ${ref.watch(userProfileNotifierProvider).nickName}, recuerda que es muy importante tener todos tus
    datos completos en la sección Editar perfil para que puedas continuar con tu proceso de inversión con éxito.
  ''';
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  Future.delayed(
    const Duration(seconds: 1),
    () async {
      showModalBottomSheet(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
          ),
        ),
        elevation: 10,
        backgroundColor: themeProvider.isDarkMode
            ? const Color(primaryDark)
            : const Color(primaryLight),
        context: ctx,
        isDismissible: false,
        builder: (ctx) => SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.90,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 182,
                    height: 185,
                    child: Image.asset('assets/home/modal_info.png'),
                  ),
                  SizedBox(
                    width: 230,
                    child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : const Color(primaryDark),
                      ),
                      textDescription,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 132,
                      //   height: 46,
                      //   child: TextButton(
                      //     style: ButtonStyle(
                      //       backgroundColor: MaterialStateProperty.all<Color>(
                      //         themeProvider.isDarkMode
                      //             ? const Color(primaryDarkAlternative)
                      //             : const Color(0XFF68C3DE),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       Navigator.pop(ctx);
                      //       Preferences.showWelcomeModal = false;
                      //       // themeProvider.setShowWelcomeModal(false);
                      //     },
                      //     child: Text(
                      //       "Saltar",
                      //       style: TextStyle(
                      //         color: themeProvider.isDarkMode
                      //             ? Colors.white
                      //             : const Color(primaryDark),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 132,
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              themeProvider.isDarkMode
                                  ? const Color(buttonBackgroundColorDark)
                                  : const Color(primaryDark),
                            ),
                          ),
                          onPressed: () {
                            Preferences.showWelcomeModal = false;
                            // themeProvider.setShowWelcomeModal(false);
                            Navigator.pop(ctx);
                            Navigator.of(ctx).pushNamed('/profile');
                          },
                          child: Text(
                            "Completar",
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? const Color(primaryDark)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
