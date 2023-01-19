import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:flutter/material.dart';

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
          title: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Light mode",
                  style: TextStyle(
                      color: const Color(primary_dark),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Switch(
                  value: _isSwitchOn,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
                ),
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
            child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
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
                      Text('Empieza a vivir una nueva experiencia con Finniu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(primary_dark_alternative),
                            fontSize: 20,
                          )),
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
                                child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 230,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(primary_light),
                            ),
                            child: Center(
                                child: Text(
                              'Registrarme',
                              style: TextStyle(
                                  color: const Color(primary_dark),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ]))));
  }
}
