import 'package:finniu/presentation/screens/catalog/widgets/add_voucher_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal_02.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/calendar_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/completed_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/init_progress_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/less_year_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/row_schedule_logbook.dart';
import 'package:finniu/presentation/screens/catalog/widgets/to_validate_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/modal_investment_summary.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CatalogScreen extends HookConsumerWidget {
  const CatalogScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarHome(),
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: const CustomReturnButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ButtonInvestment(
              text: "go to /v2/form_personal_data v2",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_personal_data');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to v2/complete_details v2",
              onPressed: () {
                Navigator.pushNamed(context, 'v2/complete_details');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to sendcode v2",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/send_code');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to register v2",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/register');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const NoInvestmentCase(
              title: "Aún no tienes inversiones en curso",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones finalizadas cuando finaliza el plazo de tu inversión",
            ),
            const SizedBox(
              height: 10,
            ),
            const NoInvestmentCase(
              title: "Aún no tienes inversiones por validar",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones por validar cuando hayas realizado una inversión reciente y no ha sido aprobada aún",
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "notificaciones",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/notifications');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go calendar",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/calendar');
              },
            ),
            const CalendarContainer(),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to businnes investment",
              onPressed: () {
                Navigator.pushNamed(context, '/business_investment');
              },
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/v2/simulator');
              },
              child: const Text('v2 simulador'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/v2/summary');
              },
              child: const Text('v2 summary'),
            ),
            ElevatedButton(
              onPressed: () {
                addVoucherModal(context);
              },
              child: const Text('add voucher'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/blue_gold_investment');
              },
              child: const Text('blue gold screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/v2/investment_blue_gold');
              },
              child: const Text('go to blue gold'),
            ),
            const InvestmentSimulationButton(),
            const CompletedBlueGoldCard(
              daysPassed: 0,
              daysMissing: 365,
              uuidReport: 1234,
              uuidVoucher: 1234,
            ),
            const SizedBox(
              height: 10,
            ),
            const LessYearBlueGoldCard(
              daysPassed: 65,
              daysMissing: 300,
              uuidReport: 12314,
              uuidVoucher: 12314,
            ),
            const SizedBox(
              height: 10,
            ),
            const InitProgressBlueGoldCard(
              daysPassed: 1,
              daysMissing: 365,
              uuidReport: 12314,
              uuidVoucher: 12314,
            ),
            const SizedBox(
              height: 10,
            ),
            const InitProgressBlueGoldCard(
              daysPassed: 2,
              daysMissing: 730,
              uuidReport: 12314,
              uuidVoucher: 12314,
            ),
            // const CarouselBlueGold(),
            const RowScheduleLogbook(),
            const SizedBox(
              height: 10,
            ),
            const BlueGoldInvestmentCard(days: 100, progress: 50, amount: 1000),
            const NoInvestmentsButton(),

            const CompleteInvestment(
              amount: 777,
              dateEnds: '11/11/2022',
            ),
            const SizedBox(
              height: 5,
            ),
            const CompleteInvestment(
              amount: 555,
              dateEnds: '10/10/2022',
            ),
            const SizedBox(
              height: 5,
            ),
            const ToValidateInvestment(
              amount: 3000,
              dateEnds: '10/10/2022',
            ),
            const SizedBox(
              height: 5,
            ),
            const ProgressBarInProgress(
              amount: 1000,
              dateEnds: '10/10/2022',
              onPressed: null,
            ),
            const SizedBox(
              height: 5,
            ),
            const ProgressBarInProgress(
              amount: 2000,
              dateEnds: '11/10/2022',
              onPressed: null,
            ),
            const ModalBenefitsTwo(),
            const SizedBox(height: 10),
            const ModalBenefits(),
            const SizedBox(height: 10),
            const ModalInvestmentSummary(),
            const SizedBox(height: 10),
            const ValidationModal(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home_home'),
              child: const Text('Ir a home normal'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/catalog'),
              child: const Text('Ver Catalogo de Widgets'),
            ),
            const ButtonSendProof(),

            // const FundInfoSlider(

            // ),
            // const SizedBox(height: 70),
            const GraphicContainer(),

            const SizedBox(height: 10),

            const SizedBox(height: 10),
            const NonInvestmentContainer(),
          ],
        ),
      ),
    );
  }
}
