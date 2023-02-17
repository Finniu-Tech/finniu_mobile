import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class InvestmentStart extends StatelessWidget {
  const InvestmentStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              height: 62,
              child: Row(
                children: const [
                  Expanded(
                    child: ExpansionTileCard(
                      title: Text(
                        'Plan Origen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(primaryLight),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      baseColor: Color(primaryDark),
                      elevation: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 320,
              height: 200,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.blue, width: 2.0),
                  ),
              // color: Colors.white,
              child: const Center(
                child: Text(
                  'Contenido del nuevo contenedor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


    // bottomNavigationBar: const BottomNavigationBarHome(),
    // body: Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 60,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Container(
    //             height: 60,
    //             width: 60,
    //             alignment: Alignment.topLeft,
    //             child: Image.asset('assets/images/logo_small.png'),
    //           ),
    //           const Spacer(),
    //           Container(
    //             width: 50,
    //             height: 50,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: Icon(
    //               CupertinoIcons.bell,
    //             ),
    //           ),
    //           Container(
    //             height: 43,
    //             width: 41,
    //             alignment: Alignment.topRight,
    //             child: Image.asset('assets/home/avatar.png'),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         alignment: Alignment.topLeft,
    //         child: const Text(
    //           'Mis inversiones',
    //           style: TextStyle(
    //             fontSize: 24,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 15.0,
    //       ),
    //       Container(
    //         alignment: Alignment.topLeft,
    //         width: MediaQuery.of(context).size.width * 0.8,
    //         height: 129.0,
    //         decoration: BoxDecoration(
    //           color: Color(gradient_secondary_option),
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //         child: Row(
    //           children: [
    //             SizedBox(height: 103, width: 109, child: Image.asset('assets/investment/investment.png')),
    //             const Expanded(
    //               child: Text(
    //                 'Hola Mari, puedes visualizar nuestros planes y simular tu inversión para comenzar a invertir desde hoy',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   height: 1.5,
    //                   fontSize: 14,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       Row(
    //         children: [
    //           const Text(
    //             'Planes de inversión',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               height: 1.5,
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Color(primaryDark),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 40,
    //           ),
    //           ElevatedButton(
    //             style: ButtonStyle(
    //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
    //               backgroundColor: MaterialStateProperty.all<Color>(Color(primaryLight)),
    //               // fixedSize: MaterialStateProperty.all<Size>(
    //               //   Size(132, 32),
    //               // ),
    //             ),
    //             onPressed: () {},
    //             child: const Text(
    //               "Agendar sesión 1:1",
    //               style: TextStyle(
    //                 color: Color(primaryDark),
    //                 decoration: TextDecoration.underline,
    //                 decorationColor: Color(primaryDark),
    //                 // decorationThickness: 2,
    //                 fontSize: 12,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // ),
