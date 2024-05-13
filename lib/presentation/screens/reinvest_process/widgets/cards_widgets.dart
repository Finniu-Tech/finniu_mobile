import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreditCardWidget extends StatelessWidget {
  final String imageAsset;
  final String cardHolderName;
  final String lastFourDigits;
  final Function onTap;

  const CreditCardWidget({
    super.key,
    required this.imageAsset,
    required this.onTap,
    required this.cardHolderName,
    required this.lastFourDigits,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: 288.3,
        height: 171.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              '$cardHolderName\n**** $lastFourDigits',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardWheel extends StatefulWidget {
  const CreditCardWheel({super.key});

  @override
  _CreditCardWheelState createState() => _CreditCardWheelState();
}

class _CreditCardWheelState extends State<CreditCardWheel> {
  List<String> cards = [
    'assets/credit_cards/golden_card.png', //961x572
    'assets/credit_cards/gray_card.png',
    'assets/credit_cards/light_blue.png',
    'assets/credit_cards/golden_card.png',
    'assets/credit_cards/blue_card.png',
  ];
  bool showDetail = false;
  String selectedImage = '';
  FixedExtentScrollController? controller;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController(initialItem: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: showDetail
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 299,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'BBVA | Compras',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(primaryDark),
                        ),
                      ),
                      const Spacer(),
                      //asset icon
                      Image.asset(
                        'assets/icons/square2.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 299,
                  child: Text(
                    'Cuenta Soles  **** 1234',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 20),
                CreditCardWidget(
                  imageAsset: selectedImage,
                  onTap: () {
                    setState(() {
                      showDetail = false;
                    });
                  },
                  cardHolderName: 'test',
                  lastFourDigits: '1234',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 299,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Asegúrate de que este valor sea el mismo que en RoundedRectangleBorder
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Ajusta este valor para cambiar la posición de la sombra
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(primaryLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/square2.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Agregar cuenta bancaria',
                          style: TextStyle(color: Color(primaryDark), fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 299,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Asegúrate de que este valor sea el mismo que en RoundedRectangleBorder
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Ajusta este valor para cambiar la posición de la sombra
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(primaryDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/square2.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Confirmar cuenta',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     //asset icon
                //     Image.asset(
                //       'assets/icons/square2.png',
                //       width: 24,
                //       height: 24,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     const Text(
                //       'Selecciona tu cuenta bancaria',
                //       style: TextStyle(
                //         fontSize: 14,
                //         color: Color(primaryDark),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                SizedBox(
                  height: 280,
                  child: ListWheelScrollView.useDelegate(
                    controller: controller,
                    itemExtent: 150,
                    diameterRatio: 2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return CreditCardWidget(
                          cardHolderName: 'Nombre$index',
                          lastFourDigits: '123$index',
                          imageAsset: cards[index % cards.length],
                          onTap: () {
                            if (!showDetail) {
                              setState(() {
                                showDetail = true;
                                selectedImage = cards[index % cards.length];
                              });
                            }
                          },
                        );
                      },
                      childCount: cards.length * 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 299,
                  height: 50,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(primaryLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/square2.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Agregar cuenta bancaria',
                          style: TextStyle(color: Color(primaryDark), fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
