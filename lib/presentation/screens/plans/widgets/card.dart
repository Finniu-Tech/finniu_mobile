// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:finniu/constants/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpandableCard extends HookConsumerWidget {
  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textDeclaration;
  final String textContainer;
  final String planUuid;
  final String? objective;
  final String? imgDistribution;
  List<String?> features = [];

  ExpandableCard({
    super.key,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
    required this.textDeclaration,
    required this.planUuid,
    this.objective,
    this.imgDistribution,
    this.features = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            planUuid: planUuid,
            objective: objective,
            imgDistribution: imgDistribution,
            features: features,
          ),
          if (!isExpanded.value) ...[
            InitialCardBody(
              image: image,
              textPercentage: textPercentage,
              textinvestment: textinvestment,
              planUuid: planUuid,
            ),
          ]
        ],
      ),
    );
  }
}

Widget loadImage(String imagePath) {
  if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
    return Image.network(imagePath, width: 90, height: 90);
  } else {
    return Image.asset(imagePath, width: 90, height: 90);
  }
}

class CardCustom extends ConsumerWidget {
  CardCustom({
    Key? key,
    required this.isExpanded,
    required this.image,
    required this.textTiledCard,
    required this.textPercentage,
    required this.textinvestment,
    required this.textContainer,
    required this.textDeclaration,
    required this.planUuid,
    this.objective,
    this.imgDistribution,
    this.features = const [],
  }) : super(key: key);

