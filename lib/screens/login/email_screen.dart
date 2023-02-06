import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        //Con este Widget hacemos que nuestro column sea adaptativo, cuando sale el teclado el column se ira hacia arriba
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 224,
              // height: 143,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  themeProvider.isDarkMode
                      ? "assets/images/logo_finniu_dark.png"
                      : "assets/images/logo_finniu_light.png",
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextPoppins(
                text: '¡Bienvenido a Finniu!',
                colorText: themeProvider.isDarkMode ? skyBlueText : primaryDark,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 224,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextPoppins(
                      text: 'Ingresa a tu cuenta',
                      colorText:
                          themeProvider.isDarkMode ? whiteText : blackText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 224,
                    height: 38,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Escriba su correo electrónico',
                        label: Text(
                          "Correo electrónico",
                        ),
                      ),
                      controller: TextEditingController(text: _email),
                    ),
                  ),
                  const SizedBox(height: 29),
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
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 23.20),
                            alignment: Alignment.topRight,
                            onPressed: () {
                              _togglePasswordView();
                            },
                          ),
                          label: const Text(
                            "Contraseña",
                          ),
                          isDense: true,
                          enabled: true),
                      controller: TextEditingController(text: _password),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login_forgot');
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextPoppins(
                        text: '¿Olvidaste tu contraseña?',
                        colorText:
                            themeProvider.isDarkMode ? whiteText : blackText,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const CustomButton(
                    text: 'Ingresar',
                    pushName: '/login_email',
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextPoppins(
                      text: '¿Aún no tienes una cuenta creada?',
                      colorText:
                          themeProvider.isDarkMode ? whiteText : blackText,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign_up_email');
                    },
                    child: Center(
                      child: TextPoppins(
                        text: 'Registrarme',
                        colorText: themeProvider.isDarkMode
                            ? skyBlueText
                            : primaryDark,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
