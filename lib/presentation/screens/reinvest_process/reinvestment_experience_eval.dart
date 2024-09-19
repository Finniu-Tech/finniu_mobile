import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/datasources/nps_imp.dart';
import 'package:finniu/presentation/providers/evaluate_experience_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EvalExperienceScreen extends StatelessWidget {
  const EvalExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EvaluateExperienceBody(),
    );
  }
}

class EvaluateExperienceBody extends HookConsumerWidget {
  const EvaluateExperienceBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final commentController = useTextEditingController();
    const String question = '¿Cómo calificarías tu experiencia durante \n el proceso de inversión?';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentTheme.isDarkMode ? const Color(primaryDarkAlternative) : const Color(secondary),
              currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryLight),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: SafeArea(
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/images/logo_small.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Tu experiencia es primero',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(primaryDark),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Déjanos tus respuestas sobre tu experiencia dentro del proceso de inversión',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(primaryDark),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: const BoxDecoration(color: Color(primaryDark)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(
                          primaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            height: 1.5,
                            fontSize: 8,
                            color: Color(blackText),
                          ),
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
                      height: 30,
                    ),
                    const Text(
                      '¿Tienes algún comentario o sugerencia \n para mejorar nuestro proceso?(Opcional)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(primaryDark),
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
                          hintText: 'Escribe aquí tu comentario o sugerencia',
                          fillColor: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(whiteText),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          // Navigator.of(context).pushNamed('/finish_investment');
                          Navigator.pushReplacementNamed(context, '/v2/investment');
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
                          right: 20,
                          left: 20,
                          top: 5,
                          bottom: 5,
                        ),
                        backgroundColor: const Color(primaryDark),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          color: score == selectedScore ? activeColor : const Color(primaryLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score.toString(),
              style: TextStyle(
                color: score == selectedScore ? activeLetterColor : const Color(primaryDark),
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
