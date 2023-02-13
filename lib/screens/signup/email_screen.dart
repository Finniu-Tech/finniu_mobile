import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class SignUpEmailScreen extends HookWidget {
  SignUpEmailScreen({super.key});
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//   @override
//   State<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
// }

// class _SignUpEmailScreenState extends State<SignUpEmailScreen> {

  @override
  Widget build(BuildContext context) {
    // String _password = "";
    final isHidden = useState(true);
    final showError = useState(false);

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: Form(
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
                      themeProvider.isDarkMode
                          ? "assets/images/logo_small_dark.png"
                          : "assets/images/logo_small.png",
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
                          colorText: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .color!
                              .value,
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
                  width: 224,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 145.0,
                      viewportFraction: 0.8,
                    ),
                    items: [
                      'assets/avatars/avatar_1.png',
                      'assets/avatars/avatar_2.png',
                      'assets/avatars/avatar_3.png',
                      'assets/avatars/avatar_4.png',
                      'assets/avatars/avatar_5.png',
                      'assets/avatars/avatar_6.png',
                      'assets/avatars/avatar_7.png',
                      'assets/avatars/avatar_8.png',
                      'assets/avatars/avatar_9.png',
                      'assets/avatars/avatar_10.png',
                      'assets/avatars/avatar_11.png',
                    ].map((image_route) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                image_route,
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
                    onChanged: (value) {
                      nickNameController.text = value.toString();
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
                    onChanged: (value) {
                      phoneController.text = value;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Escriba su número telefónico',
                      label: Text("Número telefónico"),
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
                    onChanged: (value) {
                      emailController.text = value.toString();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escriba su correo electrónico',
                      label: Text('Correo electrónico'),
                    ),
                  ),
                  // height: 38,

                  // child: ButtonDecoration(
                  //   textHint: 'Escriba su correo electrónico',
                  //   textLabel: 'Correo electrónico',
                  // ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: TextFormField(
                    onChanged: (value) {
                      passwordController.text = value;
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
                          isHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                    controller: passwordController,
                  ),
                ),
                const SizedBox(height: 20),
                const CustomButton(
                  text: 'Crear registro',
                  pushName: '/on_boarding_start',
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
                      foregroundColor: themeProvider.isDarkMode
                          ? const Color(skyBlueText)
                          : const Color(primaryDark),
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
  // void _togglePasswordView() {
  //   setState(() {
  //     _isHidden = !_isHidden;
  //   });
  // }

