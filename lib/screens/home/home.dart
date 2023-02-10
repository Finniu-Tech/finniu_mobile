import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/cardtable.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class HomeStart extends StatefulWidget {
  const HomeStart({super.key});

  @override
  State<HomeStart> createState() => _HomeStartState();
}

class _HomeStartState extends State<HomeStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/logo_finniu_home.png'),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Hola,Mari!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(blackText),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  SizedBox(
                    child: Container(
                      width: 24,
                      height: 23.84,
                      child: Icon(Icons.notifications_active),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: 41,
                    height: 43,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset('assets/home/avatar.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Multiplica tu dinero con nosotros!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(primaryDark),
                    ),
                  ),
                ),
              ),
              CardTable(),
              Row(
                children: [
                  Container(
                      width: 320.0,
                      height: 1,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(primaryDark),
                            width: 0,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                children: <Widget>[
                  Card(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  Container(
                    height: 147,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color(primaryLightAlternative),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Positioned(
                            left: 200,
                            child: Container(
                              height: 147,
                              width: 320,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/home/person.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Simula tu inversión aquí",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(primaryDark),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "Descubre como simular el",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(grayText2),
                                ),
                              ),
                              Text(
                                "retorno de tu inversión",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(grayText2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: 24,
                  //   height: 23.84,
                  //   child: Icon(Icons.arrow_circle_right),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
