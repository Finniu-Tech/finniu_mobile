import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReinvestmentAvailableCard extends ConsumerWidget {
  const ReinvestmentAvailableCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rounded card with a stacked images over the container, the container has a gradient background
    //money_and_dollars.png
    return Container(
      height: 109,
      width: 333,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffffeedd),
            Color(0xffdbf7ff),
          ],
        ),
      ),
      child: Row(
        children: [
          //first a image
          // second a text with a title
          // third a rounded button
          SizedBox(
            width: 67,
            height: 60,
            child: Image.asset('assets/home/money_and_dollars.png'),
            // child:  AssetImage('assets/home/money_and_dollars.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¡Ya puedes reinvertir!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(primaryDark),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1A1A1A),
                  ),
                  children: [
                    TextSpan(
                      text: 'Tienes algunas\n inversiones disponibles\n para reinvertir',
                    ),
                  ],
                ),
              ),
            ],
          ),

          CustomButtonRoundedDark(
            // pushName: '/reinvestment',
            onTap: () {
              reinvestmentQuestionModal(context, ref);
            },
          ),
        ],
      ),
    );
  }
}
