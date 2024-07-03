import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/evaluate_experience.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step3 extends StatefulHookConsumerWidget {
  const Step3({super.key});

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends ConsumerState<Step3> {
  bool delayedActionExecuted = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      if (!delayedActionExecuted) {
        delayedActionExecuted = true;
        // final ref = ProviderContainer().read;
        ref
            .read(userAcceptedTermsProvider.notifier)
            .update((state) => state = false);
        showExperienceEvaluation(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      hideNavBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(
              step: 3,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/man.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              color: const Color(primaryDark),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 300,
                      child: Text(
                        textAlign: TextAlign.justify,
                        "Gracias por invertir en Finniu!. Recuerda que las transferencias se confirmarán en un plazo de 24 horas si son directas y en un plazo de máximo 72 horas si son interbancarios!",
                        style: TextStyle(
                          height: 1.9,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 37),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Gracias por tu comprensión!",
                          style: TextStyle(
                            color: Color(primaryLight),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
