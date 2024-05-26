import 'dart:convert';
import 'dart:io';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/accept_tems.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ReInvestmentStep2 extends ConsumerWidget {
  const ReInvestmentStep2({
    super.key,
    required this.plan,
    required this.reInvestment,
    required this.resultCalculator,
  });
  final PlanEntity plan;
  final ReInvestmentEntity reInvestment;
  final PlanSimulation resultCalculator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final args = ModalRoute.of(context)!.settings.arguments as ReInvestmentStep2Params;
    // final PlanEntity plan = args.plan;
    // final PreInvestmentEntity preInvestment = args.preInvestment;
    // final PlanSimulation resultCalculator = args.resultCalculator;

    return CustomLoaderOverlay(
      child: CustomScaffoldReturnLogo(
        hideReturnButton: false,
        hideNavBar: true,
        body: Step2Body(
          currentTheme: currentTheme,
          plan: plan,
          reInvestment: reInvestment,
          resultCalculator: resultCalculator,
        ),
      ),
    );
  }
}

class Step2Body extends StatefulHookConsumerWidget {
  final SettingsProviderState currentTheme;
  final PlanEntity plan;
  final ReInvestmentEntity reInvestment;
  final PlanSimulation resultCalculator;

  const Step2Body({
    super.key,
    required this.currentTheme,
    required this.plan,
    required this.reInvestment,
    required this.resultCalculator,
  });

  @override
  _Step2BodyState createState() => _Step2BodyState();

  //on init set selectedBankAccountReceiver as null
}

