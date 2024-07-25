import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/models/fund/aggro_investment_models.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/header_blue_gold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/row_items.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    final ValueNotifier<int?> installmentsState = useState(null);
    final ValueNotifier<int?> plotsState = useState(null);
    final ValueNotifier<double?> monthlyRevenueState = useState(null);
    final ValueNotifier<double?> totalInvestedState = useState(null);

    // const int backgroundColorDark = 0xff0E0E0E;
    // const int backgroundColorLight = 0xffFFFFFF;
    // const String title = "Fondo inversión agro \ninmobiliaria";
    String title = fund.name;
    // int titleColorDark = fund.getHexDetailColorSecondaryDark();
    // int titleColorLight = fund.getHexDetailColorSecondaryLight();
    const int titleColorDark = 0xffA2E6FA;
    const int titleColorLight = 0xff0D3A5C;
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UpperSectionWidget(
              title: title,
              titleColorDark: titleColorDark,
              titleColorLight: titleColorLight,
              installments: installmentsState.value,
              plots: plotsState.value,
              monthlyRevenue: monthlyRevenueState.value,
              totalInvestedAmount: totalInvestedState.value,
            ),
            const SizedBox(height: 20),
            BottomSection(
              fund: fund,
              installments: installmentsState,
              plots: plotsState,
              monthlyRevenue: monthlyRevenueState,
              totalInvestedAmount: totalInvestedState,
            ),
          ],
        ),
      ),
    );
  }
}

class UpperSectionWidget extends StatelessWidget {
  final String title;
  final int titleColorDark;
  final int titleColorLight;
  final int? installments;
  final int? plots;
  final double? monthlyRevenue;
  final double? totalInvestedAmount;

  const UpperSectionWidget({
    super.key,
    required this.title,
    required this.titleColorDark,
    required this.titleColorLight,
    required this.installments,
    required this.plots,
    required this.monthlyRevenue,
    required this.totalInvestedAmount,
  });

  @override
  Widget build(BuildContext context) {
    // const int backgroundColorDark = 0xff0E0E0E;
    // const int backgroundColorLight = 0xffFFFFFF;
    // const int titleColorDark = 0xffA2E6FA;
    // const int titleColorLight = 0xff0D3A5C;
    return SizedBox(
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
              Expanded(
                  child: AmountRow(
                totalInvestedAmount: totalInvestedAmount,
              )),
              SizedBox(width: 20),
              Expanded(
                child: SelectedItems(
                  installment: installments,
                  plots: plots,
                  monthly: monthlyRevenue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSection extends HookConsumerWidget {
  final FundEntity fund;
  ValueNotifier<int?> installments;
  ValueNotifier<int?> plots;
  ValueNotifier<double?> monthlyRevenue;
  ValueNotifier<double?> totalInvestedAmount;
  final quoteNumberController = useTextEditingController();
  final parcelNumberController = useTextEditingController();
  final originFundsController = useTextEditingController();

  BottomSection({
    super.key,
    required this.fund,
    required this.installments,
    required this.plots,
    required this.monthlyRevenue,
    required this.totalInvestedAmount,
  });
  void calculateInvestment(String quote, String parcel, WidgetRef ref, BuildContext ctx) async {
    if (quote.isEmpty || parcel.isEmpty) {
      return;
    }
    ctx.loaderOverlay.show();

    int quoteNumber = _getNumberFromString(quote)!;
    int parcelNumber = _getNumberFromString(parcel)!;

    installments.value = quoteNumber;
    plots.value = parcelNumber;
    // monthlyRevenue.value = (int.parse(quoteNumber) * int.parse(parcelNumber)).toInt();\
    final CalculateAggroInvestmentInput input = CalculateAggroInvestmentInput(
      numberParcel: parcelNumber,
      numberInstallments: quoteNumber,
      uuid: fund.uuid,
    );

    final CalculateAggroInvestmentResponse calculateResponse =
        await ref.read(calculateAggroFutureProvider(input).future);

    if (calculateResponse.success == false) {
      ctx.loaderOverlay.hide();

      CustomSnackbar.show(
        ctx,
        calculateResponse.messages?[0].message ?? 'Ocurrio un error',
        'error',
      );
      return;
    }
    monthlyRevenue.value = calculateResponse.parcelMonthly;

    totalInvestedAmount.value = calculateResponse.parcelMonthly * quoteNumber;

    ctx.loaderOverlay.hide();
  }

  int? _getNumberFromString(String? item) {
    if (item != null) {
      return int.parse(item.split(' ')[0]);
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      //rouded border
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
              items: const [
                '2 cuotas',
                '6 cuotas',
                '12 cuotas',
              ],
              callbackOnChange: (value) async {
                quoteNumberController.text = value;
                // installments.value = int.parse((value).split(' ')[0]);
                installments.value = _getNumberFromString(value);
                if (quoteNumberController.text.isNotEmpty && parcelNumberController.text.isNotEmpty) {
                  calculateInvestment(quoteNumberController.text, parcelNumberController.text, ref, context);
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
              items: const [
                '2 parcelas',
                '3 parcelas',
                '12 parcelas',
              ],
              callbackOnChange: (value) async {
                parcelNumberController.text = value;
                plots.value = _getNumberFromString(value);
                if (quoteNumberController.text.isNotEmpty && parcelNumberController.text.isNotEmpty) {
                  calculateInvestment(quoteNumberController.text, parcelNumberController.text, ref, context);
                }
              },
              textEditingController: parcelNumberController,
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
          const SizedBox(
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
          const SizedBox(
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
