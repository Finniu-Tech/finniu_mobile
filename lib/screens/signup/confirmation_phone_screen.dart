import 'package:finniu/constants/colors.dart';
import 'package:finniu/models/auth.dart';
import 'package:finniu/providers/signup_provider.dart';
import 'package:finniu/providers/timer_counterdown_provider.dart';
import 'package:finniu/providers/user_provider.dart';
import 'package:finniu/screens/signup/widgets/modals.dart';
import 'package:finniu/use_cases/user/signup.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ConfirmationPhone extends HookConsumerWidget {
  const ConfirmationPhone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfileProvider = ref.watch(userProfileNotifierProvider);

    final phoneController =
        TextEditingController(text: userProfileProvider.phoneNumber);
    final showError = useState(false);
    final accountCreated = useState(false);
    final formKey = GlobalKey<FormState>();

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 90),
                  Text(
                    'Confirmación de número telefónico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color:
                          Color(Theme.of(context).colorScheme.secondary.value),
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Positioned(
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
                        // left: 160,
                        child: Container(
                          color: Colors.transparent,
                          child: const Center(
                            child: SizedBox(
                              width: 65, // ancho deseado de la imagen
                              height: 61, // alto deseado de la imagen
                              child: Image(
                                image: AssetImage(
                                    'assets/forgotpassword/letter.png'),
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
                        if (value.length != 9) {
                          return 'Tiene que ser de 9 dígitos';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Escriba su número telefónnico',
                        label: Text('Número telefónico'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  if (showError.value) ...[
                    const Text(
                      'No se pudo completar el registro',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                      ),
                    ),
                  ],
                  SizedBox(
                    width: 224,
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        showError.value = false;
                        // sendSMSModal(context, ref);
                        if (formKey.currentState!.validate()) {
                          context.loaderOverlay.show();
                          Future<bool> status = SignUpService().finishRegister(
                            ref,
                            phoneController.text.toString(),
                          );
                          status.then((value) {
                            print('status value $value');
                            if (value == false) {
                              print('if!!');
                              showError.value = true;
                            } else {
                              print('else!!');
                              accountCreated.value = true;
                              context.loaderOverlay.hide();
                              ref
                                  .read(timerCounterDownProvider.notifier)
                                  .startTimer();

                              sendSMSModal(context, ref);
                            }
                            context.loaderOverlay.hide();
                          });
                        }
                      },
                      child: const Text('Enviar SMS'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
