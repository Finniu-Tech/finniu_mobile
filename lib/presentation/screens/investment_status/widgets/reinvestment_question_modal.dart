// I need a bottomSheetModal where  start with a image at center top, then have a title  , then it show two button bottom, one for cancel and other for accept

import 'package:finniu/constants/colors.dart';
// import 'package:finniu/domain/entities/user_notification_entity.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void reinvestmentQuestionModal(
  BuildContext ctx,
  WidgetRef ref,
  String preInvestmentUUID,
  double preInvestmentAmount,
  String currency,
) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor: themeProvider.isDarkMode ? const Color(backgroundColorDark) : Colors.white,
    context: ctx,
    builder: (ctx) => ReinvestmentQuestionBody(
        themeProvider: themeProvider,
        preInvestmentUUID: preInvestmentUUID,
        preInvestmentAmount: preInvestmentAmount,
        currency: currency),
  );
}

class ReinvestmentQuestionBody extends HookConsumerWidget {
  const ReinvestmentQuestionBody({
    super.key,
    required this.themeProvider,
    required this.preInvestmentUUID,
    required this.preInvestmentAmount,
    required this.currency,
  });

  final SettingsProviderState themeProvider;
  final String preInvestmentUUID;
  final double preInvestmentAmount;
  final String currency;
  // final UserNotificationEntity userNotification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return Container(
      // customize background color
      color: themeProvider.isDarkMode ? const Color(backgroundColorDark) : Colors.white,

      height: 400,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset('assets/reinvestment/avatar_with_money.png'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                ),
                "¡Muchas gracias por tu interés de reinvertir en Finniu!",
              ),
            ),

            const SizedBox(height: 20),
            // row with two lines and text in the middle of lines
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //container with a line
                  Container(
                    width: 70,
                    height: 1,
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                  ),
                  const SizedBox(width: 10),
                  //text in the middle of lines
                  Text(
                    "Elige tu opción de reinversión",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //container with a line
                  Container(
                    width: 70,
                    height: 1,
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            // TWO BUTTONS ONE OVER OTHER

            // first button
            SizedBox(
              width: 220,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //navigate to reinvestment_step_1

                  Navigator.pushNamed(
                    context,
                    '/reinvestment_step_1',
                    arguments: {
                      'preInvestmentUUID': preInvestmentUUID,
                      'preInvestmentAmount': preInvestmentAmount,
                      'currency': currency,
                      'reInvestmentType': typeReinvestmentEnum.CAPITAL_ADITIONAL,
                    },
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  backgroundColor: Color(
                    themeProvider.isDarkMode ? primaryLight : primaryDark,
                  ),
                ),
                child: Text(
                  'Aumentar mi capital',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: themeProvider.isDarkMode ? const Color(primaryDark) : Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    '/reinvestment_step_1',
                    arguments: {
                      'preInvestmentUUID': preInvestmentUUID,
                      'preInvestmentAmount': preInvestmentAmount,
                      'currency': currency,
                      'reInvestmentType': typeReinvestmentEnum.CAPITAL_ONLY,
                    },
                  );
                  // showThanksModal(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                    width: 1,
                  ),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  backgroundColor:
                      themeProvider.isDarkMode ? const Color(primaryDark) : const Color(backgroundColorLight),
                ),
                child: Text(
                  'Reinvertir el mismo capital',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  themeProvider.isDarkMode ? const Color(backgroundColorDark) : Colors.white,
                ),
                elevation: MaterialStateProperty.all<double>(0.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                showDialogRefuseReasons(context, ref, preInvestmentUUID);
              },
              child: const Text(
                'Aún no deseo reinvertir',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Color(0xff989797),
                  // color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//this widget will return a modal with a a different reasons to decline a question, it will have a title, a list of reasons like a buttons scrollable, and en the end on the modal in a row two buttons, one for cancel and other for send

void showDialogRefuseReasons(BuildContext ctx, WidgetRef ref, String preInvestmentUUID) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showDialog(
    // barrierColor: themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,

    context: ctx,
    builder: (ctx) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: themeProvider.isDarkMode ? const Color(backgroundColorDark) : Colors.white,
      content: QuestionDeclineReasonsModal(themeProvider: themeProvider, preInvestmentUUID: preInvestmentUUID),
    ),
  );
}

class QuestionDeclineReasonsModal extends HookConsumerWidget {
  const QuestionDeclineReasonsModal({
    super.key,
    required this.themeProvider,
    required this.preInvestmentUUID,
  });

