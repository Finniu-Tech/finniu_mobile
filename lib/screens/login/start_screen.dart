import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

class StartLoginScreen extends StatefulWidget {
  const StartLoginScreen({super.key});

  @override
  State<StartLoginScreen> createState() => _StartLoginScreenState();
}

class _StartLoginScreenState extends State<StartLoginScreen> {
  bool _isSwitchOn =
      false; // agrega una variable para controlar el estado del switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(primary_light),
          title: Center(
            // alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Light mode",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: const Color(primary_dark),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(width: 5),
                FlutterSwitch(
                  width: 45,
                  height: 24,
                  value: _isSwitchOn,
                  inactiveColor: const Color(primary_dark),
                  activeColor: const Color(primary_light),
                  inactiveToggleColor: const Color(primary_light),
                  onToggle: (value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
                ),

                // Switch(
                //   value: _isSwitchOn,
                //   // activeColor: const Color(primary_light),
                //   // activeTrackColor: const Color(primary_light),
                //   inactiveTrackColor: const Color(primary_dark),
                //   inactiveThumbColor: const Color(primary_light),
                //   materialTapTargetSize: MaterialTapTargetSize.padded,
                //   onChanged: (bool value) {
                //     setState(() {
                //       _isSwitchOn = value;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                const Color(gradient_primary),
                const Color(gradient_secondary)
              ],
            )),
            child: Center(
                // padding: EdgeInsets.all(10),
                // margin: EdgeInsets.all(10),
                child: Container(
              padding: EdgeInsets.all(20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 224,
                  height: 188,
                  child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/logo_finniu_light.png",
                      )),
                ),
                Container(
                  width: 224,
                  height: 50,
                  child:
                      Text('Empieza a vivir una nueva experiencia con Finniu',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(primary_dark),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ))),
                ),
                Container(
                    margin: EdgeInsets.only(top: 35),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_email');
                        },
                        child: Container(
                            width: 230,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(primary_dark),
                            ),
                            child: Center(
                                child: Text('Iniciar Sesión',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: Color(whitetext),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ))))))),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login_registro');
                    },
                    child: Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(primary_light),
                        ),
                        child: Center(
                          child: Text('Registrarme',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(primary_dark),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ))),
                        )),
                  ),
                ),
              ]),
            ))));
  }
}