class _Step2BodyState extends ConsumerState<Step2Body> {
  BankAccount? selectedReceiverBankAccount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //clean the voucher and accept terms

      ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
      ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state = [];
      ref.read(userAcceptedTermsProvider.notifier).state = false;
      ref.read(selectedBankAccountReceiverProvider.notifier).state = null;
      _updateBankAccount();
    });

    // selectedBankAccountReceiver = null;
  }

  Future<void> _updateBankAccount() async {
    final bankAccount = ref.read(selectedBankAccountReceiverProvider);
    if (bankAccount != null) {
      setState(() {
        selectedReceiverBankAccount = bankAccount;
      });
    }
  }

  Future<void> _setBankReceiverToReInvestment() async {
    if (selectedReceiverBankAccount != null) {
      //show loader
      final resp = await ref.watch(
        setBankAccountUserProvider(
          SetBankAccountUserParams(
            reInvestmentUUID: widget.reInvestment.id,
            bankAccountReceiver: selectedReceiverBankAccount!.id,
          ),
        ).future,
      );
      if (resp.success == true) {
        showThanksModal(context);
      } else {
        CustomSnackbar.show(context, 'Hubo un problema al guardar', 'error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final voucherImageBase64 = ref.watch(preInvestmentVoucherImagesProvider);
    final userReadContract = useState(false);
    final plan = widget.plan;
    final reInvestment = widget.reInvestment;
    final resultCalculator = widget.resultCalculator;
    final currentTheme = widget.currentTheme;
    final isSoles = currencyEnum.PEN == reInvestment.currency;
    final String textCurrency = isSoles ? 'soles' : 'dólares';
    final String moneySymbol = isSoles ? 'S/' : "\$";

    ref.listen<BankAccount?>(selectedBankAccountReceiverProvider, (previous, next) {
      context.loaderOverlay.show();
      _updateBankAccount();
      _setBankReceiverToReInvestment();
      context.loaderOverlay.hide();
    });

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const StepBar(
            step: 2,
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.centerLeft,
            width: 310,
            height: 40,
            child: Text(
              plan.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(Theme.of(context).colorScheme.secondary.value),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: 100,
                  // width: MediaQuery.of(context).size.width * 0.60,
                  // width: double.maxFinite,
                  alignment: Alignment.center,

                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircularImage(months: resultCalculator.months, planImageUrl: plan.imageUrl),
                      Positioned(
                        right: 108,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 59.49,
                            height: 35,
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              border: Border.all(
                                width: 4,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // color: Color(primaryDark),

                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    // '${resultCalculator.months}%',
                                    '${resultCalculator.finalRentability?.toString() ?? 0}% ',
                                    // '${resultCalculator.months == 6 ? plan.sixMonthsReturn : plan.twelveMonthsReturn}%',
                                    style: TextStyle(
                                      color: currentTheme.isDarkMode
                                          ? const Color(primaryDark)
                                          : const Color(primaryLight),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Rentabilidad',
                                  style: TextStyle(
                                    color: currentTheme.isDarkMode ? const Color(blackText) : const Color(whiteText),
                                    fontSize: 7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 116,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(primaryLight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$moneySymbol ${reInvestment.finalAmount}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(primaryDark),
                            ),
                          ),
                          const Text(
                            'Tu monto invertido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(blackText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: 116,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(secondary),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$moneySymbol ${resultCalculator.profitability}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(primaryDark),
                            ),
                          ),
                          const Text(
                            'Monto que recibiras',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(blackText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 320,
            child: Text(
              'Realiza tu transferencia a la cuenta bancaria de Finniu: ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 320,
            height: 154,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(38),
              ),
              color: currentTheme.isDarkMode
                  ? const Color(
                      primaryDark,
                    )
                  : const Color(gradient_secondary),
              border: Border.all(
                color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(gradient_secondary),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Finniu S.A.C',
                      style: TextStyle(
                        color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'RUC ',
                          style: TextStyle(
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '20609327210',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'N de cuenta $textCurrency Interbank ',
                          style: TextStyle(
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          isSoles ? '2003004077570' : '2003004754309',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                              new ClipboardData(
                                text: isSoles ? "2003004077570" : "2003004754309",
                              ),
                            ).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Copiado!'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            });
                          },
                          child: ImageIcon(
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                            size: 18,
                            const AssetImage(
                              'assets/icons/double_square.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'CCI ',
                          style: TextStyle(
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          isSoles ? '003 200 00300407757039' : '003 20000300475430932',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                    new ClipboardData(text: isSoles ? "00320000300407757039" : '00320000300475430932'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Copiado!'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            });
                          },
                          child: ImageIcon(
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                            size: 18,
                            const AssetImage(
                              'assets/icons/double_square.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 305,
            // alignment: Alignment.centerLeft,
            child: Text(
              'Adjunta tu constancia de transferencia: ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 320,
            height: 73,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft: Radius.circular(21),
                bottomRight: Radius.circular(21),
              ),
              color: const Color(primaryLightAlternative),
              border: Border.all(
                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryLightAlternative),
                width: 1,
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: InkWell(
                        onTap: () {
                          photoHelp(context);
                        },
                        child: ImageIcon(
                          const AssetImage('assets/icons/questions.png'),
                          size: 20, // Tamaño de la imagen
                          color: currentTheme.isDarkMode
                              ? const Color(grayText)
                              : const Color(primaryDark), // Color de la imagen
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images = await picker.pickMultiImage();

                        if (images.isNotEmpty) {
                          var voucherImageListBase64 = [];
                          var voucherImageListPreview = [];
                          for (var image in images) {
                            final File imageFile = File(image.path);
                            final List<int> imageBytes = await imageFile.readAsBytes();
                            final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";
                            voucherImageListBase64.add(base64Image);
                            voucherImageListPreview.add(image.path);
                          }
                          ref.read(preInvestmentVoucherImagesProvider.notifier).state =
                              List.from(voucherImageListBase64);
                          ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
                              List.from(voucherImageListPreview);
                        }
                      },
                      child: Builder(
                        builder: (context) {
                          final voucherPreview = ref.watch(preInvestmentVoucherImagesPreviewProvider);
                          return voucherPreview.isEmpty
                              ? ImageIcon(
                                  const AssetImage('assets/icons/photo.png'),
                                  color: currentTheme.isDarkMode ? const Color(grayText) : const Color(primaryDark),
                                )
                              : SizedBox(
                                  height: 60, // Ajusta este valor según tus necesidades
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal, // Hace que la lista sea horizontal
                                    itemCount: voucherPreview.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ), // Añade un espacio a la derecha de cada imagen
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Image.file(
                                                File(voucherPreview[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Código para eliminar la imagen
                                                    List<String> voucherImageBase64 =
                                                        ref.watch(preInvestmentVoucherImagesProvider);
                                                    List<String> voucherPreviewImage =
                                                        ref.watch(preInvestmentVoucherImagesPreviewProvider);
                                                    List<String> modifiedVoucherImageBase64 =
                                                        List.from(voucherImageBase64);

                                                    List<String> modifiedVoucherPreviewImage =
                                                        List.from(voucherPreviewImage);

                                                    modifiedVoucherImageBase64.removeAt(index);
                                                    modifiedVoucherPreviewImage.removeAt(index);
                                                    ref.read(preInvestmentVoucherImagesProvider.notifier).state =
                                                        modifiedVoucherImageBase64;
                                                    ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
                                                        modifiedVoucherPreviewImage;
                                                  },
                                                  child: Container(
                                                    width: 16,
                                                    height: 16,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black38, // Color semitransparente
                                                      shape: BoxShape.circle, // Forma redonda
                                                    ),
                                                    child: const Icon(Icons.close,
                                                        size: 8, color: Colors.white), // Icono de "x"
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Suba la foto nitida donde sea visible el código de operación',
                        style: TextStyle(
                          color: currentTheme.isDarkMode ? const Color(grayText) : const Color(primaryDark),
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 25,
                child: AcceptedTermCheckBox(),
              ),
              Text(
                'He leido y acepto el ',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String contractURL = reInvestment.contractURL;
                  print('contractURL: $contractURL');

                  if (contractURL.isNotEmpty) {
                    userReadContract.value = true;

                    Navigator.pushNamed(
                      context,
                      '/contract_view',
                      arguments: {
                        'contractURL': contractURL,
                      },
                    );
                  }
                },
                child: Text(
                  ' Contrato de Inversion de Finniu ',
                  style: TextStyle(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () async {
                final base64Image = voucherImageBase64;
                if (base64Image.isEmpty) {
                  CustomSnackbar.show(context, 'Debe subir una imagen de la constancia de transferencia', 'error');
                  return;
                }

                if (ref.watch(userAcceptedTermsProvider) == false) {
                  CustomSnackbar.show(context, 'Debe aceptar y leer el contrato', 'error');
                  return;
                }
                context.loaderOverlay.show();
                // final response = await PreInvestmentDataSourceImp().update(
                //   client: ref.watch(gqlClientProvider).value!,
                //   uuid: reInvestment.id,
                //   readContract: ref.watch(userAcceptedTermsProvider),
                //   files: base64Image,
                // );
                final updateParams = UpdateReInvestmentParams(
                  preInvestmentUUID: reInvestment.id,
                  userReadContract: ref.watch(userAcceptedTermsProvider),
                  files: base64Image,
                );
                final response = await ref.read(updateReInvestmentProvider(updateParams).future);

                if (response.success == true) {
                  context.loaderOverlay.hide();
                  // showThanksModal(context);
                  showBankAccountModal(
                      context, ref, reInvestment.currency, false, typeReinvestmentEnum.CAPITAL_ADITIONAL);

                  // Navigator.pushNamed(context, '/investment_step3');
                } else {
                  context.loaderOverlay.hide();
                  CustomSnackbar.show(
                    context,
                    response.messages?[0].message ?? 'Hubo un problema al guardar',
                    'error',
                  );
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(2),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Text(
                'Enviar Constancia',
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class CircularCountdown extends ConsumerWidget {
  final PlanSimulation resultCalculator;
  const CircularCountdown({
    super.key,
    required this.resultCalculator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return SizedBox(
      // alignment: Alignment.centerLeft,
      width: 125.41,
      height: 127.01,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: 60,
            ringColor: const Color(primaryLight),
            fillColor: const Color(primaryDark),
            backgroundColor: currentTheme.isDarkMode ? const Color(backgroundColorDark) : const Color(whiteText),
            strokeWidth: 6.0,
            textStyle: const TextStyle(
              fontSize: 10.0,
              color: Color(primaryDark),
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            onComplete: () {
              debugPrint('Countdown Ended');
            },
          ),
          Positioned(
            top: 20.0,
            child: Column(
              children: [
                Image.asset(
                  'assets/result/money.png',
                  width: 60.0,
                  height: 58.22,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'S/${resultCalculator.months}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(
                            primaryDark,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void photoHelp(
  BuildContext ctx,
) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 11,
    context: ctx,
    builder: (ctx) => const PhotoHelp(),
  );
}

class PhotoHelp extends ConsumerWidget {
  const PhotoHelp({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: currentTheme.isDarkMode
            ? const Color(primaryDark)
            : const Color(
                primaryLight,
              ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(bottom: 10, right: 20, top: 15),
            child: IconButton(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(
                      blackText,
                    ),
              alignment: Alignment.topRight,
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // cerrar la pantalla modal
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/images/page.png',
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(
                width: 260,
                child: Text(
                  'Adjunta tu comprobante con 3 pasos ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(
                            primaryDark,
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Text(
              '1.Tomate foto o screenshot del voucer de tu transferencia.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(
                        blackText,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Text(
              '2.Abre tus archivos o tu galeria y busca la foto del voucher de su transferencia',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(
                        blackText,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Text(
              '3.Selecciona la foto o screenshot del voucher de tu transferencia',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(
                        blackText,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            '¡Y listo!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(
                      blackText,
                    ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
