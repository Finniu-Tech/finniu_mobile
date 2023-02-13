import 'package:finniu/constants/colors.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/cardtable.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomeStart extends StatelessWidget {
  HomeStart({super.key});
  bool show = true;

  void _showSettingsDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) => Dialog(
            backgroundColor: Color(secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                width: 331,
                height: 525,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              color: Color(primaryDark),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(
                              size: 20,
                              Icons.close,
                              color: Color(secondaryLight),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                child: Image.asset("assets/home/avatar.png"),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  const Text(
                                    "Mari",
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  TextPoppins(
                                      text: 'Light mode',
                                      colorText: Theme.of(ctx).colorScheme.primary.value,
                                      // colorText: ,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(width: 5),
                                  FlutterSwitch(
                                    width: 45,
                                    height: 24,
                                    value: Preferences.isDarkMode,
                                    inactiveColor: const Color(primaryDark),
                                    activeColor: const Color(primaryLight),
                                    inactiveToggleColor: const Color(primaryLight),
                                    activeToggleColor: const Color(primaryDark),
                                    onToggle: (value) {
                                      // Preferences.isDarkMode = value;
                                      // value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
                                      // setState(() {});
                                    },
                                  ),
                                ]),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "MarianaCPolo@gmail.com",
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: 12,
                                        color: Color(secondaryLight),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "S/4050",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Total invertido",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Color(primaryDark),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 60,
                            width: 2,
                            color: Color(primaryDark),
                          ),
                          Column(
                            children: const [
                              Text(
                                "2",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Planes invertidos",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Color(primaryDark),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person_outline),
                              SizedBox(width: 10),
                              Text("Editar mi perfil"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.privacy_tip_outlined),
                              SizedBox(width: 10),
                              Text("Privacidad"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.model_training),
                              SizedBox(width: 10),
                              Text("Mis transferencias"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.g_translate),
                              SizedBox(width: 10),
                              Text("Lenguajes"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.help_outline),
                              SizedBox(width: 10),
                              Text("Ayuda"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.logout),
                              SizedBox(width: 10),
                              Text("Cerrar sesión"),
                            ],
                          ),
                        ],
                      ),
                    ],

                    // title: Text("Alerta"),
                    // content: Text("¿Estas seguro de cerrar sesión?"),
                    // actions: [
                    //   TextButton(
                    //     onPressed: () {
                    //       Navigator.of(ctx).pop();
                    //     },
                    //     child: Text("Cancelar"),
                    //   ),
                    //   TextButton(
                    //     onPressed: () {
                    //       Navigator.of(ctx).pop();
                    //     },
                    //     child: Text("Aceptar"),
                    //   ),
                    // ],
                  ),
                ))));
  }

  void _showWelcomeModal(BuildContext ctx) {
    Future.delayed(
      Duration.zero,
      () async {
        showModalBottomSheet(
          // barrierColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
            ),
          ),
          elevation: 10,
          backgroundColor: const Color(primaryLight),
          context: ctx,
          builder: (ctx) => SizedBox(
            height: 476,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    child: Image.asset('assets/home/modal_info.png'),
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Color(primaryDark),
                        ),
                        "Hola Mari,recuerda que es muy importante tener todos tus datos completos en la sección Editar perfil para que puedas realizar tu inversión con éxito."),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 132,
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0XFF68C3DE),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: Text(
                            "Saltar",
                            style: TextStyle(
                              color: Color(primaryDark),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 132,
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(primaryDark),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: Text(
                            "Completar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  // ElevatedButton(
                  //   child: const Text('Close BottomSheet'),
                  //   onPressed: () {
                  //     show = false;
                  //     Navigator.pop(ctx);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      _showWelcomeModal(context);
    }
    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                child: Image.asset('assets/images/logo_finniu_home.png'),
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
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  SizedBox(
                    child: Container(
                      width: 24,
                      height: 23.84,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/home_notification');
                          },
                          child: const Icon(Icons.notifications_active)),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      _showSettingsDialog(context);
                    },
                    child: SizedBox(
                      width: 41,
                      height: 43,
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/home/avatar.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
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
              const CardTable(),
              Container(
                  width: 320.0,
                  height: 2,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(primaryDark),
                        width: 0,
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
              Stack(
                children: <Widget>[
                  // Card(
                  //   shadowColor: Colors.transparent,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                  // ),
                  Container(
                    height: 147,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color(primaryLightAlternative),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Positioned(
                            // left: 100,
                            child: Container(
                              height: 147,
                              width: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/home/person.png"),
                                  fit: BoxFit.cover,
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
                              SizedBox(
                                height: 10,
                              ),
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
                              CustomButtonRoundedDark(
                                pushName: "",
                              )
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