  final SettingsProviderState themeProvider;
  final String preInvestmentUUID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReason = useState<String?>(null);
    final otherReasonController = useTextEditingController();

    useEffect(
      () {
        selectedReason.value = null;
        otherReasonController.clear();
      },
      [],
    );

    return Container(
      height: 480,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            "Cuéntanos tus motivos",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
            child: ListView(
              children: [
                reasonButton(context, themeProvider, selectedReason, 'Ya completé mi meta'),
                const SizedBox(height: 10),
                reasonButton(context, themeProvider, selectedReason, 'Necesito mi dinero'),
                const SizedBox(height: 10),
                reasonButton(context, themeProvider, selectedReason, 'Me han ofrecido mejor rentabilidad'),
                const SizedBox(height: 10),
                reasonButton(context, themeProvider, selectedReason, 'Percibo mucho riesgo'),
                const SizedBox(height: 10),
                reasonButton(context, themeProvider, selectedReason, 'Otros'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (selectedReason.value == 'Otros')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: otherReasonController,
                decoration: const InputDecoration(
                  labelText: 'Escribe tu motivo',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                      width: 1,
                    ),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor:
                        themeProvider.isDarkMode ? const Color(primaryDark) : const Color(backgroundColorLight),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 120,
                child: TextButton(
                  onPressed: () {
                    // validate if the user selected a reason , if other is selected validate if the user wrote a reason

                    if (selectedReason.value == null ||
                        selectedReason.value == 'Otros' && otherReasonController.text.isEmpty) {
                      CustomSnackbar.show(context, 'Selecciona un motivo', 'error');
                      return;
                    }
                    final reason = mapReason(selectedReason.value!);
                    final otherReason = selectedReason.value == 'Otros' ? otherReasonController.text : '';

                    ref
                        .read(
                      rejectReInvestmentProvider(
                        RejectReInvestmentParams(
                            preInvestmentUUID: preInvestmentUUID, rejectMotivation: reason!, textRejected: otherReason),
                      ).future,
                    )
                        .then((value) {
                      if (value.success) {
                        Navigator.of(context).pop();
                        showGreetingsModal(context, ref);
                      } else {
                        CustomSnackbar.show(context, 'Error al enviar la respuesta', 'error');
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: Color(
                      themeProvider.isDarkMode ? primaryLight : primaryDark,
                    ),
                  ),
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: themeProvider.isDarkMode ? const Color(primaryDark) : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reasonButton(
      BuildContext context, SettingsProviderState themeProvider, ValueNotifier<String?> selectedReason, String reason) {
    return TextButton(
      onPressed: () {
        selectedReason.value = reason;
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        backgroundColor: selectedReason.value == reason
            ? themeProvider.isDarkMode
                ? const Color(primaryDark)
                : const Color(0xffD3D3D3)
            : themeProvider.isDarkMode
                ? const Color(primaryDark)
                : const Color(0xffF2F2F2),
      ),
      child: Text(
        reason,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: selectedReason.value == reason
              ? themeProvider.isDarkMode
                  ? Colors.white
                  : Colors.black
              : themeProvider.isDarkMode
                  ? const Color(grayText)
                  : Colors.black,
        ),
      ),
    );
  }
}

// when the previous modal is clicked on the send buttom it will show a modal with a message of success and a button to close the modal

void showGreetingsModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showDialog(
    // barrierColor: themeProvider.isDarkMode ? Color(backgroundColorDark) : Colors.white,

    context: ctx,
    builder: (ctx) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: themeProvider.isDarkMode ? const Color(backgroundColorDark) : const Color(orangeLight),
      content: const GreetingsModalBody(),
    ),
  );
}

class GreetingsModalBody extends HookConsumerWidget {
  const GreetingsModalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      //bcakground color
      // color: themeProvider.isDarkMode ? Color(backgroundColorDark) : Color(0xffFFF4EA),
      height: 298,
      width: 319,
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatars/avatar_2.png'),
            radius: 35,
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              '¡Muchas gracias por tus comentarios!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Esperamos verte pronto 💸'),
          const SizedBox(height: 20),
          SizedBox(
            width: 160,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                backgroundColor: Color(
                  themeProvider.isDarkMode ? primaryLight : primaryDark,
                ),
              ),
              child: Text(
                'Gracias',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: themeProvider.isDarkMode ? const Color(primaryDark) : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//TODO move all this widget to reinvestment folder