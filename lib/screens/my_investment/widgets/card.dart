// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

class CartableInvestment extends StatelessWidget {
  const CartableInvestment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      textAlign: TextAlign.center,
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    baseColor: Color(primaryDark),
                    elevation: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 320,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(color: Color(primaryDark), width: 2.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/result/money.png',
                      width: 90, // Establecer el ancho de la imagen
                      height: 90, // Establecer el alto de la imagen
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 82,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(gradient_secondary), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(gradient_secondary),
                      ),
                      child: const Center(
                        child: Text(
                          'S/500 Monto minimo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 82,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(primaryLightAlternative), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(primaryLightAlternative),
                      ),
                      child: const Center(
                        child: Text(
                          '12 % Retorno anual',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 32,
                  width: 152,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(primaryDark),
                  ),
                  child: Center(child: CustomButton(colorBackground: (primaryDark), text: 'Comenzar a invertir ', colorText: (whiteText), pushName: '/home_home')),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
