
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_1 extends HookConsumerWidget {
  const Step_1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final termController = useTextEditingController();
    final mountController = useTextEditingController();

    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              const StepBar(),
              const SizedBox(height: 40),
              SizedBox(
                // width: 200,
                child: Stack(
                  children: <Widget>[
        
                      // width: MediaQuery.of(context).size.width * 0.9,
                      // height: 90,
                      // padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              Text(
                        'Tu plan seleccionado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(Theme.of(context).colorScheme.secondary.value),
                        ),
                      ),
                   
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              
              Container(
                // alignment: Alignment.topRight,
                width: 224,
                height: 99,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(cardBackgroundColorLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.transparent,
                      child: const Center(
                        child: SizedBox(
                          width: 80, // ancho deseado de la imagen
                          height: 80, // alto deseado de la imagen
                          child: Image(
                            image: AssetImage('assets/result/money.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Column(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Image(
      image: AssetImage('assets/icons/dollar.png'),
      width: 12, // ancho deseado de la imagen
      height: 12, // alto deseado de la imagen
      color: Color(primaryDark), // color de la imagen si es necesario
    ),
                            Text(
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
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                             Image(
      image: AssetImage('assets/icons/double_dollar.png'),
      width: 21, // ancho deseado de la imagen
      height: 21, // alto deseado de la imagen
      color: Color(primaryDark), // color de la imagen si es necesario
    ),
                            Text(
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
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Completa los siguientes datos',
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
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 224,
                child: TextFormField(
                  controller: mountController,
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
                    hintText: 'Escriba su monto de inversion',hintStyle: TextStyle(color:Color(grayText),fontSize: 11),
                    label: Text("Monto"),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomSelectButton(
                textEditingController: termController,
                items: const ['6 meses', '1 año', '5 años'],
                labelText: "Plazo",
                hintText:"Seleccione su plazo de inversión" ,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomSelectButton(
                textEditingController: termController,
                items: const ['BCP', 'Interbank','Scotiabank'],
                labelText: "Desde que banco realizas la transferencia",
                hintText: "Seleccione su banco",
              ),
             const SizedBox(
                height: 15,
              ),
            
             SizedBox(
                width: 224,
                child: TextFormField(
                  controller: mountController,
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
                    hintText: 'Ingresa tu codigo',hintStyle: TextStyle(color:Color(grayText),fontSize: 11),
                    label: Text("Ingresa tu codigo promocional,si tienes uno"),
                  ),
                ),
              ),
            
            
            
            
            Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 136,
                          height: 81,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(primaryLight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              
                               Text(
                                '6%',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(primaryDark),
                                ),
                              ),
                              Text(
                                '% de retorno',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(blackText),
                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(width: 17),
                        Container(
                          width: 136,
                          height: 81,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(secondary),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
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
                                'En 6 meses tendrias',
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
                  ),
                      
              const SizedBox(
                height: 20,
              ),
              const CustomButton(
                text: "Continuar",
                height: 50,
                width: 224,
                pushName: '/investment_step2',
              ),
            
            ],
            ),
    ),
    );
    

    
  }
}

class StepBar extends ConsumerStatefulWidget {
  const StepBar({Key? key}) : super(key: key);

  @override
  _StepBarState createState() => _StepBarState();
}

class _StepBarState extends ConsumerState<StepBar> {
  final double squareSize = 50.0;
  final Color activeColor = const Color(secondary);
  final Color inactiveColor = const Color(primaryLight);

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 35,
            width: 46,
            decoration: BoxDecoration(
              border: Border.all(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                width: 2,
              ),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child:Image.asset(
      'assets/icons/dollar.png',width: 5,height: 5,color:currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
      fit:BoxFit.scaleDown,
     
    ),
          ),
          SizedBox(
            width: 38,
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
            width: 46,
            decoration: BoxDecoration(
              border: Border.all(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                width: 2,
              ),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Image.asset(
      'assets/icons/paper.png',color:currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
      fit:BoxFit.scaleDown,
     
    ),
          ),
          SizedBox(
            width: 38,
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
            width: 46,
            decoration: BoxDecoration(
              border: Border.all(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                width: 2,
              ),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Image.asset(
      'assets/icons/square2.png',color:currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
      fit:BoxFit.scaleDown,
     
    ),
          ),
          
          
        ],
        ),
      ],
      ),
    );
  }
}
