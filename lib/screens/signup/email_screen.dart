import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class SignUpEmailScreen extends StatefulWidget {
  const SignUpEmailScreen({super.key});

  @override
  State<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  // String _email = "";
  String _password = "";
  bool _isHidden = true; //variable para controlar el mostrar password

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextPoppins(
                    text: 'Crea tu cuenta en Finniu y guarda tus datos',
                    colorText:
                        Theme.of(context).textTheme.titleLarge!.color!.value,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ])),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Elige tu avatar",
            colorText: gray_text,
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
                          )),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // ignore: sized_box_for_whitespace
          Container(
              width: 224,
              height: 38,
              child: const ButtonDecoration(
                textHint: 'Escriba su nombre favorito',
                textLabel: "Nombre favorito",
              )),
          const SizedBox(height: 28),
          // ignore: sized_box_for_whitespace
          Container(
              width: 224,
              height: 38,
              child: const ButtonDecoration(
                textHint: 'Escriba su número telefónico',
                textLabel: "Número telefónico",
              )),
          const SizedBox(height: 28),
          // ignore: sized_box_for_whitespace
          Container(
            width: 224,
            height: 38,
            child: const ButtonDecoration(
              textHint: 'Escriba su correo electrónico',
              textLabel: 'Correo electrónico',
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
              width: 224,
              height: 38,
              child: TextField(
                onChanged: (value) {
                  _password = value;
                },

                obscureText: _isHidden, // esto oculta la contrasenia
                obscuringCharacter:
                    '*', //el caracter el cual reemplaza la contrasenia
                decoration: InputDecoration(
                  hintText: 'Digite su contraseña',
                  // hintStyle: fontPoppins(
                  //     fontSize: 11,
                  //     colorHex: secondary_text_light,
                  //     fontWeight: FontWeight.w600),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        // color: const Color(primary_dark),
                        size: 23.20),
                    alignment: Alignment.topRight,
                    onPressed: () {
                      _togglePasswordView();
                    },
                  ),
                  label: Text(
                    "Contraseña",
                    // style: fontInter(
                    //     fontSize: 12,
                    //     colorHex: primary_dark,
                    //     fontWeight: FontWeight.w600),
                  ),
                  // border: OutlineInputBorder(
                  //     // borderRadius: BorderRadius.circular(25.0),
                  //     // borderSide: const BorderSide(color: Color(primary_dark)),
                  //     ),
                ),
                controller: TextEditingController(text: _password),
              )),
          const SizedBox(height: 20),

          CustomButton(
            text: 'Crear registro',
            // colorBackground: primary_dark,
            // colorText: white_text,
            pushName: '/on_boarding_welcome',
          ),

          // TextButton(
          //   style: TextButton.styleFrom(
          //     fixedSize: Size(224, 50),
          //     backgroundColor: Color(primaryDark),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(40),
          //     ),
          //   ),
          //   onPressed: () {},
          //   child: Text('dfdfddfdf'),
          // ),

          // Container(
          //   height: 50,
          //   width: 224,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     color: const Color(primaryDark),
          //   ),
          //   child: const Center(
          //     child: CustomButton(
          //         text: 'Crear registro',
          //         // colorBackground: primary_dark,
          //         // colorText: white_text,
          //         pushName: '/on_boarding_welcome'),
          //   ),
          // ),
          const SizedBox(height: 2),
          // ignore: avoid_unnecessary_containers
          Container(
            child: const Center(
              child: TextPoppins(
                text: '¿Ya tienes una cuenta creada?',
                colorText: blackText,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 2),
          // ignore: avoid_unnecessary_containers
          Container(
            child: const Center(
              child: TextPoppins(
                text: 'Iniciar sesión',
                colorText: primaryDark,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
