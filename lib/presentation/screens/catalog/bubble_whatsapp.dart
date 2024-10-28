import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/bubble/whats_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BubbleWhatsappScreen extends ConsumerWidget {
  const BubbleWhatsappScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(positionProvider.notifier).getBubble();
            },
            icon: const Icon(Icons.close_fullscreen_outlined),
          ),
        ],
      ),
      body: const BubbleBody(),
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
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const WhatsAppBubbleDrag(),
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


   // isMove.value
              //     ? Positioned(
              //         left: MediaQuery.of(context).size.width / 2,
              //         bottom: 100,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(50),
              //             border: Border.all(
              //               color: isDarkMode
              //                   ? const Color(weTalkDark)
              //                   : const Color(weTalkLight),
              //               width: 2, // Grosor del borde
              //             ),
              //           ),
              //           child: Icon(
              //             Icons.close,
              //             color: isDarkMode
              //                 ? const Color(weTalkDark)
              //                 : const Color(weTalkLight),
              //             size: 30,
              //           ),
              //         ),
              //       )
              //     : const SizedBox(),