import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Alert1());

class Alert1 extends StatelessWidget {
  const Alert1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 10,
      backgroundColor: const Color(primaryDark),
      content: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/images/magnifying_glass.png'),
                    ),
                    SizedBox(
                      width: 260,
                      child: Text(
                        "Hola Mari, de acuerdo al artículo 1646 del Código Civil, el pago de los intereses del contrato de mutuo se deben realizar en la misma cuenta bancaria desde donde se realizó la transferencia, por eso es importante, para nosotros, conocer tu cuenta bancaria a CCI.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: const Color(primaryLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  var ctx;
                  Navigator.of(ctx!).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
