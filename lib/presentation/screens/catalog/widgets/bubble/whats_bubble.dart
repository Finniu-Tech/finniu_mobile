import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WhatsAppBubbleDrag extends HookConsumerWidget {
  const WhatsAppBubbleDrag({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.watch(positionProvider);

    final isTalkRender = useState<bool>(false);
    // final isMove = useState<bool>(false);

    double left = bubbleState.left;
    double top = bubbleState.top;

    const int weTalkDark = 0xffA2E6FA;
    const int weTalkLight = 0xff0D3A5C;
    const int weTalkTextDark = 0xff0D3A5C;
    const int weTalkTextLight = 0xffFFFFFF;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    void onTap() {
      isTalkRender.value = !isTalkRender.value;
    }

    // void closeBubble() {
    //   ref.read(positionProvider.notifier).resetBubble();
    // }

    void onDragUpdate(DragUpdateDetails details) {
      // isMove.value = true;
      isTalkRender.value = false;
    }

    void onDragEnd(DraggableDetails details) {
      final maxTop = screenHeight * 0.6;
      final maxLeft = screenWidth * 0.9;
      final newTop = details.offset.dy.clamp(0.0, maxTop);
      final newLeft = details.offset.dx.clamp(0.0, maxLeft);

      top = newTop;
      left = newLeft;
      ref.read(positionProvider.notifier).updatePosition(newLeft, newTop);

      // if (newTop > screenHeight - 120 &&
      //     newLeft > (screenWidth / 2 - 50) &&
      //     newLeft < (screenWidth / 2 + 50)) {
      //   // closeBubble();
      // } else {
      //   ref.read(positionProvider.notifier).updatePosition(newLeft, newTop);
      // }
      // isMove.value = false;
    }

    return bubbleState.isRender
        ? Positioned(
            top: top,
            left: left,
            child: SizedBox(
              width: 150,
              height: 140,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Draggable(
                    feedback: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/whatsapp_image.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    onDragUpdate: (details) => onDragUpdate(details),
                    onDragEnd: (details) => onDragEnd(details),
                    childWhenDragging: const SizedBox(),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 50,
                        height: 50,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/whatsapp_image.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  isTalkRender.value
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: isDarkMode
                                      ? const Color(weTalkDark)
                                      : const Color(weTalkLight),
                                ),
                                width: 110,
                                height: 35,
                                child: const Center(
                                  child: TextPoppins(
                                    text: "¿Conversamos?",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textDark: weTalkTextDark,
                                    textLight: weTalkTextLight,
                                  ),
                                ),
                              ),
                              CustomPaint(
                                size: const Size(15, 15),
                                painter: CurvedTrianglePainter(
                                  isDarkMode: isDarkMode,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

//
// class StackWhatsApp extends HookConsumerWidget {
//   const StackWhatsApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     // final bubbleState = ref.watch(positionProvider);
//     final isRender = useState<bool>(true);
//     const int iconCloseDark = 0xffA2E6FA;
//     const int iconCloseLight = 0xff0D3A5C;
//     double size = MediaQuery.of(context).size.width;
//     useEffect(
//       () {
//         return null;
//       },
//       [],
//     );
//     return Stack(
//       children: [
//         Container(
//           width: size,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.transparent,
//         ),
//         const WhatsAppBubble(),
//         Positioned(
//           bottom: 40.0,
//           width: size,
//           child: isRender.value
//               ? ClipOval(
//                   child: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isDarkMode
//                             ? const Color(iconCloseDark)
//                             : const Color(iconCloseLight),
//                         width: 2.0,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.close,
//                       color: isDarkMode
//                           ? const Color(iconCloseDark)
//                           : const Color(iconCloseLight),
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ),
//       ],
//     );
//   }
// }

class CurvedTrianglePainter extends CustomPainter {
  CurvedTrianglePainter({required this.isDarkMode});
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    const int weTalkDark = 0xffA2E6FA;
    const int weTalkLight = 0xff0D3A5C;
    final paint = Paint()
      ..color = isDarkMode ? const Color(weTalkDark) : const Color(weTalkLight)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    // Cerrar la forma
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class WhatsAppBubble extends HookConsumerWidget {
//   const WhatsAppBubble({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     final bubbleState = ref.read(positionProvider);

//     final isTalkRender = useState<bool>(false);
//     final isRender = useState(true);
//     final left = useState<double>(bubbleState.left);
//     final top = useState<double>(bubbleState.top);

//     const int weTalkDark = 0xffA2E6FA;
//     const int weTalkLight = 0xff0D3A5C;
//     const int weTalkTextDark = 0xff0D3A5C;
//     const int weTalkTextLight = 0xffFFFFFF;
//     final double maxTop = MediaQuery.of(context).size.height - 100;
//     final double maxLeft = MediaQuery.of(context).size.width - 60;
//     void onTap() {
//       isTalkRender.value = !isTalkRender.value;
//     }

//     void onPanUpdate(DragUpdateDetails details) {
//       final newTop = top.value + details.delta.dy;
//       top.value = newTop.clamp(0.0, maxTop);

//       final newLeft = left.value + details.delta.dx;
//       left.value = newLeft.clamp(0.0, maxLeft);
//     }

//     void onPanEnd(DragEndDetails details) {
//       // final screenWidth = MediaQuery.of(context).size.width;
//       // final screenHeight = MediaQuery.of(context).size.height;

//       // final centerLeftMin = screenWidth * 0.3;
//       // final centerLeftMax = screenWidth * 0.7;
//       // final bottomThreshold = screenHeight * 0.7;

//       // final isInCenterBottom = left.value >= centerLeftMin &&
//       //     left.value <= centerLeftMax &&
//       //     top.value >= bottomThreshold;
//       // isInCenterBottom
//       //     ? ref.read(positionProvider.notifier).resetBubble()
//       //     : ref.read(positionProvider.notifier).updatePosition(
//       //           left.value,
//       //           top.value,
//       //         );
//       ref.read(positionProvider.notifier).updatePosition(
//             left.value,
//             top.value,
//           );
//     }

//     return isRender.value
//         ? AnimatedPositioned(
//             top: top.value,
//             left: left.value,
//             duration: const Duration(milliseconds: 200),
//             child: SizedBox(
//               width: 170,
//               height: 140,
//               child: Stack(
//                 alignment: Alignment.centerLeft,
//                 children: [
//                   GestureDetector(
//                     onTap: onTap,
//                     onPanUpdate: (details) => onPanUpdate(details),
//                     onPanEnd: (details) => onPanEnd(details),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.5),
//                             spreadRadius: 5,
//                             blurRadius: 7,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       width: 50,
//                       height: 50,
//                       child: ClipOval(
//                         child: Image.asset(
//                           "assets/images/whatsapp_image.png",
//                           width: 30,
//                           height: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   isTalkRender.value
//                       ? Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       spreadRadius: 1,
//                                       blurRadius: 5,
//                                       offset: const Offset(0, 1),
//                                     ),
//                                   ],
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                   ),
//                                   color: isDarkMode
//                                       ? const Color(weTalkDark)
//                                       : const Color(weTalkLight),
//                                 ),
//                                 width: 110,
//                                 height: 35,
//                                 child: const Center(
//                                   child: TextPoppins(
//                                     text: "¿Conversamos?",
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     textDark: weTalkTextDark,
//                                     textLight: weTalkTextLight,
//                                   ),
//                                 ),
//                               ),
//                               CustomPaint(
//                                 size: const Size(15, 15),
//                                 painter: CurvedTrianglePainter(
//                                   isDarkMode: isDarkMode,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//           )
//         : const SizedBox();
//   }
// }
