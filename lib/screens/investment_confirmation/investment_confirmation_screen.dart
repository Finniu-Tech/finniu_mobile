import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confirmation_Investment extends StatelessWidget {
  const Confirmation_Investment({super.key});

  @override
  Widget build(BuildContext context) {
    var MontoController;

    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      const SizedBox(height: 90),
      Stack(
        children: <Widget>[
          Container(
            width: 276,
            height: 70,
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
      SizedBox(
        height: 10,
      ),
      Text(
        'Tu plan seleccionado es',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(Theme.of(context).colorScheme.secondary.value),
        ),
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
              left: 80,
              bottom: 5,
              child: Container(
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
      const Text(
        'Ingresa tu monto y plazo',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(primaryDark),
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
      SizedBox(
        width: 224,
        height: 39,
        child: DropdownSearch<String>(
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: 'Seleccione el plazo',
              labelText: 'Plazo',
            ),
          ),
          items: [
            '6 meses',
            '1 año',
            '5 años',
          ],
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            itemBuilder: (context, item, isSelected) => Container(
              decoration: BoxDecoration(
                color: Color(isSelected ? primaryDark : primaryLight),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 15,
                left: 15,
              ),
              child: Text(
                item.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(isSelected ? Colors.white.value : primaryDark),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            menuProps: const MenuProps(
              backgroundColor: Color(primaryLightAlternative),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(primaryDark),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search),
                label: Text('Buscar'),
              ),
            ),
          ),
          dropdownButtonProps: const DropdownButtonProps(
            color: Color(primaryDark),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      SizedBox(
        width: 224,
        height: 39,
        child: DropdownSearch<String>(
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: 'Seleccione su eleccion',
              labelText: 'Eleccion de Rentabilidad',
            ),
          ),
          items: [
            'Mensual',
            'Plazo Fijo',
          ],
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            itemBuilder: (context, item, isSelected) => Container(
              decoration: BoxDecoration(
                color: Color(isSelected ? primaryDark : primaryLight),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 15,
                left: 15,
              ),
              child: Text(
                item.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(isSelected ? Colors.white.value : primaryDark),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            menuProps: const MenuProps(
              backgroundColor: Color(primaryLightAlternative),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(primaryDark),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search),
                label: Text('Buscar'),
              ),
            ),
          ),
          dropdownButtonProps: const DropdownButtonProps(
            color: Color(primaryDark),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      CustomButton(
        text: "Continuar",
        height: 50,
        width: 224,
      ),
    ])));

    ;
  }
}

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Stepper Demo'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Account'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email Address'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Address'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Home Address'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Postcode'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Mobile Number'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Mobile Number'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical ? stepperType = StepperType.horizontal : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