  final String image;
  final String textTiledCard;
  final String textPercentage;
  final String textinvestment;
  final String textContainer;
  final String textDeclaration;
  final String planUuid;
  final String? objective;
  final String? imgDistribution;
  List<String?> features = [];
  final ValueNotifier<bool> isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return SizedBox(
      width: 350,
      // height: double.infinity,
      child: ExpansionTileCard(
        onExpansionChanged: (value) {
          isExpanded.value = value;
        },
        title: Text(
          textTiledCard,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(
              currentTheme.isDarkMode ? primaryDark : whiteText,
            ),
          ),
        ),
        trailing: SizedBox(
          width: 85,
          // height: 30,
          child: Row(
            children: [
              Text(
                'Ver más',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(
                    currentTheme.isDarkMode ? primaryDark : whiteText,
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
                  isExpanded.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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

          // bottomLeft: Radius.circular(30),
          // bottomRight: Radius.circular(30),
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
            width: 350,
            height: 810,
            decoration: BoxDecoration(
              color: Color(
                currentTheme.isDarkMode ? primaryLightAlternative : colortext,
              ),
              border: Border.all(
                color: Color(
                  currentTheme.isDarkMode ? primaryLightAlternative : colortext,
                ),
                width: 2.0,
              ),
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(30),
              //   bottomRight: Radius.circular(30),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            image,
                            width: 90,
                            height: 90,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.monetization_on_outlined, // Icono que deseas utilizar
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

                          const SizedBox(height: 20),

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
                              const SizedBox(width: 5),
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
                    padding: const EdgeInsets.all(25.0), // aquí puedes configurar la cantidad de padding
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
                  const SizedBox(
                    height: 10,
                  ),
                  if (objective != '') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/star.png",
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          "Objetivo",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(primaryDark),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        width: 236,
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  objective!,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w400, height: 1.5, color: Color(blackText)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 5,
                  ),
                  if (features.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/shield-tick.png",
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          "Características del fondo",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(primaryDark)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    for (var feature in features) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Row(
                          children: [
                            if (features.length > 1) ...[
                              const Text(
                                "•",
                                style: TextStyle(color: Color(blackText)),
                              ),
                            ],
                            // const Text(
                            //   "•",
                            //   style: TextStyle(color: Color(blackText)),
                            // ),
                            Text(
                              feature!,
                              style: TextStyle(fontSize: 9, color: Color(blackText)),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(
                      height: 8,
                    ),

                    if (imgDistribution != "") ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/graph.png",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Distribución del Fondo",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(primaryDark)),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          // Texto encima de la imagen
                          SizedBox(
                            width: double.infinity,
                            // height: 150,
                            child: imgDistribution != ""
                                ? Image.network(
                                    imgDistribution!,
                                    width: double.infinity,
                                    // Establecer el ancho de la imagen
                                    // height:
                                    //     150, // Establecer el alto de la imagen
                                  )
                                : const Text(""),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ), // Espacio entre los textos y el botón
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/investment_step1',
                            arguments: {
                              'planUuid': planUuid,
                            },
                          );
                        },
                        child: Text('Comenzar a invertir',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(whiteText),
                            )),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(4),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                              // vertical: 10,
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(primaryDark),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
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
    required this.planUuid,
  }) : super(key: key);
  final String image;
  final String textPercentage;
  final String textinvestment;
  final String planUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return Container(
      width: 350,
      height: 130,
      decoration: BoxDecoration(
        // border: Border.all(color: Color(primaryDark), width: 2.0),
        border: Border(
          top: BorderSide(color: Color(currentTheme.isDarkMode ? (primaryLight) : (primaryDark)), width: 2.0),
          left: BorderSide(color: Color(currentTheme.isDarkMode ? (primaryLight) : (primaryDark)), width: 2.0),
          right: BorderSide(color: Color(currentTheme.isDarkMode ? (primaryLight) : (primaryDark)), width: 2.0),
          bottom: BorderSide(color: Color(currentTheme.isDarkMode ? (primaryLight) : (primaryDark)), width: 2.0),
        ),

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            // height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  height: 70,
                  child: Transform.translate(
                    offset: const Offset(0.0, -30.0),
                    child: loadImage(
                      image,
                      // width: 90, // Establecer el ancho de la imagen
                      // height: 70, // Establecer el alto de la imagen
                    ),
                    // child: Image.asset(
                    //   image,
                    //   width: 90, // Establecer el ancho de la imagen
                    //   height: 70, // Establecer el alto de la imagen
                    // ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 90,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(gradient_secondary), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: const Color(gradient_secondary),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          textinvestment,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
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
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 90,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(primaryLightAlternative),
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: const Color(primaryLightAlternative),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            textPercentage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
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
            ),
          ),
          Container(
            height: 32,
            width: 148,
            alignment: Alignment.center,
            child: Center(
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(4),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 10,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/investment_step1',
                    arguments: {
                      'planUuid': planUuid,
                    },
                  );
                },
                child: Text(
                  "Comenzar a invertir",
                  style: TextStyle(
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(whiteText),
                    fontSize: 11.0,
                  ),
                  maxLines: 1,
                ),
              ),
              // child: CustomButton(
              //   colorBackground:
              //       currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
              //   text: "Comenzar a invertir",
              //   colorText:
              //       currentTheme.isDarkMode ? (primaryDark) : (whiteText),
              //   pushName: '/investment_step1',
              // ),
            ),
          )
        ],
      ),
    );
  }
}

// class NewsContainer extends HookConsumerWidget {
//   final String titleNews;
//   final String descripctionNews;
//   final String imageLink;

//   const NewsContainer({
//     super.key,
//     required this.titleNews,
//     required this.descripctionNews,
//     required this.imageLink,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = ref.watch(settingsNotifierProvider);
//     return Container(
//       width: 330,
//       // height: ,
//       child: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Container(
//               constraints: const BoxConstraints(maxWidth: 330, maxHeight: 147),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 1.5,
//                   color: currentTheme.isDarkMode
//                       ? const Color(primaryLight)
//                       : const Color(primaryDark),
//                 ),
//                 color: currentTheme.isDarkMode
//                     ? const Color(primaryLightAlternative)
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 height: 144,
//                 width: 141,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     bottomLeft: Radius.circular(20),
//                   ),
//                   image: DecorationImage(
//                     image: AssetImage(imageLink),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 // width: 320,
//                 height: 147,
//                 padding: EdgeInsets.only(
//                   left: 90,
//                   top: 20,
//                 ),
//                 child: Container(
//                   width: 160,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         titleNews,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Color(primaryDark),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         descripctionNews,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(grayText2),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }