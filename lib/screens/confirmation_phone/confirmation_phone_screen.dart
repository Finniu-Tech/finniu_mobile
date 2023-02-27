import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Confirmation_Phone extends ConsumerWidget {
  const Confirmation_Phone({super.key});

  get numerotelefonicoController => null;

  get numerotelefonicoValidator => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffoldReturn(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        const SizedBox(height: 90),
        Stack(
          children: <Widget>[
            Container(
              width: 276,
              height: 70,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Text(
                'Confirmación de número telefónico',
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
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: 246,
                height: 99,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 65),
                decoration: BoxDecoration(
                  color: Color(gradient_secondary),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Hola Mari queremos enviarte un SMS de tu código de verificación por favor confirmanos tu numero telefonico.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 30,
                left: 160,
                child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        width: 65, // ancho deseado de la imagen
                        height: 61, // alto deseado de la imagen
                        child: Image(
                          image: AssetImage('assets/forgotpassword/letter.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )))
          ],
        ),
        SizedBox(
          height: 35,
        ),
        SizedBox(
          width: 224,
          child: TextFormField(
            controller: numerotelefonicoController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Este dato es requerido';
              }
              if (numerotelefonicoValidator.validate(value) == false) {
                return 'Ingrese un telefono válido';
              }
              return null;
            },
            onChanged: (value) {
              // emailController.text = value.toString();
            },
            decoration: const InputDecoration(
              hintText: 'Escriba su número telefónnico',
              label: Text('Número telefónico'),
            ),
          ),
        ),
        SizedBox(
          height: 120,
        ),
        SizedBox(
          width: 224,
          height: 50,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/confirmation');
            },
            child: Text('Enviar SMS'),
          ),
        ),
      ],
    )));
  }
}
