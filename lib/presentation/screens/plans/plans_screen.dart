import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/presentation/providers/plan_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/plans/widgets/card.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanListScreen extends HookConsumerWidget {
  const PlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
      hideReturnButton: true,
      body: HookBuilder(
        builder: (context) {
          final planList = ref.watch(planListFutureProvider);
          return planList.when(
            data: (plans) {
              return PlanListBody(
                currentTheme: currentTheme,
                plans: plans,
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
          );
        },
      ),
    );
  }
}

class PlanListBody extends HookConsumerWidget {
  final SettingsProviderState currentTheme;
  final List<PlanEntity> plans;
  const PlanListBody({
    super.key,
    required this.currentTheme,
    required this.plans,
  });

  _launchWhatsApp(userName) async {
    var whatsappNumber = "51940206852";
    var whatsappMessage = "Hola, soy $userName deseo invertir.";
    var whatsappUrl = Uri.parse(
        "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}");
    print('whatsappUrl: $whatsappUrl');

    await launchUrl(whatsappUrl);
  }

  @override
  Widget build(BuildContext context, ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 330,
              child: Text(
                'Nuestros planes de inversión',
                style: TextStyle(
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(currentTheme.isDarkMode ? secondary : primaryLight),
                    ),
                  ),
                  onPressed: () {
                    _launchWhatsApp(userProfile.nickName);
                  },
                  child: const Text(
                    "Quiero conversar",
                    style: TextStyle(
                      color: Color(primaryDark),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(primaryDark),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ExpandableCard(
                      image: plans[index].imageUrl ??
                          'assets/investment/billsmoney.png',
                      textTiledCard: plans[index].name,
                      textPercentage: '${plans[index].twelveMonthsReturn}% ',
                      textDeclaration: '8%',
                      textinvestment: 'S/${plans[index].minAmount}',
                      textContainer: plans[index].description ?? '',
                      planUuid: plans[index].uuid,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
