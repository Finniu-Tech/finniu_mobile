import 'package:email_validator/email_validator.dart';
import 'package:finniu/constants/avatars.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/signup_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/use_cases/user/signup.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO move mutation here from register
class SignUpEmailScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHidden = useState(true);
    final showError = useState(false);

    final UserProfile user = ref.watch(userProfileNotifierProvider);
    final nickNameController = useTextEditingController(text: user.nickName);
    final phoneController = useTextEditingController(
      text: user.phoneNumber,
    );
    final emailController = useTextEditingController(text: user.email);
    final passwordController = useTextEditingController(text: user.password);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final userAcceptedTerms = useState(false);
    CarouselController buttonCarouselController = CarouselController();

    final formKey = GlobalKey<FormState>();

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      themeProvider.isDarkMode ? "assets/images/logo_small_dark.png" : "assets/images/logo_small.png",
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 224,
                  // height: 150,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextPoppins(
                          text: 'Crea tu cuenta en Finniu y guarda tus datos',
                          colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const TextPoppins(
                  text: "Elige tu avatar",
                  colorText: grayText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 180,
                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 120.0,
                      viewportFraction: 0.8,
                      initialPage: ref.watch(indexAvatarSelectedStateProvider),
                      onPageChanged: (index, reason) {
                        ref.read(indexAvatarSelectedStateProvider.notifier).state = index;
                        // currentPage = index;
                        // setState((){});
                      },
                    ),
                    items: listAvatars.map((imageRoute) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                imageRoute,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    controller: nickNameController,
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
                      hintText: 'Escriba su nombre favorito',
                      label: Text("Nombre favorito"),
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
                        return 'Tiene que ser de 9 dígitos';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // phoneController.text = value;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: 'Escriba su número telefónico',
                      label: Text("Número telefónico"),
                    ),
                  ),
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
                      // Transforma el texto a minúsculas y actualiza el controlador
                      String lowerCaseValue = value.toLowerCase();
                      emailController.text = lowerCaseValue;
                      // Mueve el cursor al final del texto
                      emailController.selection =
                          TextSelection.fromPosition(TextPosition(offset: lowerCaseValue.length));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escriba su correo electrónico',
                      label: Text('Correo electrónico'),
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
                      hintText: 'Digite su contraseña',
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 38,
                        minWidth: 38,
                      ),
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          isHidden.value ? Icons.visibility : Icons.visibility_off,
                          size: 23.20,
                        ),
                        alignment: Alignment.center,
                        onPressed: () {
                          isHidden.value = !isHidden.value;
                        },
                      ),
                      label: const Text(
                        "Contraseña",
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 25,
                      child: Checkbox(
                        checkColor: Colors.white,
                        side: BorderSide(
                          color: themeProvider.isDarkMode ? Color(primaryLight) : Color(primaryDark), // Border color
                          width: 1.5, // Border width
                        ),
                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return themeProvider.isDarkMode
                                  ? Color(primaryLight)
                                  : Color(primaryDark); // Color when checkbox is selected (checked)
                            }
                            return themeProvider.isDarkMode
                                ? Color(primaryLight)
                                : Colors.transparent; // Color when checkbox is not selected (unchecked)
                          },
                        ),
                        value: userAcceptedTerms.value,
                        onChanged: (value) {
                          userAcceptedTerms.value = value!;
                        },
                      ),
                    ),
                    Text(
                      'Acepto las',
                      style: TextStyle(
                        fontSize: 10,
                        color: themeProvider.isDarkMode ? const Color(whiteText) : const Color(blackText),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Uri politicasURL = Uri.parse('https://finniu.com/terminos/');
                        launchUrl(politicasURL);
                      },
                      child: Text(
                        ' Las políticas de privacidad ',
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (showError.value) ...[
                  const Text(
                    'No se pudo completar el registro',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 5),
                SizedBox(
                  width: 224,
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      if (!userAcceptedTerms.value) {
                        return CustomSnackbar.show(
                          context,
                          'Necesita aceptar las políticas de privacidad',
                          'error',
                        );
                      }
                      context.loaderOverlay.show();
                      if (formKey.currentState!.validate()) {
                        ref.read(userProfileNotifierProvider.notifier).updateFields(
                              nickName: nickNameController.text,
                              password: passwordController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                            );

                        Future<bool> status = SignUpService().finishRegister(ref);
                        status.then((value) {
                          if (value) {
                            context.loaderOverlay.hide();
                            Navigator.of(context).pushNamed('/send_code');
                          } else {
                            context.loaderOverlay.hide();
                            showError.value = true;
                          }
                        });
                      }
                    },
                    child: const Text('Crear registro'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextPoppins(
                    text: '¿Ya tienes una cuenta creada?',
                    colorText: themeProvider.isDarkMode ? whiteText : blackText,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).backgroundColor,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      foregroundColor: themeProvider.isDarkMode ? const Color(skyBlueText) : const Color(primaryDark),
                    ),
                    child: const Text('Iniciar sesión'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_email');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
