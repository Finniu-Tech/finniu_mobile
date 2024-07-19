import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/header_blue_gold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/row_items.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentAggroProcessScreen extends ConsumerWidget {
  final FundEntity fund;
  const InvestmentAggroProcessScreen({super.key, required this.fund});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomLoaderOverlay(
      child: ScaffoldInvestment(
        isDarkMode: currentTheme.isDarkMode,
        backgroundColor: currentTheme.isDarkMode ? const Color(scaffoldBlackBackground) : const Color(whiteText),
        // currentTheme.isDarkMode ? Color(fund.getHexDetailColorDark()) : Color(fund.getHexDetailColorLight()),
        body: AggroBody(
          fund: fund,
        ),
      ),
    );
  }
}

class AggroBody extends HookConsumerWidget {
  final FundEntity fund;
  const AggroBody({
    super.key,
    required this.fund,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const String title = "Fondo inversión agro \ninmobiliaria";
    const int titleColorDark = 0xffA2E6FA;
    const int titleColorLight = 0xff0D3A5C;
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UpperSectionWidget(),
            SizedBox(height: 20),
            BottomSection(fund: fund),
          ],
        ),
      ),
    );
  }
}

class UpperSectionWidget extends StatelessWidget {
  const UpperSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const String title = "Fondo inversión agro \ninmobiliaria";
    const int titleColorDark = 0xffA2E6FA;
    const int titleColorLight = 0xff0D3A5C;
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            HeaderContainer(),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TextPoppins(
                text: title,
                fontSize: 20,
                isBold: true,
                lines: 2,
                textDark: titleColorDark,
                textLight: titleColorLight,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: AmountRow()),
                SizedBox(width: 20),
                Expanded(
                  child: SelectedItems(),
                ),
              ],
            ),
          ],
        ));
  }
}

class BottomSection extends HookConsumerWidget {
  final FundEntity fund;

  void calculateInvestment(String quoteNumber, String parcelNumber) {}

