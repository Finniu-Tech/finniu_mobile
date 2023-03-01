import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/providers/user_provider.dart';
import 'package:finniu/screens/signup/widgets/modals.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class Confirmation_Phone extends ConsumerWidget {
  const Confirmation_Phone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfileProvider = ref.watch(userProfileNotifierProvider);

    final phoneController =
        TextEditingController(text: userProfileProvider.phoneNumber);
    final phoneValidator = RegExp(r'^[0-9]+$');

    // if (currentTheme.showWelcomeModal) {
    //   showWelcomeModal(context, ref);
    // }
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
                      color:
                          Color(Theme.of(context).colorScheme.secondary.value),
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
                      color: const Color(gradient_secondary),
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
                    child: const Center(
                      child: SizedBox(
                        width: 65, // ancho deseado de la imagen
                        height: 61, // alto deseado de la imagen
                        child: Image(
                          image: AssetImage('assets/forgotpassword/letter.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 224,
              child: TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  if (!phoneValidator.hasMatch(value) == false) {
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
            const SizedBox(
              height: 120,
            ),
            SizedBox(
              width: 224,
              height: 50,
              child: TextButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/showModalBottomSheet');
                  sendSMSModal(context, ref);
                },
                child: const Text('Enviar SMS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
