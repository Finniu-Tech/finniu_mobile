import 'package:finniu/constants/colors.dart';
import 'package:finniu/models/user.dart';
import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/cardtable.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class HomeStart extends StatelessWidget {
  HomeStart({super.key});
  bool show = true;

  void _showSettingsDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) => Dialog(
            backgroundColor: const Color(secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                width: 331,
                height: 525,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 40,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 23,
                          width: 23,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: const Color(primaryDark),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: InkWell(
                            child: Icon(
                              size: 17,
                              Icons.close,
                              color: Color(primaryLight),
                            ),
                            onTap: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          // onPressed: () {
                          //   Navigator.of(ctx).pop();
                          // },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset("assets/home/avatar.png"),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Mari",
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    TextPoppins(
                                        text: 'Light mode',
                                        colorText: Theme.of(ctx)
                                            .colorScheme
                                            .primary
                                            .value,
                                        // colorText: ,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(width: 5),
                                    FlutterSwitch(
                                      width: 29,
                                      height: 16,
                                      value: Preferences.isDarkMode,
                                      inactiveColor: const Color(primaryDark),
                                      activeColor: const Color(primaryLight),
                                      inactiveToggleColor:
                                          const Color(primaryLight),
                                      activeToggleColor:
                                          const Color(primaryDark),
                                      onToggle: (value) {
                                        // Preferences.isDarkMode = value;
                                        // value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
                                        // setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 7,
                                // ),
                                Row(
                                  children: const [
                                    SizedBox(
                                      width: 10,
                                    ),
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
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "S/4050",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
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
                            color: const Color(primaryDark),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Text(
                                "2",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Planes invertidos",
                                textAlign: TextAlign.right,
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
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.person_2_outlined,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Editar mi perfil"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.privacy_tip_outlined,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Privacidad"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.model_training,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text("Mis transferencias"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.g_translate_outlined,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Lenguajes"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.help_outline,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Ayuda"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(primaryDark),
                                ),
                                // color: Color(primaryDark),

                                // color: Color(primaryLight),
                                child: InkWell(
                                  child: Icon(
                                    Icons.logout,
                                    color: Color(primaryLight),
                                  ),
                                  onTap: () {
                                    Navigator.of(ctx).pushNamedAndRemoveUntil(
                                        '/login', (route) => false);
                                  },
                                ),
                              ),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 132,
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFF68C3DE),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text(
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
                              const Color(primaryDark),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text(
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
                      child: Text(
                        'Hola, ${userProvider.nickName}',
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
                    decoration: const BoxDecoration(
                      color: Color(primaryLightAlternative),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
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
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
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
