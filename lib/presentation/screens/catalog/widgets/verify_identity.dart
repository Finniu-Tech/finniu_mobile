import 'package:finniu/domain/entities/user_profile_completeness.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/positiones_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showVerifyIdentity(
  BuildContext context,
  UserProfileCompleteness userCompletenessProfile, {
  Function()? redirect,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _BodyVerify(userCompletenessProfile: userCompletenessProfile, redirect: redirect),
  );
}

class _BodyVerify extends ConsumerWidget {
  final UserProfileCompleteness userCompletenessProfile;
  final Function()? redirect;

  const _BodyVerify({required this.userCompletenessProfile, this.redirect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('userCompletenessProfile: ${userCompletenessProfile.toJson()}');

    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    // final userProfile = ref.watch(userProfileNotifierProvider);
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    void navigate(UserProfileCompleteness userProfileCompleteness) {
      Navigator.popAndPushNamed(
        context,
        userProfileCompleteness.getNextStep() ?? '/v2/my_data',
        arguments: {
          "birthday": true,
        },
      );
      // Navigator.pushNamed(context, '/v2/my_data');
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          const LineTop(),

          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemRowValidate(
                  onTap: () {
                    // userCompletenessProfile.hasCompletePersonalData()
                    //     ? Navigator.pushNamed(context, '/v2/edit_personal_data')
                    //     : Navigator.pushNamed(context, '/v2/form_personal_data');
                  },
                  iconUrl: "assets/svg_icons/user_icon.svg",
                  isSelect: userCompletenessProfile.hasCompletePersonalData(),
                ),
                ItemRowValidate(
                  onTap: () {
                    // userCompletenessProfile.hasCompleteLocation()
                    //     ? Navigator.pushNamed(context, '/v2/edit_location_data')
                    //     : Navigator.pushNamed(context, '/v2/form_location');
                  },
                  iconUrl: "assets/svg_icons/map_icon_v2.svg",
                  isSelect: userCompletenessProfile.hasCompleteLocation(),
                ),
                ItemRowValidate(
                  onTap: () {
                    // userCompletenessProfile.hasCompleteOccupation()
                    //     ? Navigator.pushNamed(context, '/v2/edit_job_data')
                    //     : Navigator.pushNamed(context, '/v2/form_job');
                  },
                  iconUrl: "assets/svg_icons/bag_icon_v2.svg",
                  isSelect: userCompletenessProfile.hasCompleteOccupation(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextPoppins(
                  text: "Verifica tu identidad ",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 15,
                ),
                TextPoppins(
                  text: "Es importante completar tus datos para comenzar a invertir en Finniu sin problemas ",
                  fontSize: 14,
                  lines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonInvestment(
            text: "Completar",
            onPressed: () => navigate(userCompletenessProfile),
          ),
          const SizedBox(
            height: 10,
          ),
          if (userCompletenessProfile.hasRequiredData())
            UnderlinedButtonText(
              isDarkMode: isDarkMode,
              text: "En otro momento",
              onPressed: () {
                Navigator.pop(context);
              },
              underline: false,
            ),
          const SizedBox(
            height: 30,
          ),
          // TextButton(onPressed: () {}, child: Text('En otro momento'))
        ],
      ),
    );
  }
}

class ItemRowValidate extends ConsumerWidget {
  const ItemRowValidate({
    super.key,
    required this.iconUrl,
    required this.isSelect,
    required this.onTap,
  });
  final String iconUrl;
  final bool isSelect;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundSelect = 0xffA2E6FA;
    const int lineBackgroundSelect = 0xff0D3A5C;
    const int iconSelect = 0xff0D3A5C;
    const int iconNotSelectDark = 0xff686868;
    const int iconNotSelectLight = 0xffB3B3B3;
    const int backgroundDark = 0xff2B2B2B;
    const int backgroundLight = 0xffF5F4F4;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelect
                  ? const Color(backgroundSelect)
                  : isDarkMode
                      ? const Color(backgroundDark)
                      : const Color(backgroundLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: SvgPicture.asset(
              iconUrl,
              width: 20,
              height: 20,
              color: isSelect
                  ? const Color(iconSelect)
                  : isDarkMode
                      ? const Color(iconNotSelectDark)
                      : const Color(iconNotSelectLight),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: isSelect
                  ? const Color(lineBackgroundSelect)
                  : isDarkMode
                      ? const Color(backgroundDark)
                      : const Color(backgroundLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineTop extends ConsumerWidget {
  const LineTop({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int lineDark = 0xff333333;
    const int lineLight = 0xffE2E2E2;
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 5,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(lineDark) : const Color(lineLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
