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

class BubbleBody extends StatelessWidget {
  const BubbleBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text("Hola"),
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

class StackWhatsApp extends StatelessWidget {
  const StackWhatsApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
        ),
        const WhatsAppBubble(),
        Positioned(
          bottom: 20,
          right: MediaQuery.of(context).size.width / 2,
          child: ClipOval(
            child: Image.asset(
              "assets/images/whatsapp_image.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class WhatsAppBubble extends HookConsumerWidget {
  const WhatsAppBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final right = useState<double>(20.0);
    final top = useState<double>(20.0);
    final isDragging = useState<bool>(false);
    const int weTalkDark = 0xffA2E6FA;
    const int weTalkLight = 0xff0D3A5C;
    const int weTalkTextDark = 0xff0D3A5C;
    const int weTalkTextLight = 0xffFFFFFF;
    void onTap() {
      print("onTap");
    }

    void onLongPress() {
      isDragging.value = true;
      print("onLongPress");
    }

    return AnimatedPositioned(
      top: top.value,
      right: right.value,
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            onPanUpdate: (details) {
              top.value += details.delta.dy;
              right.value -= details.delta.dx;
            },
            onPanEnd: (details) {
              isDragging.value = false;
            },
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
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/whatsapp_image.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
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
                width: 126,
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
                size: const Size(20, 20),
                painter: CurvedTrianglePainter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurvedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff0D3A5C)
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
