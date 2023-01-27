import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SignUpEmailScreen extends StatefulWidget {
  const SignUpEmailScreen({super.key});

  @override
  State<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  String _email = "";
  String _password = "";
  bool _isHidden = true; //variable para controlar el mostrar password

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(0),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    // padding: EdgeInsets.all(6),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(primary_dark),
                    ),
                    child: Center(
                        child: Icon(
                      size: 20,
                      color: Color(primary_light),
                      Icons.arrow_back_ios_new_outlined,
                    )),
                  ),
                )),
            body: SingleChildScrollView(
                //Con este Widget hacemos que nuestro column sea adaptativo, cuando sale el teclado el column se ira hacia arriba

                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 70,
                height: 70,
                child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/logo_small.png",
                    )),
              ),
              SizedBox(height: 8),
              Container(
                  width: 224,
                  // height: 150,
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextPoppins(
                        text: 'Crea tu cuenta en Finniu y guarda tus datos',
                        colorText: black_text,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])),
              SizedBox(height: 10),
              TextPoppins(
                text: "Elige tu avatar",
                colorText: gray_text,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 15),
              Container(
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
              SizedBox(height: 20),
              Container(
                  width: 224,
                  height: 38,
                  child: ButtomDecoration(
                    textHint: 'Escriba su nombre favorito',
                    textLabel: "Nombre favorito",
                  )),
              SizedBox(height: 28),
              Container(
                  width: 224,
                  height: 38,
                  child: ButtomDecoration(
                    textHint: 'Escriba su número telefónico',
                    textLabel: "Número telefónico",
                  )),
              SizedBox(height: 28),
              Container(
                width: 224,
                height: 38,
                child: ButtomDecoration(
                  textHint: 'Escriba su correo electrónico',
                  textLabel: 'Correo electrónico',
                ),
              ),
              SizedBox(height: 28),
              Container(
                  width: 224,
                  height: 38,
                  child: TextField(
                    onChanged: (value) {
                      _password = value;
                    },

                    obscureText: _isHidden, // esto oculta la contrasenia
                    obscuringCharacter: '*', //el caracter el cual reemplaza la contrasenia
                    decoration: InputDecoration(
                      hintText: 'Digite su contraseña',
                      hintStyle: fontPoppins(fontSize: 11, colorHex: secondary_text_light, fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off, color: Color(primary_dark), size: 23.20),
                        alignment: Alignment.topRight,
                        onPressed: () {
                          _togglePasswordView();
                        },
                      ),
                      label: Text(
                        "Contraseña",
                        style: fontInter(fontSize: 12, colorHex: primary_dark, fontWeight: FontWeight.w600),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide(color: const Color(primary_dark))),
                    ),
                    controller: TextEditingController(text: _password),
                  )),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 224,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(primary_dark),
                ),
                child: Center(child: CustomButton(text: 'Crear registro', colorBackground: primary_dark, colorText: white_text, pushName: '/sign_up_welcome')),
              ),
              SizedBox(height: 2),
              Container(
                  child: Center(
                      child: TextPoppins(
                text: '¿Ya tienes una cuenta creada?',
                colorText: black_text,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ))),
              SizedBox(height: 2),
              Container(
                  child: Center(
                      child: TextPoppins(
                text: 'Iniciar sesión',
                colorText: primary_dark,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ))),
            ]))));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
