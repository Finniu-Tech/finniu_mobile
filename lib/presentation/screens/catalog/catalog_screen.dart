import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/domain/entities/user_profile_completeness.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/add_voucher_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/benefits_modal_02.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/calendar_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/completed_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/init_progress_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_date_picker.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/less_year_progress_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/modal_app_maintenance.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investments_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/row_schedule_logbook.dart';
import 'package:finniu/presentation/screens/catalog/widgets/simulation_modal/feedback_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/to_validate_investment.dart';
import 'package:finniu/presentation/screens/catalog/widgets/modal_investment_summary.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/verify_identity.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:finniu/presentation/screens/home_v4/widget/select_bank.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/modal_new_password.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/modal_payment_bounced.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/modal_payment_voucher.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/modal_receive_ask.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/row_dowload.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CatalogScreen extends HookConsumerWidget {
  const CatalogScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);

    void setDarkMode() {
      if (!isDarkMode) {
        ref.read(settingsNotifierProvider.notifier).setDarkMode();
      } else {
        ref.read(settingsNotifierProvider.notifier).setLightMode();
      }
    }

    bool invest = false;

    void setInvest() {
      invest = !invest;
    }

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;

    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
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
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "debug logs",
              onPressed: () {
                Navigator.pushNamed(context, '/debug_log');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "nuevo home",
              onPressed: () {
                Navigator.pushNamed(context, '/v4/home');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "form accoutns",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_accounts');
              },
            ),

            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "new bank select",
              onPressed: () {
                showBankAccountModalV4(
                    context: context,
                    currency: isSoles ? CurrencyEnum.PEN : CurrencyEnum.USD,
                    isSender: false,
                    typeReInvestment: "",
                    bankSelect: null);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "whats app",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/bubble_whatsapp');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "screen rextie comunicacion",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/rextie_comminication');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "modal bounced payment",
              onPressed: () {
                showPayBounced(
                  context: context,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "modal receive adk",
              onPressed: () {
                showReceiveAdk(
                  context: context,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "modal voucher payment",
              onPressed: () {
                showModalPaymentVoucher(
                  context: context,
                  voucherData: const VoucherDto(
                    month: 'Mayo',
                    amount: '1,200',
                    depositDay: '12/09/2024',
                    depositHour: '12:30 am',
                    bank: 'Interbank',
                    urlVoucher: '',
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "navigate pay out",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/pay_out');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: InputDatePickerUserProfile(
                controller: controller,
                hintText: "Fecha de nacimiento",
                validator: (p0) {
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "show feedback modal",
              onPressed: () {
                showFeedbackModal(
                  context,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "show verify",
              onPressed: () {
                showVerifyIdentity(
                  context,
                  UserProfileCompleteness(
                    completionPercentage: 100,
                    legalTermsCompleteness: 100,
                    personalDataComplete: 100,
                    locationComplete: 90,
                    occupationComplete: 90,
                    profileComplete: 100,
                  ),
                  redirect: () {
                    Navigator.pushNamed(context, '/v2/investment/step-1', arguments: {'fund': ""});
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "navigate firebase test",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/firebase_test');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // ButtonInvestment(
            //   text: "navigate geolocator",
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/v2/geolocator');
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            ButtonInvestment(
              text: "modal error send data",
              onPressed: () {
                modalErrorSendData(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "modal app mantenimiento",
              onPressed: () {
                modalMaintenance(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "modal new password",
              onPressed: () {
                modalNewPassword(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "navigate change pasgord",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/set_new_password');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "show verifica tu identidad",
              onPressed: () {
                // showVerifyIdentity(context,);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go login",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/login_email');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "snackbar error",
              onPressed: () {
                showSnackBarV2(
                  context: context,
                  title: "probando",
                  message: "estoy probandossssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                  snackType: SnackType.error,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "snackbar warning",
              onPressed: () {
                showSnackBarV2(
                  context: context,
                  title: "probando",
                  message: "estoy probandossssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                  snackType: SnackType.warning,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "snackbar success",
              onPressed: () {
                showSnackBarV2(
                  context: context,
                  title: "probando",
                  message: "estoy probandossssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                  snackType: SnackType.success,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "snackbar info",
              onPressed: () {
                showSnackBarV2(
                  context: context,
                  title: "probando",
                  message: "estoy probandossssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                  snackType: SnackType.info,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "biometric test",
              onPressed: () {
                Navigator.pushNamed(context, '/biometric_test');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "push notification test",
              onPressed: () {
                Navigator.pushNamed(context, '/push_notification');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
                text: 'Log error on crashalytics',
                onPressed: () async {
                  FirebaseCrashlytics.instance.log('Esto es un log de prueba');
                  throw Exception();
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: RowDownload(
                title: "Declaración - Marzo",
              ),
            ),
            const ExpansionTitleLegal(
              title: "Verificación  legal",
              children: [
                ChildrenCheckboxTitle(
                  text: "Eres miembro o familiar de un funcionario público o una persona políticamente expuesta. ",
                  value: true,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const ExpansionTitleLegal(
              title: "Declaración a la Sunat 5%",
              children: [
                ChildrenOnlyText(
                  textBig: true,
                  text:
                      "Este 5% es la tributación correspondiente por renta de 2da categoría (inversiones). Aplica sobre tus intereses ganados.",
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const ExpansionTitleProfile(
              icon: "assets/svg_icons/dark_mode_icon.svg",
              title: "Contraseñas",
              subtitle: "Sobre los depósitos, aprobaciones de mis inversiones y otros.",
              children: [
                ChildrenTitle(
                  title: "Visualización de contraseña",
                  subtitle: "Mostrar caracteres brevemente mientras escribes",
                ),
                ChildrenOnlyText(
                  text:
                      "Política de privacidad de la app Finniu, tenemos respaldo y seguridad de tus datos , no los compartimos ni exponemos tus datos personales  ",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonSwitchProfile(
              icon: null,
              title: "Sobre mis inversiones",
              subtitle: "Sobre los depósitos, aprobaciones de mis inversiones y otros.",
              onTap: () => setInvest(),
              value: invest,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonSwitchProfile(
              icon: "assets/svg_icons/dark_mode_icon.svg",
              title: "Modo oscuro",
              subtitle: "Elige tu modo favorito",
              onTap: () => setDarkMode(),
              value: !isDarkMode,
            ),
            const SizedBox(
              height: 10,
            ),
            const ButtonNavigateProfile(
              icon: "assets/svg_icons/help_circle.svg",
              title: "Soporte y ayuda",
              subtitle: "Ticket de soporte y preguntas \nfrecuentes",
              onTap: null,
            ),
            const SizedBox(
              height: 10,
            ),
            const ButtonNavigateProfile(
              isComplete: true,
              icon: "assets/svg_icons/help_circle.svg",
              title: "Soporte y ayuda",
              subtitle: "Ticket de soporte y preguntas \nfrecuentes",
              onTap: null,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to '/v2/profile'",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/profile');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to '/v2/on_boarding'",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/on_boarding');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to '/v2/form_about_me'",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_about_me');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to '/v2/form_legal_terms'",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_legal_terms');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to /v2/form_job v2",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_job');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonInvestment(
              text: "go to /v2/form_location v2",
              onPressed: () {
                Navigator.pushNamed(context, '/v2/form_location');
              },
            ),
            const SizedBox(
              height: 10,
            ),
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
            // const InvestmentSimulationButton(),
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
            GraphicContainer(),

            const SizedBox(height: 10),

            const SizedBox(height: 10),
            const NonInvestmentContainer(),
          ],
        ),
      ),
    );
  }
}
