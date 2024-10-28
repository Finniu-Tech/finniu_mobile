import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/bubble/whats_bubble.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BubbleWhatsappScreen extends HookConsumerWidget {
  const BubbleWhatsappScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = useState<bool>(true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              isVisible.value = !isVisible.value;
            },
            icon: const Icon(Icons.close_fullscreen_outlined),
          ),
        ],
      ),
      body: BubbleBody(
        isVisible: isVisible,
      ),
    );
  }
}

class BubbleBody extends ConsumerWidget {
  const BubbleBody({
    super.key,
    required this.isVisible,
  });
  final ValueNotifier<bool> isVisible;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bubbleStateText = ref.watch(positionProvider);
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            WhatsAppBubbleDrag(
              isVisible: isVisible,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "top : ${bubbleStateText.top} right : ${bubbleStateText.left}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsAppBubbleDrag extends HookConsumerWidget {
  const WhatsAppBubbleDrag({
    super.key,
    required this.isVisible,
  });
  final ValueNotifier<bool> isVisible;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.read(positionProvider);

    final isTalkRender = useState<bool>(false);
    final isMove = useState<bool>(false);

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

    void closeBubble() {
      print("closeBubble");
      ref.read(positionProvider.notifier).resetMoveAndHide();
      isVisible.value = false;
    }

    void onDragUpdate(DragUpdateDetails details) {
      isMove.value = true;
    }

    void onDragEnd(DraggableDetails details) {
      isMove.value = true;
      final newTop = details.offset.dy.clamp(0.0, screenHeight - 60);
      final newLeft = details.offset.dx.clamp(0.0, screenWidth - 60);

      top = newTop;
      left = newLeft;

      ref.read(positionProvider.notifier).updatePosition(newLeft, newTop);

      if (newTop > screenHeight - 100 &&
          newLeft > (screenWidth / 2 - 30) &&
          newLeft < (screenWidth / 2 + 30)) {
        closeBubble();
      } else {
        ref.read(positionProvider.notifier).updatePosition(newLeft, newTop);
      }
      isMove.value = false;
    }

    return isVisible.value
        ? Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: isMove.value
                    ? Colors.black.withOpacity(0.2)
                    : Colors.transparent,
              ),
              Positioned(
                top: top,
                left: left,
                child: SizedBox(
                  width: 170,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Draggable(
                        feedback: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
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
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 60,
                            height: 60,
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
                                    decoration: BoxDecoration(
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
                                    height: 40,
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
              ),
              isMove.value
                  ? Positioned(
                      left: MediaQuery.of(context).size.width / 2,
                      bottom: 50,
                      child: Icon(
                        Icons.close,
                        color: isDarkMode
                            ? const Color(weTalkDark)
                            : const Color(weTalkLight),
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              onPressed: () {
                isVisible.value = true;
              },
              icon: Icon(
                size: 30,
                Icons.help,
                color: isDarkMode
                    ? const Color(weTalkDark)
                    : const Color(weTalkLight),
              ),
            ),
          );
  }
}
