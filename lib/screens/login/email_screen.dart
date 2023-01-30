import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  String _email = "";
  String _password = "";
  bool _isHidden = true; //variable para controlar el mostrar password

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturn(
        body: SingleChildScrollView(
            //Con este Widget hacemos que nuestro column sea adaptativo, cuando sale el teclado el column se ira hacia arriba
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 30,
      ),
      Container(
        width: 224,
        height: 143,
        child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/logo_finniu_light.png",
            )),
      ),
      Align(
          alignment: Alignment.center,
          child: TextPoppins(
            text: '¡Bienvenido a Finniu!',
            colorText: primaryDark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          )),
      SizedBox(height: 30),
      Container(
          width: 224,
          // height: 150,
          alignment: Alignment.topLeft,
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextPoppins(
                text: 'Ingresa a tu cuenta',
                colorText: blackText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            Container(
                width: 224,
                height: 38,
                child: TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Escriba su correo electrónico',
                    hintStyle: fontPoppins(
                        fontSize: 11,
                        colorHex: gray_text,
                        fontWeight: FontWeight.w400),
                    // hintStyle: GoogleFonts.poppins(
                    //     textStyle: TextStyle(
                    //         color: Color(secondary_text_light), fontSize: 11)),
                    label: Text(
                      "Correo electrónico",
                      style: fontInter(
                          colorHex: primaryDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: const Color(primaryDark),
                      ),
                    ),
                  ),
                  controller: TextEditingController(text: _email),
                )),
            SizedBox(height: 29),
            Container(
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
                    hintStyle: fontPoppins(
                        fontSize: 11,
                        colorHex: gray_text,
                        fontWeight: FontWeight.w400),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                          color: Color(primaryDark),
                          size: 23.20),
                      alignment: Alignment.topRight,
                      onPressed: () {
                        _togglePasswordView();
                      },
                    ),
                    label: TextInter(
                      text: "Contraseña",
                      fontSize: 12,
                      colorText: primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: const Color(primaryDark))),
                    isDense: true,
                    enabled: true),
                controller: TextEditingController(text: _password),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login_forgot');
              },
              child: Container(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: TextPoppins(
                        text: '¿Olvidaste tu contraseña?',
                        colorText: blackText,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ))),
            ),
            SizedBox(height: 15),
            Container(
                child: CustomButton(
                    text: 'Ingresar',
                    colorBackground: primaryDark,
                    colorText: white_text,
                    pushName: '/login_email')),
            SizedBox(height: 7),
            Container(
                child: Center(
                    child: TextPoppins(
              text: '¿Aún no tienes una cuenta creada?',
              colorText: blackText,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ))),
            SizedBox(height: 2),
            Container(
                child: Center(
                    child: TextPoppins(
              text: 'Registrarme',
              colorText: primaryDark,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            )))
          ]))
    ])));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
