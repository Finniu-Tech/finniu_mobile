import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/datasources/nps_imp.dart';
import 'package:finniu/presentation/providers/evaluate_experience_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

void showExperienceEvaluation(
  BuildContext ctx,
) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 11,
    context: ctx,
    isDismissible: false,
    builder: (ctx) => const EvaluateExperienceWidget(),
  );
}

class EvaluateExperienceWidget extends HookConsumerWidget {
  const EvaluateExperienceWidget({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final commentController = useTextEditingController();
    const String question =
        '¿Cómo calificarías tu experiencia durante el proceso de inversión?';
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentTheme.isDarkMode
                  ? const Color(primaryDarkAlternative)
                  : const Color(secondary),
              currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryLight),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 260,
                  child: Text(
                    question,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        primaryDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  EmojiWidget(score: 1, emoji: 'assets/images/angry.png'),
                  SizedBox(
                    width: 10,
                  ),
                  EmojiWidget(score: 2, emoji: 'assets/images/bored.png'),
                  SizedBox(
                    width: 10,
                  ),
                  EmojiWidget(score: 3, emoji: 'assets/images/so_so.png'),
                  SizedBox(
                    width: 10,
                  ),
                  EmojiWidget(score: 4, emoji: 'assets/images/happy.png'),
                  SizedBox(
                    width: 10,
                  ),
                  EmojiWidget(score: 5, emoji: 'assets/images/good.png'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Mala experiencia',
                  style: TextStyle(
                      height: 1.5, fontSize: 8, color: Color(blackText)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                const Text(
                  'Buena experiencia',
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 8,
                    color: Color(blackText),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 260,
              child: Text(
                '¿Tienes algun comentario o sugerencia para mejorar nuestro proceso?(Opcional)',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(blackText),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              height: 124,
              child: TextField(
                controller: commentController,
                maxLines: 10,
                minLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Escribe aquí tu comentario, si lo tienes',
                  fillColor: const Color(whiteText),
                  filled: true,
                ),
              ),
            ),
            // Container(
            //   width: 300,
            //   height: 124,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: const Color(whiteText),
            //   ),
            // ),
            const SizedBox(
              height: 4,
            ),
            TextButton(
              onPressed: () async {
                bool success = await NPSDataSourceImpl().save(
                  client: await ref.watch(gqlClientProvider.future),
                  question: question,
                  answer: ref.watch(experienceScore).toString(),
                  comment: commentController.text,
                );
                if (success) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/finish_investment');
                } else {
                  CustomSnackbar.show(
                    context,
                    'Ocurrió un problema',
                    'error',
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                backgroundColor: const Color(primaryDark),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Enviar respuesta',
                style: TextStyle(color: Colors.white),
              ),
            )
            // CustomButton(
            //   text: "Enviar respuesta",
            //   colorText: currentTheme.isDarkMode ? (primaryDark) : whiteText,
            //   colorBackground:
            //       currentTheme.isDarkMode ? (primaryLight) : primaryDark,
            //   height: 38,
            //   width: 134,
            //   pushName: '/finish_investment',
            // ),
          ],
        ),
      ),
    );
  }
}

class EmojiWidget extends HookConsumerWidget {
  final int score;
  final String emoji;
  const EmojiWidget({
    super.key,
    required this.score,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context, ref) {
    final int selectedScore = ref.watch(experienceScore);
    const Color activeColor = Color(primaryDark);
    const Color activeLetterColor = Color(primaryLight);
    return InkWell(
      onTap: () {
        ref.read(experienceScore.notifier).update((state) => score);
      },
      child: Container(
        width: 45,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              score == selectedScore ? activeColor : const Color(primaryLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score.toString(),
              style: TextStyle(
                color: score == selectedScore
                    ? activeLetterColor
                    : const Color(primaryDark),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
              image: AssetImage(emoji),
              width: 20,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
