import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/image_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/verify_identity.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/header_investment.dart';
import 'package:finniu/presentation/screens/fund_detail/widgets/containers.dart';
import 'package:finniu/utils/strings.dart';
import 'package:finniu/widgets/analytics.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class FundDetailScreen extends ConsumerWidget {
  const FundDetailScreen({super.key, required this.fund});
  final FundEntity fund;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final backgroundColor = isDarkMode ? fund.getHexDetailColorDark() : fund.getHexDetailColorLight();
    return AnalyticsAwareWidget(
      screenName: 'Fund Detail Screen: ${fund.name}',
      child: CustomLoaderOverlay(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          body: FundDetailBody(
            fund: fund,
            isDarkMode: isDarkMode,
          ),
        ),
      ),
    );
  }
}

class FundDetailBody extends ConsumerWidget {
  final FundEntity fund;
  final bool isDarkMode;
  const FundDetailBody({
    super.key,
    required this.fund,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        HeaderInvestment(
          containerColor: isDarkMode ? fund.getHexDetailColorDark() : fund.getHexDetailColorLight(),
          iconColor: isDarkMode ? fund.getHexDetailColorSecondaryDark() : fund.getHexDetailColorSecondaryLight(),
          textColor: isDarkMode ? whiteText : blackText,
          urlIcon: fund.iconUrl!,
          urlImageBackground: fund.backgroundImageUrl!,
          textTitle: fund.name,
        ),
        ScrollBody(
          fund: fund,
        ),
        const SizedBox(height: 10),
        ButtonInvestment(
          text: fund.fundType == FundTypeEnum.corporate ? 'Quiero invertir' : 'Quiero simular',
          onPressed: () async {
            context.loaderOverlay.show();
            // final userProfileCompleteness = await ref.read(userProfileCompletenessProvider.future);

            // if (!userProfileCompleteness.hasCompleteProfile()) {

            if (fund.fundType == FundTypeEnum.corporate) {
              Navigator.pushNamed(
                context,
                '/v2/investment/step-1',
                arguments: {'fund': fund},
              );
            } else {
              Navigator.pushNamed(
                context,
                '/v2/aggro-investment',
                arguments: {'fund': fund},
              );
            }

            context.loaderOverlay.hide();
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ScrollBody extends ConsumerWidget {
  final FundEntity fund;
  const ScrollBody({super.key, required this.fund});
  Future<dynamic> showBenefits(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => BodyModalBenefits(
        fundUUID: fund.uuid,
      ),
    );
  }

  static _getNumberFromString(String? item) {
    return getNumberFromString(item);
  }

  @override
  Widget build(BuildContext context, ref) {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bool isSoles = ref.watch(isSolesStateProvider);

    const int benefitsDark = 0xff0D3A5C;
    const int benefitsLight = 0xffA2E6FA;
    const int textDark = 0xff000000;
    const int textLight = 0xffFFFFFF;

    void onPressedBenefits() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(eventName: "click_benefits", parameters: {});
      showBenefits(context);
    }

    void onPressedInformation() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(eventName: "click_information", parameters: {});
      launchUrl(Uri.parse(fund.moreInfoDownloadUrl!));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          //add padding
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: fund.fundType == FundTypeEnum.corporate ? 'Descubre el portafolio' : 'Nuestro modelo de negocio',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageContainer(
                imageContainer: fund.mainImageUrl!,
                imageFullScreen: fund.mainImageHorizontalUrl!,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        (isDarkMode ? const Color(benefitsDark) : const Color(benefitsLight)),
                      ),
                    ),
                    onPressed: () => onPressedBenefits(),
                    child: const TextPoppins(
                      fontSize: 14,
                      text: "Ver beneficios",
                      textDark: textLight,
                      textLight: textDark,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        (isDarkMode ? const Color(benefitsLight) : const Color(benefitsDark)),
                      ),
                    ),
                    onPressed: () => onPressedInformation(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextPoppins(
                          fontSize: 14,
                          text: "Más información",
                          textDark: textDark,
                          textLight: textLight,
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.file_download_outlined,
                          size: 18,
                          color: isDarkMode ? const Color(textDark) : const Color(textLight),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (fund.fundType == FundTypeEnum.corporate) ...[
                    const SwitchMoney(
                      switchHeight: 34,
                      switchWidth: 67,
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (fund.fundType == FundTypeEnum.aggro) ...[
                Center(
                  child: BlueGoldContainer(
                    amount: isSoles ? fund.minAmountInvestmentPEN! : fund.minAmountInvestmentUSD!,
                  ),
                ),
              ],
              if (fund.fundType == FundTypeEnum.corporate) ...[
                Center(
                  child: RealStateContainer(
                    minAmount: _getNumberFromString(
                      isSoles ? fund.minAmountInvestmentPEN : fund.minAmountInvestmentUSD,
                    )!,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FundInfoSlider(
                  annualProfitability: getNumberFromString(fund.lastRentability),
                  totalInstallmentsAmount: getNumberFromString(fund.totalInstallmentsAmount),
                  totalAssetsUnderManagement: getNumberFromString(fund.assetUnderManagementAmount),
                  netWorthData: fund.netWorths,
                  netWorthAmount: getNumberFromString(fund.netWorthAmount),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
