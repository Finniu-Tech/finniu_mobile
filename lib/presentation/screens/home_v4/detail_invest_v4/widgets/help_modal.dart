import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showHelp(BuildContext context) {
  showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (context) => const HelpBody(),
  );
}

class HelpBody extends ConsumerWidget {
  const HelpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff252525;
    const int backgroundColorLight = 0xffFFFFFF;

    const String text =
        "Hola! , recuerda que tu reinversión se activa cuando tu inversión en curso haya finalizado";
    return Dialog(
      backgroundColor: isDarkMode
          ? const Color(backgroundColorDark)
          : const Color(backgroundColorLight),
      child: SizedBox(
        width: 300,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: CloseButton(),
              ),
              Image.asset(
                "assets/home_v4/help_modal_image.png",
                width: 65,
                height: 65,
              ),
              const TextPoppins(
                text: text,
                fontSize: 14,
                lines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
