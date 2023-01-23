import 'package:finniu/constants/colors.dart';
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

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  width: 70,
                  height: 70,
                  child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/Rectangle.png",
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('¡Registrate ahora!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(primary_dark),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
                SizedBox(height: 8),
                Container(
                    width: 224,
                    // height: 150,
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                            Text('Crea tu cuenta en Finniu y guarda tus datos',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Color(blacktext),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))),
                      ),
                    ])),
                SizedBox(height: 14),
                Text("Elige tu avatar",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(gray_text),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ))),
                SizedBox(height: 15),
                Container(
                  width: 224,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 145.0,
                      viewportFraction: 0.8,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            // width: 157,
                            // height: 145,
                            // width: MediaQuery.of(context).size.width / 4,
                            // margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/avatar.png",
                                )),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 224,
                  height: 38,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escriba su nombre favorito',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(secondary_text_light),
                              fontSize: 11)),
                      label: Text(
                        "Nombre favorito",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          color: Color(primary_dark),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: const Color(primary_dark),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 224,
                  height: 38,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escriba su número telefónico',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(secondary_text_light),
                              fontSize: 11)),
                      label: Text(
                        "Número telefónico",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          color: Color(primary_dark),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: const Color(primary_dark),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 224,
                  height: 38,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escriba su correo electrónico',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(secondary_text_light),
                              fontSize: 11)),
                      label: Text(
                        "Correo electrónico",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          color: Color(primary_dark),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: const Color(primary_dark),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 30),
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
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color(secondary_text_light),
                                fontSize: 11)),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(primary_dark),
                              size: 23.20),
                          alignment: Alignment.topRight,
                          onPressed: () {
                            _togglePasswordView();
                          },
                        ),
                        label: Text(
                          "Contraseña",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            color: Color(primary_dark),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: const Color(primary_dark))),
                      ),
                      controller: TextEditingController(text: _password),
                    )),
                SizedBox(height: 25),
                Container(
                    height: 50,
                    width: 224,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(primary_dark),
                    ),
                    child: Center(
                        child: Text('Crear registro',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(whitetext),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ))))),
                SizedBox(height: 35)
              ]))),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
