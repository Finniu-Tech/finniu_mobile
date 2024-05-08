// class InvestmentAmountCard extends StatelessWidget {
//   const InvestmentAmountCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CreditCardWidget extends StatelessWidget {
  String imageAsset;

  CreditCardWidget({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        print('Double tap');
      },
      onTap: () {
        print('Tap');
      },
      child: Container(
        width: 180, // Ancho de la tarjeta
        height: 143, // Alto de la tarjeta
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // Cambia la posición de la sombra
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.fill, // Ajustar la imagen para cubrir el contenedor
          ),
        ),
      ),
    );
  }
}

class CardModel {
  int id;
  double zIndex;
  final Widget? child;

  CardModel({required this.id, this.zIndex = 0.0, this.child});
}

class MyCarousel extends StatefulWidget {
  final List<Widget> widgets;
  final Function(int) onClicked;
  final int? currentIndex;

  const MyCarousel({super.key, required this.widgets, required this.onClicked, this.currentIndex});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  double currentIndex = 0;
  double index = 0;

  @override
  void initState() {
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex!.toDouble();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      index = currentIndex - details.delta.dx * 0.005; // Reduce la sensibilidad al deslizar
                      if (index >= 0 && index <= widget.widgets.length - 1) {
                        currentIndex = currentIndex - details.delta.dx * 0.01; // Reduce la sensibilidad al deslizar
                      } else if (index < 0) {
                        currentIndex =
                            widget.widgets.length - 1 + details.delta.dx * 0.01; // Reduce la sensibilidad al deslizar
                      } else if (index > widget.widgets.length - 1) {
                        currentIndex = 0 - details.delta.dx * 0.01; // Reduce la sensibilidad al deslizar
                      }
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      currentIndex = currentIndex.roundToDouble();
                    });
                  },
                  child: OverlappedCarouselCardItems(
                    cards: List.generate(
                      widget.widgets.length,
                      (index) => CardModel(
                        id: index,
                        child: widget.widgets[index],
                      ),
                    ),
                    centerIndex: currentIndex,
                    maxWidth: constraints.maxWidth,
                    maxHeight: constraints.maxHeight,
                    onClicked: widget.onClicked,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.widgets.length,
              (index) => Container(
                margin: const EdgeInsets.all(2),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex.roundToDouble() == index ? Colors.white : Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OverlappedCarouselCardItems extends StatelessWidget {
  final List<CardModel> cards;
  final Function(int) onClicked;
  final double centerIndex;
  final double maxHeight;
  final double maxWidth;

  const OverlappedCarouselCardItems({
    super.key,
    required this.cards,
    required this.centerIndex,
    required this.maxHeight,
    required this.maxWidth,
    required this.onClicked,
  });

  double getCardPosition(int index) {
    final double center = maxWidth / 2.5;
    final double centerWidgetWidth = maxWidth / 4;
    final double basePosition = center - centerWidgetWidth / 2 - 12;
    final distance = centerIndex - index;

    final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + nearWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) - farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2) -
            (nearWidgetWidth - farWidgetWidth) * ((distance - distance.floor()));
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) - farWidgetWidth * (distance.abs() - 1);
      }
      return -((basePosition + centerWidgetWidth + nearWidgetWidth) -
          farWidgetWidth * (distance.abs() - 2) -
          (nearWidgetWidth - farWidgetWidth) * ((distance - distance.floor())) +
          (farWidgetWidth * 2));
    }
  }

  double getCardWidth(int index) {
    final double centerWidgetWidth = (maxWidth / 2) - (maxWidth / 3.5) * 0.01 * (centerIndex - index).abs();

    return centerWidgetWidth;
  }

  Matrix4 getTransform(int index) {
    var transform = Matrix4.identity()
      ..setEntry(3, 2, 0.007)
      // ..rotateY(-0.25 * distance)
      ..scale(1.25, 1.25, 1.25);
    if (index == centerIndex) transform.scale(1.05, 1.05, 1.05);
    return transform;
  }

  Widget _buildItem(CardModel item, int cardCount) {
    final int index = item.id;
    final width = getCardWidth(index);
    double dist = (index - centerIndex).abs();
    if (dist > cardCount ~/ 2) {
      dist = cardCount - dist;
    }
    final verticalPadding = width * 0.01 * dist.toDouble();

    return Positioned(
      left: getCardPosition(index),
      child: Transform(
        transform: getTransform(index),
        alignment: FractionalOffset.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: width.toDouble(),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          height: maxHeight,
          child: item.child,
        ),
      ),
    );
  }

  List<Widget> _sortedStackWidgets(List<CardModel> widgets) {
    final int centerIndexInt = centerIndex.round().toInt();
    final int cardCount = widgets.length;

    for (int i = 0; i < widgets.length; i++) {
      int distance = (i - centerIndexInt).abs();
      if (distance > cardCount ~/ 2) {
        distance = cardCount - distance;
      }
      widgets[i].zIndex = -distance.toDouble();
    }
    widgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return widgets.map((e) {
      double distance = (centerIndex - e.id).abs();

      if (distance > 3 && e.id < 3) {
        e.id += widgets.length;
      }

      return _buildItem(e, widgets.length);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: _sortedStackWidgets(cards),
      ),
    );
  }
}
