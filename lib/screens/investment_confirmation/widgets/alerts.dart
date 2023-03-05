import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Alert1());

class Alert1 extends StatelessWidget {
  const Alert1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GeeksForGeeks"),
          backgroundColor: Colors.green,
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
            child: Center(
                child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Alert Dialog Box"),
                content: const Text("You have raised a Alert Dialog Box"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text("Show alert Dialog box"),
        ))));

    // Widget build(BuildContext context) {
    //   return AlertDialog(
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(50),
    // ),
    // elevation: 10,
    // backgroundColor: const Color(primaryDark),
//   content: [ Container(
//       width: double.infinity,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(40),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 60,
//                     height: 60,
//                     child: Image.asset('assets/images/magnifying_glass.png'),
//                   ),
//                   SizedBox(
//                     width: 260,
//                     child: Text(
//                       "Hola Mari, de acuerdo al artículo 1646 del Código Civil, el pago de los intereses del contrato de mutuo se deben realizar en la misma cuenta bancaria desde donde se realizó la transferencia, por eso es importante, para nosotros, conocer tu cuenta bancaria a CCI.",
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 12,
//                         height: 1.5,
//                         color: const Color(primaryLight),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 Navigator.of(ctx!).pop();
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
//
  }
}
