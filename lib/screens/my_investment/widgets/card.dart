// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandableCard extends HookWidget {
  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textContainer;
  ExpandableCard({
    super.key,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardCustom(
            isExpanded: isExpanded,
            image: image,
            textContainer: textContainer,
            textPercentage: textPercentage,
            textinvestment: textinvestment,
            textTiledCard: textTiledCard,
          ),
          if (!isExpanded.value) ...[
            InitialCardBody(
              image: image,
              textPercentage: textPercentage,
              textinvestment: textinvestment,
            ),
          ]
        ],
      ),
    );
  }
}

class CardCustom extends StatelessWidget {
  const CardCustom({
    Key? key,
    required this.isExpanded,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
  }) : super(key: key);

  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textContainer;
  final ValueNotifier<bool> isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 320,
        // height: 62,
        child: ExpansionTileCard(
          onExpansionChanged: (value) {
            print('Expansion Value $value');
            isExpanded.value = value;
          },
          title: Padding(
            padding: EdgeInsets.only(left: 27),
            child: Text(
              textTiledCard,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: SizedBox(
            width: 80,
            // height: 30,
            child: Row(
              children: [
                Text(
                  'Ver más',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(cardBackgroundColorLight),
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          baseColor: Color(primaryDark),
          expandedColor: Color(primaryDark),
          elevation: 2.0,
          children: [
            Container(
              alignment: Alignment.topLeft,
              color: Color(gradient_secondary),
              width: 320,
              height: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            image,
                            width: 90,
                            height: 90,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons
                                      .monetization_on_outlined, // Icono que deseas utilizar
                                  size: 21.5, // Tamaño del icono
                                  color: Color(primaryDark), // Color del icono
                                ),
                                Text(
                                  "Monto minimo",
                                  style: TextStyle(
                                    fontSize: 10, // Tamaño de fuente
                                    color: Color(primaryDark), // Color de texto
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  textinvestment,
                                  style: TextStyle(
                                    fontSize: 12, // Tamaño de fuente
                                    color: Color(primaryDark), // Color de texto
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Icon(
                                Icons
                                    .currency_exchange_rounded, // Icono que deseas utilizar
                                size: 21.5, // Tamaño del icono
                                color: Color(primaryDark), // Color del icono
                              ),
                              Text(
                                "Retorno anual",
                                style: TextStyle(
                                  fontSize: 10, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                textPercentage,
                                style: TextStyle(
                                  fontSize: 12, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Icon(
                                Icons
                                    .percent_sharp, // Icono que deseas utilizar
                                size: 21.5, // Tamaño del icono
                                color: Color(primaryDark), // Color del icono
                              ),
                              Text(
                                "Declaración a la Sunat",
                                style: TextStyle(
                                  fontSize: 10, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                textPercentage,
                                style: TextStyle(
                                  fontSize: 12, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              )
                            ],
                          ),

                          // Aquí pueden ir otros widgets adicionales
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        16.0), // aquí puedes configurar la cantidad de padding
                    child: Center(
                      child: Text(
                        textContainer,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(blackText),
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class InitialCardBody extends StatelessWidget {
  const InitialCardBody({
    Key? key,
    required this.image,
    required this.textPercentage,
    required this.textinvestment,
  }) : super(key: key);
  final String image;
  final String textPercentage;
  final String textinvestment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 130,
      decoration: BoxDecoration(
        // border: Border.all(color: Color(primaryDark), width: 2.0),
        border: Border(
          top: BorderSide(color: Color(primaryDark), width: 2.0),
          left: BorderSide(color: Color(primaryDark), width: 2.0),
          right: BorderSide(color: Color(primaryDark), width: 2.0),
          bottom: BorderSide(color: Color(primaryDark), width: 2.0),
        ),

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            // height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 70,
                  child: Transform.translate(
                    offset: const Offset(0.0, -30.0),
                    child: Image.asset(
                      image,
                      width: 90, // Establecer el ancho de la imagen
                      height: 70, // Establecer el alto de la imagen
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 82,
                  // height: 34,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(gradient_secondary), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(gradient_secondary),
                  ),
                  child: Center(
                    child: Text(
                      "$textinvestment Monto minimo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 82,
                  // height: 34,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(primaryLightAlternative), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(primaryLightAlternative),
                  ),
                  child: Center(
                    child: Text(
                      "$textPercentage Retorno anual",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 32,
            width: 152,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(primaryDark),
            ),
            child: Center(
              child: CustomButton(
                  colorBackground: (primaryDark),
                  text: "Comenzar a invertir",
                  colorText: (whiteText),
                  pushName: '/home_home'),
            ),
          )
        ],
      ),
    );
  }
}