  const BottomSection({super.key, required this.fund});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteNumberController = TextEditingController();
    final parcelNumberController = TextEditingController();
    final originFundsController = TextEditingController();
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      //rouded border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color(fund.getHexDetailColorLight()),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: CustomSelectButton(
              items: [
                '2 cuotas',
                '6 cuotas',
                '12 cuotas',
              ],
              // asyncItems: (String filter) async {
              //   final response = await deadLineFuture;
              //   return response.map((e) => e.name).toList();
              // },
              callbackOnChange: (value) async {
                quoteNumberController.text = value;
                if (quoteNumberController.text.isNotEmpty && parcelNumberController.text.isNotEmpty) {
                  calculateInvestment(quoteNumberController.text, parcelNumberController.text);
                }
              },
              textEditingController: quoteNumberController,
              labelText: "Cantidad de Cuotas",
              hintText: "Seleccione numero de cuotas",
              enabledFillColor: isDarkMode ? Color(fund.getHexDetailColorDark()) : Color(fund.getHexDetailColorLight()),
              unselectedItemColor: isDarkMode
                  ? Color(fund.getHexDetailColorSecondaryDark())
                  : Color(fund.getHexDetailColorSecondaryLight()),
              dropdownBackgroundColor: isDarkMode
                  ? Color(fund.getHexDetailColorDark())
                  : Color(
                      fund.getHexDetailColorLight(),
                    ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: CustomSelectButton(
              items: [
                '2 parcelas',
                '3 parcelas',
                '12 parcelas',
              ],
              // asyncItems: (String filter) async {
              //   final response = await deadLineFuture;
              //   return response.map((e) => e.name).toList();
              // },
              callbackOnChange: (value) async {
                quoteNumberController.text = value;
                if (quoteNumberController.text.isNotEmpty && parcelNumberController.text.isNotEmpty) {
                  calculateInvestment(quoteNumberController.text, parcelNumberController.text);
                }
              },
              textEditingController: quoteNumberController,
              labelText: "Cantidad de Parcelas",
              hintText: "Seleccione numero de parcelas",
              enabledFillColor: isDarkMode ? Color(fund.getHexDetailColorDark()) : Color(fund.getHexDetailColorLight()),
              unselectedItemColor: isDarkMode
                  ? Color(fund.getHexDetailColorSecondaryDark())
                  : Color(fund.getHexDetailColorSecondaryLight()),
              dropdownBackgroundColor: isDarkMode
                  ? Color(fund.getHexDetailColorDark())
                  : Color(
                      fund.getHexDetailColorLight(),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: CustomSelectButton(
              asyncItems: (String filter) async {
                // return OriginFoundsEnum.values.map((e) => OriginFoundsUtil.toReadableName(e)).toList();
                return OriginFoundsUtil.getReadableNames();
              },
              //   setState(() {
              //     widget.originFundsController.text = value;
              //     if (value != 'Otros') {
              //       widget.otherFundOriginController.clear();
              //     }
              //   });
              // },
              textEditingController: originFundsController,
              enabledFillColor: isDarkMode ? Color(fund.getHexDetailColorDark()) : Color(fund.getHexDetailColorLight()),
              labelText: "Origen de procedencia del dinero",
              hintText: "Seleccione el origen",
              unselectedItemColor: isDarkMode
                  ? Color(fund.getHexDetailColorSecondaryDark())
                  : Color(fund.getHexDetailColorSecondaryLight()),
              dropdownBackgroundColor: isDarkMode
                  ? Color(fund.getHexDetailColorDark())
                  : Color(
                      fund.getHexDetailColorLight(),
                    ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () async {
                showThanksInvestmentDialog(
                  context,
                  textTitle: 'Gracias por \nconfiar en Finniu!',
                  textTanks: 'Gracias por tu comprensión!',
                  textBody:
                      'Recuerda que tu solicitud de Inversion agroInmobiliaria sera derivada a un asesor del Proyecto, quien se contactara contigo en las proxima 24h.',
                  textButton: 'Ver mi progreso',
                  onPressed: () => {
                    Navigator.pushNamed(context, '/blue_gold_investment'),
                  },
                );
                // if (userProfile.hasRequiredData() == false) {
                //   completeProfileDialog(context, ref);
                //   return;
                // }
                // if (validate() == false) {
                //   return;
                // }

                // final deadLineUuid = DeadLineEntity.getUuidByName(
                //   widget.deadLineController.text,
                //   await deadLineFuture,
                // );

                // final originFund = widget.originFundsController.text;

                // final preInvestment = PreInvestmentForm(
                //   amount: int.parse(widget.amountController.text),
                //   deadLineUuid: deadLineUuid,
                //   coupon: widget.couponController.text,
                //   // planUuid: widget.plan.uuid,
                //   planUuid: 'test',
                //   currency: isSoles ? currencyNuevoSol : currencyDollar,
                //   bankAccountNumber: selectedBankAccount!.id,
                //   originFunds: OriginFunds(
                //     originFundsEnum: OriginFoundsUtil.fromReadableName(originFund),
                //     otherText: widget.otherFundOriginController.text,
                //   )
                //   // bankAccountNumber: widget.bankNumberController.text,
                //   ,
                // );
                // context.loaderOverlay.show();
                // final preInvestmentEntityResponse = await ref.watch(preInvestmentSaveProvider(preInvestment).future);

                // if (preInvestmentEntityResponse?.success == false) {
                //   context.loaderOverlay.hide();
                //   // CHECK HERE
                //   CustomSnackbar.show(
                //     context,
                //     preInvestmentEntityResponse?.error ?? 'Hubo un problema, intenta nuevamente',
                //     'error',
                //   );
                //   return;
                // } else {
                //   context.loaderOverlay.hide();
                //   ref
                //       .read(
                //         preInvestmentVoucherImagesPreviewProvider.notifier,
                //       )
                //       .state = [];
                //   ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
                //   Navigator.pushNamed(context, '/v2/investment/step-2');
                //   // Navigator.pushNamed(
                //   //     context,
                //   //     '/investment_step2',
                //   //     arguments: PreInvestmentStep2Arguments(
                //   //       plan: selectedPlan!,
                //   //       preInvestment: preInvestmentEntityResponse!.preInvestment!,
                //   //       resultCalculator: resultCalculator!,
                //   //     ),
                //   //   );
                // }
              },
              child: const Text(
                'Continuar',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
