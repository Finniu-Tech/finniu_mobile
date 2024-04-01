import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/repositories/investment_repository.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PendingInvestmentCard extends HookConsumerWidget {
  const PendingInvestmentCard({
    super.key,
    required this.currentTheme,
    required this.preInvestmentForm,
    required this.checkInvestmentProcess,
  });
  final currentTheme;
  final PreInvestmentForm preInvestmentForm;
  final void Function() checkInvestmentProcess;
  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 140,
      width: 330,
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          width: 1,
          color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //ROUNDED CONTAINER with purple background
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff9381FF),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Tienes una inversión pendiente",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '¿Deseas continuar con tu proceso de inversión?',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // outline button with an x icon and text "descartar"
              ElevatedButton.icon(
                icon: Icon(Icons.close, color: Colors.red),
                style: ElevatedButton.styleFrom(
                  foregroundColor: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                  backgroundColor: Colors.transparent,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () {
                  // here we discard the preinvestment
                  InvestmentRepository()
                      .discardPreInvestment(
                    client: ref.watch(gqlClientProvider).value!,
                    preInvestmentUUID: preInvestmentForm.uuid!,
                  )
                      .then((value) {
                    if (value) {
                      //call here again to check if there is a preinvestment
                      checkInvestmentProcess();
                    }
                  });
                },
                label: Text(
                  "Descartar",
                  style: TextStyle(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.check, color: Colors.green),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () async {
                  final preInvestment = PreInvestmentEntity(
                    uuid: preInvestmentForm.uuid!,
                    amount: preInvestmentForm.amount,
                    bankAccountTypeUuid: preInvestmentForm.bankAccountTypeUuid,
                    deadLineUuid: preInvestmentForm.deadLineUuid,
                    planUuid: preInvestmentForm.planUuid,
                    coupon: preInvestmentForm.coupon,
                  );

                  final inputCalculator = CalculatorInput(
                    amount: preInvestmentForm.amount,
                    months: preInvestmentForm.months!,
                    coupon: preInvestmentForm.coupon,
                    currency: preInvestmentForm.currency,
                  );

                  final calculatorResult = await ref.watch(
                    calculateInvestmentFutureProvider(
                      inputCalculator,
                    ).future,
                  );

                  Navigator.pushNamed(
                    context,
                    '/investment_step2',
                    arguments: PreInvestmentStep2Arguments(
                      plan: calculatorResult.plan!,
                      preInvestment: preInvestment,
                      resultCalculator: calculatorResult,
                    ),
                  );
                },
                label: Text(
                  "Continuar",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
