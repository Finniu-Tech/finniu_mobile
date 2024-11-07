import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class JuliaBubble extends HookConsumerWidget {
  const JuliaBubble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.watch(positionProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const int weTalkDark = 0xffA2E6FA;
    const int weTalkLight = 0xff0D3A5C;
    const int weTalkTextDark = 0xff0D3A5C;
    const int weTalkTextLight = 0xffFFFFFF;

    void contactBubble() async {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.navigateToJulia,
        parameters: {
          "": "",
        },
      );
      var whatsappNumber = "51983796139";
      var whatsappMessage = "Hola";
      var whatsappUrlAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}",
      );
      var whatsappUrlIphone =
          Uri.parse("https://wa.me/$whatsappNumber?text=$whatsappMessage");
      try {
        if (defaultTargetPlatform == TargetPlatform.android) {
          await launchUrl(whatsappUrlAndroid);
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateToJulia,
            parameters: {
              "device": "android",
            },
          );
        } else {
          await launchUrl(whatsappUrlIphone);
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.navigateToJulia,
            parameters: {
              "device": "ios",
            },
          );
        }
      } catch (e) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.navigateToJulia,
          parameters: {
            "error": "error_open_whatsapp",
          },
        );
        showSnackBarV2(
          context: context,
          title: "No se pudo abrir Julia",
          message: "Por favor intenta de nuevo",
          snackType: SnackType.warning,
        );
      }
    }

    onTap() {
      contactBubble();
    }

    onPanUpdate(DragUpdateDetails details) {
      final maxTop = screenHeight * 0.8;
      final maxLeft = screenWidth * 0.7;
      final newTop = details.globalPosition.dy.clamp(0.0, maxTop);
      final newLeft = details.globalPosition.dx.clamp(0.0, maxLeft);
      ref.read(positionProvider.notifier).updatePosition(newLeft, newTop);
    }

    return bubbleState.isRender
        ? AnimatedPositioned(
            left: bubbleState.left,
            top: bubbleState.top,
            duration: const Duration(milliseconds: 100),
            child: GestureDetector(
              onTap: () => onTap(),
              onPanUpdate: (details) => onPanUpdate(details),
              child: SizedBox(
                width: 110,
                height: 70,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 55,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/whatsapp_image.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: isDarkMode
                              ? const Color(weTalkDark)
                              : const Color(weTalkLight),
                        ),
                        child: const Center(
                          child: TextPoppins(
                            text: "¿Conversamos?",
                            fontSize: 5,
                            fontWeight: FontWeight.w400,
                            textDark: weTalkTextDark,
                            textLight: weTalkTextLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
