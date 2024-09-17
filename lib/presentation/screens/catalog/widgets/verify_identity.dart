import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showVerifyIdentity(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const _BodyVerify(),
  );
}

class _BodyVerify extends ConsumerWidget {
  const _BodyVerify();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userProfile = ref.watch(userProfileNotifierProvider);
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    void navigate() {
      Navigator.pushNamed(context, '/v2/my_data');
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const LineTop(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ItemRowValidate(
                onTap: () {
                  userProfile.completePersonalData()
                      ? Navigator.pushNamed(context, '/v2/edit_personal_data')
                      : Navigator.pushNamed(context, '/v2/form_personal_data');
                },
                iconUrl: "assets/svg_icons/user_icon.svg",
                isSelect: userProfile.completePersonalData(),
              ),
              const SizedBox(
                width: 20,
              ),
              ItemRowValidate(
                onTap: () {
                  userProfile.completeLocationData()
                      ? Navigator.pushNamed(context, '/v2/edit_location_data')
                      : Navigator.pushNamed(context, '/v2/form_location');
                },
                iconUrl: "assets/svg_icons/map_icon_v2.svg",
                isSelect: userProfile.completeLocationData(),
              ),
              const SizedBox(
                width: 20,
              ),
              ItemRowValidate(
                onTap: () {
                  userProfile.completeJobData()
                      ? Navigator.pushNamed(context, '/v2/edit_job_data')
                      : Navigator.pushNamed(context, '/v2/form_job');
                },
                iconUrl: "assets/svg_icons/bag_icon_v2.svg",
                isSelect: userProfile.completeJobData(),
              ),
              const SizedBox(
                width: 20,
              ),
              ItemRowValidate(
                onTap: () {
                  userProfile.completeAboutData()
                      ? Navigator.pushNamed(context, '/v2/edit_about_me')
                      : Navigator.pushNamed(context, '/v2/form_about_me');
                },
                iconUrl: "assets/svg_icons/user_icon_v2.svg",
                isSelect: userProfile.completeAboutData(),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: "Verifica tu identidad ",
                  fontSize: 20,
                  isBold: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextPoppins(
                  text:
                      "Es importante completar tus datos para comenzar a invertir en Finniu sin problemas ",
                  fontSize: 14,
                  lines: 2,
                ),
              ],
            ),
          ),
          ButtonInvestment(
            text: "Completar",
            onPressed: () => navigate(),
          ),
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
            padding: const EdgeInsets.all(5.0),
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
                  ? const Color(backgroundSelect)
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
