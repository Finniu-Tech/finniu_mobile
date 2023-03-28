import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_2 extends ConsumerWidget {
  const Step_2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              width: 310,
              height: 40,
              child: Text(
                'Plan Origen',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width * 0.60,
                  // width: double.maxFinite,
                  alignment: Alignment.center,

                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircularImage(),
                      Positioned(
                        right: 90,
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
                                    textAlign: TextAlign.center,
                                    '6%',
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
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'S/550',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(primaryDark),
                            ),
                          ),
                          Text(
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
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'S/583',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(primaryDark),
                            ),
                          ),
                          Text(
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
            const SizedBox(
              width: 305,
              // alignment: Alignment.centerLeft,
              child: Text(
                'Realiza tu transferencia a la cuenta bancaria de Finniu: ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
              
                  color: Color(
                      primaryDark),
                ),
              ),
            ),
             const SizedBox(height: 70,),
             const SizedBox(
              width: 305,
              // alignment: Alignment.centerLeft,
              child: Text(
                'Adjunta tu constancia de transferencia: ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
              
                  color: Color(
                      primaryDark),
                ),
              ),
            ),
             const SizedBox(height: 12,),
             Container(
              width: MediaQuery.of(context).size.width * 0.8,
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
              
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Suba la foto nitida donde sea visible el código de operación',
                    style: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(grayText)
                            : const Color(primaryDark),fontSize: 8,
                    ),
                   
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
        
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),),
                
        border:Border.all(color:const Color(primaryDark))
      ),
    ),
    const SizedBox(width: 10,),
    const Text(
      'He leido y acepto el ',
      style: TextStyle(
        fontSize: 10,
        color: Color(blackText),
      ),
    ),
    
    const Text(
      ' Contrato de Inversion de Finniu ',
      style: TextStyle(
        fontSize: 12, 
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

            const SizedBox(height: 10,),
            const CustomButton(
                text: "Finalizar mi proceso",
                height: 50,
                width: 224,
                pushName: '/investment_step3',
              ),
             ],
            ),),
            );
            
            }
}








class CircularCountdown extends ConsumerWidget {
  const CircularCountdown({super.key});
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
                  '6 meses',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(
                              primaryDark,
                            )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

getModal(context, WidgetRef ref) {
  final currentTheme = ref.watch(settingsNotifierProvider);
  // final bankController = useTextEditingController();
  {
    return showModalBottomSheet<void>(
      backgroundColor: currentTheme.isDarkMode
          ? const Color(primaryDark)
          : const Color(primaryLight),
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        var MontoController;
        return Container(
          height: 516,
          width: 360,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(blackText),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add_circle_outline,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Agregar Cuenta',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: 69,
                    height: 58,
                    child: Image.asset('assets/images/credit_card.png'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Banco donde realizaras tu transferencia',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Icon(
                      Icons.quiz_outlined,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      size: 23.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // CustomSelectButton(
              //   // textEditingController: bankController,
              //   items: const ['BCP', 'Interbank', 'Scotiabank'],
              //   labelText: "Banco",
              // ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 224,
                child: TextFormField(
                  controller: MontoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // nickNameController.text = value.toString();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Escriba su cuenta bancaria',
                    label: Text("Cuenta Bancaria"),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.check_box_outline_blank,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      size: 21.0,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Confirmo que esa cuenta me pertenece',
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomButton(
                  text: "Guardar cuenta", width: 224, height: 52.7),
            ],
          ),
        );
      },
    );
  }
}
