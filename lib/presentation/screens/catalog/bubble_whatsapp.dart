import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BubbleWhatsappScreen extends StatelessWidget {
  const BubbleWhatsappScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BubbleBody(),
    );
  }
}

class BubbleBody extends ConsumerWidget {
  const BubbleBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bubbleStateText = ref.watch(positionProvider);
    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
                Expanded(
                  child: Center(
                    child: Text(
                      "top : ${bubbleStateText.top} right : ${bubbleStateText.right}",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const StackWhatsApp(),
      ],
    );
  }
}

class WhatsAppBubble extends HookConsumerWidget {
  const WhatsAppBubble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.read(positionProvider);

    final isTalkRender = useState<bool>(false);

    final right = useState<double>(bubbleState.right);
    final top = useState<double>(bubbleState.top);

    const int weTalkDark = 0xffA2E6FA;
    const int weTalkLight = 0xff0D3A5C;
    const int weTalkTextDark = 0xff0D3A5C;
    const int weTalkTextLight = 0xffFFFFFF;

    void onTap() {
      isTalkRender.value = !isTalkRender.value;
    }

    void onPanUpdate(DragUpdateDetails details) {
      ref.read(positionProvider.notifier).setMove(true);
      top.value += details.delta.dy;
      right.value -= details.delta.dx;
    }

    void onPanEnd(DragEndDetails details) {
      ref.read(positionProvider.notifier).setMove(false);
      ref
          .read(positionProvider.notifier)
          .updatePosition(right.value, top.value, true);
    }

    return bubbleState.isRender
        ? AnimatedPositioned(
            top: top.value,
            right: right.value,
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              width: 170,
              height: 140,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  GestureDetector(
                    onTap: onTap,
                    onPanUpdate: (details) => onPanUpdate(details),
                    onPanEnd: (details) => onPanEnd(details),
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
          )
        : const SizedBox();
  }
}

class StackWhatsApp extends HookConsumerWidget {
  const StackWhatsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleStateText = ref.watch(positionProvider);
    const int iconCloseDark = 0xffA2E6FA;
    const int iconCloseLight = 0xff0D3A5C;
    double size = MediaQuery.of(context).size.width;
    useEffect(
      () {
        return null;
      },
      [],
    );
    return Stack(
      children: [
        Container(
          width: size,
          height: MediaQuery.of(context).size.height,
          color: bubbleStateText.isMove
              ? Colors.black.withOpacity(0.2)
              : Colors.transparent,
        ),
        const WhatsAppBubble(),
        Positioned(
          bottom: 40.0,
          width: size,
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode
                      ? const Color(iconCloseDark)
                      : const Color(iconCloseLight),
                  width: 2.0,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: isDarkMode
                    ? const Color(iconCloseDark)
                    : const Color(iconCloseLight),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
