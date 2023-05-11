import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/calculator/result_calculator_screen.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/checkbox.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class PreInvestmentStep2Arguments {
  final PlanEntity plan;
  final PreInvestmentEntity preInvestment;
  final PlanSimulation resultCalculator;

  PreInvestmentStep2Arguments({
    required this.plan,
    required this.preInvestment,
    required this.resultCalculator,
  });
}

class Step2 extends ConsumerWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final args = ModalRoute.of(context)!.settings.arguments
        as PreInvestmentStep2Arguments;
    final PlanEntity plan = args.plan;
    print('plan');
    print(plan);
    final PreInvestmentEntity preInvestment = args.preInvestment;
    final PlanSimulation resultCalculator = args.resultCalculator;

    return CustomLoaderOverlay(
      child: CustomScaffoldReturnLogo(
        body: Step2Body(
          currentTheme: currentTheme,
          plan: plan,
          preInvestment: preInvestment,
          resultCalculator: resultCalculator,
        ),
      ),
    );
  }
}

class Step2Body extends HookConsumerWidget {
  final SettingsProviderState currentTheme;
  final PlanEntity plan;
  final PreInvestmentEntity preInvestment;
  final PlanSimulation resultCalculator;

  const Step2Body({
    super.key,
    required this.currentTheme,
    required this.plan,
    required this.preInvestment,
    required this.resultCalculator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ImagePicker voucherImage = ImagePicker();
    // final ValueNotifier<String> voucherPreview;
    final voucherPreview = useState('');
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 100,
                width: MediaQuery.of(context).size.width * 0.60,
                // width: double.maxFinite,
                alignment: Alignment.center,

                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircularImage(months: resultCalculator.months),
                    Positioned(
                      right: 108,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 59.49,
                          height: 31.15,
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(primaryDark),
                            border: Border.all(
                              width: 4,
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
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
                                  '${plan.sixMonthsReturn}%',
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
                                  color: currentTheme.isDarkMode
                                      ? const Color(blackText)
                                      : const Color(whiteText),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S/${preInvestment.amount}',
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S/${resultCalculator.profitability}',
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
          const SizedBox(height: 20),
          SizedBox(
            width: 320,
            child: Text(
              'Realiza tu transferencia a la cuenta bancaria de Finniu: ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 320,
            height: 138,
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
                color: currentTheme.isDarkMode
                    ? const Color(primaryDark)
                    : const Color(gradient_secondary),
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
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
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
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '20609327210',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(grayText),
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
                          'N de cuenta Interbank ',
                          style: TextStyle(
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '2003004077570',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                    new ClipboardData(text: "2003004077570"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Copiado!'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            });
                          },
                          child: ImageIcon(
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(grayText),
                            size: 18,
                            const AssetImage(
                              'assets/icons/double_square.png',
                            ),
                          ),
                        )
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
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '003 200 00300407757039',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(grayText),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(new ClipboardData(
                                    text: "003 200 00300407757039"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Copiado!'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            });
                          },
                          child: ImageIcon(
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(grayText),
                            size: 18,
                            const AssetImage(
                              'assets/icons/double_square.png',
                            ),
                          ),
                        )
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
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark),
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
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryLightAlternative),
                width: 1,
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      alignment: Alignment.topRight,
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
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      Future<XFile?> ximage =
                          voucherImage.pickImage(source: ImageSource.gallery);
                      voucherPreview.value =
                          await ximage.then((value) => value!.path);
                      print('image value is ${voucherPreview.value}');
                    },
                    child: voucherPreview.value == ''
                        ? ImageIcon(
                            const AssetImage('assets/icons/photo.png'),
                            color: currentTheme.isDarkMode
                                ? const Color(grayText)
                                : const Color(primaryDark),
                          )
                        : SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.file(
                              File(voucherPreview.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Suba la foto nitida donde sea visible el código de operación',
                    style: TextStyle(
                      color: currentTheme.isDarkMode
                          ? const Color(grayText)
                          : const Color(primaryDark),
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
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
              SizedBox(width: 25, child: const CustomCheckBox()),
              Text(
                'He leido y acepto el ',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf_page');
                },
                child: Text(
                  ' Contrato de Inversion de Finniu ',
                  style: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
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
              onPressed: () {
                Navigator.pushNamed(context, '/investment_step3');
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(2),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Text(
                'Finalizar mi proceso',
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
    Key? key,
    required this.resultCalculator,
  }) : super(key: key);

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
            backgroundColor: currentTheme.isDarkMode
                ? const Color(backgroundColorDark)
                : const Color(whiteText),
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
          borderRadius: BorderRadius.circular(40)),
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
