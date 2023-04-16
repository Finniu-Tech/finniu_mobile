// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpandableCard extends HookConsumerWidget {
  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textDeclaration;
  final String textContainer;
  ExpandableCard({
    super.key,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
    required this.textDeclaration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
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
            textDeclaration: textDeclaration,
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

class CardCustom extends ConsumerWidget {
  const CardCustom({
    Key? key,
    required this.isExpanded,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
    required this.textDeclaration,
  }) : super(key: key);

  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textContainer;
  final String textDeclaration;
  final ValueNotifier<bool> isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return SizedBox(
        width: 320,
        // height: 62,
        child: ExpansionTileCard(
          onExpansionChanged: (value) {
            isExpanded.value = value;
          },
          title: Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text(
              textTiledCard,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(
                  currentTheme.isDarkMode ? (primaryDark) : (primaryLightAlternative),
                ),
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
                    fontSize: 10,
                    color: Color(
                      currentTheme.isDarkMode ? (primaryDark) : (whiteText),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(
                    currentTheme.isDarkMode ? (primaryDark) : (primaryLightAlternative),
                  ),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Color(
                      currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
                    ),
                  ),
                )
              ],
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          baseColor: Color(
            currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
          ),
          expandedColor: Color(
            currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
          ),
          elevation: 2.0,
          children: [
            Container(
              alignment: Alignment.topLeft,
              color: Color(
                currentTheme.isDarkMode ? primaryLightAlternative : colortext,
              ),
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
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons
                                    .monetization_on_outlined, // Icono que deseas utilizar
                                size: 21.5, // Tamaño del icono
                                color: Color(primaryDark), // Color del icono
                              ),
                              const Text(
                                "Monto minimo",
                                style: TextStyle(
                                  fontSize: 10, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                textinvestment,
                                style: const TextStyle(
                                  fontSize: 12, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Image.asset(
      'assets/icons/double_dollar.png', 
      width: 25,
      height: 25, 
    ),
                              const Text(
                                "Retorno anual",
                                style: TextStyle(
                                  fontSize: 10, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                textPercentage,
                                style: const TextStyle(
                                  fontSize: 12, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                                  Image.asset(
      'assets/icons/percent.png', 
      width: 20,
      height: 20, 
    ),
              
                              const Text(
                                // textAlign: TextAlign.end,
                                " Declaración a la Sunat",
                                style: TextStyle(
                                  fontSize: 10, // Tamaño de fuente
                                  color: Color(primaryDark), // Color de texto
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                textDeclaration,
                                style: const TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.all(
                        25.0), // aquí puedes configurar la cantidad de padding
                    child: Center(
                      child: Text(
                        textContainer,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(blackText),
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                
                
                 Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 3,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(gradient_secondary_option),
                    width: 1.2,
                  ),
                ),
              ),
            ),
                
                
            
                
                
                ],
              ),
            )
          ],
        ),
        );
  }
}

class InitialCardBody extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return Container(
        width: 320,
        height: 130,
        decoration: BoxDecoration(
          // border: Border.all(color: Color(primaryDark), width: 2.0),
          border: Border(
            top: BorderSide(
                color: Color(
                    currentTheme.isDarkMode ? (primaryLight) : (primaryDark)),
                width: 2.0),
            left: BorderSide(
                color: Color(
                    currentTheme.isDarkMode ? (primaryLight) : (primaryDark)),
                width: 2.0),
            right: BorderSide(
                color: Color(
                    currentTheme.isDarkMode ? (primaryLight) : (primaryDark)),
                width: 2.0),
            bottom: BorderSide(
                color: Color(
                    currentTheme.isDarkMode ? (primaryLight) : (primaryDark)),
                width: 2.0),
          ),

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
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
              const SizedBox(width: 10),
              Container(
                  width: 82,
                  // height: 34,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(gradient_secondary), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(gradient_secondary),
                  ),
                  child: Column(
                    children: [
                      Text(
                        textinvestment,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                      const Text(
                        "Monto minimo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(width: 12),
              Container(
                width: 82,
                // height: 34,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(primaryLightAlternative), width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: const Color(primaryLightAlternative),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        textPercentage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                      const Text(
                        "Retorno Anual",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          Container(
            height: 32,
            width: 152,
            alignment: Alignment.center,
            decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
             
              color: Color(primaryDark),
            ),
            child: Center(
              child: CustomButton(
                  colorBackground:
                      currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
                  text: "Comenzar a invertir",
                  colorText:
                      currentTheme.isDarkMode ? (primaryDark) : (whiteText),
                  pushName: '/investment_step1'),
            ),
          )
        ]));
  }
}
