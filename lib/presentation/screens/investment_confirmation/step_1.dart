import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_1 extends HookConsumerWidget {
  const Step_1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final termController = useTextEditingController();

    var MontoController;

    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(children: <Widget>[
        StepBar(),
        const SizedBox(height: 40),
        Container(width: 200,
          child: Stack(
            children: <Widget>[
              Container(
               width: MediaQuery.of(context).size.width * 0.9,
                // height: 90,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Text(
                  'Confirmación de tu inversión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(Theme.of(context).colorScheme.secondary.value),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Tu plan seleccionado es',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(secondaryGrayText)),
        ),
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.topRight,
                width: 224,
                height: 99,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  color: Color(cardBackgroundColorLight),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Plan Origen',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(primaryDark),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 15,
                          color: Color(primaryDark),
                        ),
                        const Text(
                          'Desde S/500',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(primaryDark),
                            fontSize: 10,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.currency_exchange_rounded,
                          size: 15,
                          color: Color(primaryDark),
                        ),
                        const Text(
                          '12% anual',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(primaryDark),
                            fontSize: 10,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 40,
                left: 250,
                bottom: 5,
                child: Container(width:100 ,height: 100,
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        width: 80, // ancho deseado de la imagen
                        height: 80, // alto deseado de la imagen
                        child: Image(
                          image: AssetImage('assets/result/money.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ))),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Ingresa tu monto y plazo',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: currentTheme.isDarkMode
                ? const Color(whiteText)
                : const Color(primaryDark),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
        SizedBox(
          height: 15,
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
              hintText: 'Escriba su monto de inversion',
              label: Text("Monto"),
            ),
          ),
        ),
        SizedBox(height: 15),
        CustomSelectButton(
          textEditingController: termController,
          items: const ['6 meses', '1 año', '5 años'],
          labelText: "Plazo",
        ),
        SizedBox(
          height: 15,
        ),
        CustomSelectButton(
          textEditingController: termController,
          items: const ['6 Mensual', 'Plazo Fijo'],
          labelText: "Eleccion de Rentabilidad",
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          text: "Continuar",
          height: 50,
          width: 224,
          pushName: '/investment_step2',
        ),
      ]),
    )));

    ;
  }
}

class StepBar extends ConsumerStatefulWidget {
  const StepBar({Key? key}) : super(key: key);

  @override
  _StepBarState createState() => _StepBarState();
}

class _StepBarState extends ConsumerState<StepBar> {
  final double squareSize = 50.0;
  final Color activeColor = Color(secondary);
  final Color inactiveColor = Color(primaryLight);

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          height: 35,
          width: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              width: 2,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Icon(
            Icons.monetization_on_outlined,
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
          ),
        ),
        Container(
          width: 30,
          child: Column(
            children: [
              Divider(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                thickness: 1,
              ),
            ],
          ),
        ),
        Container(
          height: 35,
          width: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              width: 2,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Icon(
            Icons.article_outlined,
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
          ),
        ),
        Container(
          width: 30,
          child: Column(
            children: [
              Divider(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                thickness: 1,
              ),
            ],
          ),
        ),
        Container(
          height: 35,
          width: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              width: 2,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Icon(
            Icons.aspect_ratio_sharp,
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
          ),
        ),
        Container(
          width: 30,
          child: Column(
            children: [
              Divider(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                thickness: 1,
              ),
            ],
          ),
        ),
        Container(
          height: 35,
          width: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              width: 2,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Icon(
            Icons.edit_outlined,
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
          ),
        )
      ])
    ]);
  }
}
