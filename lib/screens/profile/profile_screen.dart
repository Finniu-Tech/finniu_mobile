import 'package:email_validator/email_validator.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isHidden = useState(true);
    final showError = useState(false);
    final nickNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    var FilteringTextInputFormatter;
    return CustomScaffoldReturn(
        body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 142,
                      width: 191,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/avatar_profile.png"),
                      ))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Completa tus datos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: Color(primaryDark),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 224,
                child: TextFormField(
                  // controller: nickNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nickNameController.text = value.toString();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Escriba sus nombre completos',
                    label: Text("Nombres completos"),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 224,
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    if (value.length != 9) {
                      return 'Tiene que ser de  dígitos';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // phoneController.text = value;
                  },
                  keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'Escriba su documento de indentificación',
                    label: Text("Documento de indentifación"),
                  ),
                ),
                // height: 38,
                // child: ButtonDecoration(
                //   textHint: 'Escriba su número telefónico',
                //   textLabel: "Número telefónico",
                // ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 224,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    if (EmailValidator.validate(value) == false) {
                      return 'Ingrese un correo válido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // emailController.text = value.toString();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Escriba su departamento',
                    label: Text('Departamento'),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 224,
                // height: 38,
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // passwordController.text = value;
                  },
                  obscureText: isHidden.value, // esto oculta la contrasenia
                  obscuringCharacter: '*',

                  decoration: InputDecoration(
                    hintText: 'Escriba su distrito',
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 38,
                      minWidth: 38,
                    ),
                    label: const Text(
                      "Distrito",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (showError.value) ...[
                const Text(
                  'No se pudo completar el registro',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                  ),
                ),
              ],
              const SizedBox(height: 15),
              SizedBox(
                width: 224,
                // height: 38,
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // passwordController.text = value;
                  },
                  obscureText: isHidden.value, // esto oculta la contrasenia
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'Escriba su dirección de domicilio',
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 38,
                      minWidth: 38,
                    ),
                    label: const Text(
                      "Dirección de domicilio",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (showError.value) ...[
                const Text(
                  'No se pudo completar el registro',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                  ),
                ),
              ],
              const SizedBox(height: 15),
              SizedBox(
                width: 224,
                height: 38,
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // passwordController.text = value;
                  },
                  obscureText: isHidden.value, // esto oculta la contrasenia
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'Escriba su estado civil',
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 38,
                      minWidth: 38,
                    ),
                    label: const Text(
                      "Estado civil",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (showError.value) ...[
                const Text(
                  'No se pudo completar el registro',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                  ),
                ),
              ],
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const CustomButton(text: 'Guardar', colorBackground: primaryDark, colorText: whiteText, pushName: '/home_home'),
              ),
            ])));
  }
}
