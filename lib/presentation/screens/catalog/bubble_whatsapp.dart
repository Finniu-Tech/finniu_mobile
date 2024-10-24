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
          child: Icon(Icons.abc_rounded),
        )
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
    final right = useState<double>(20.0);
    final top = useState<double>(20.0);
    final isDragging = useState<bool>(false);

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
      child: GestureDetector(
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
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(50),
          ),
          width: 60,
          height: 60,
          child: const Icon(
            Icons.supervised_user_circle_outlined,
            size: 30,
          ),
        ),
      ),
    );
  }
}
