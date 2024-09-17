import 'package:finniu/presentation/screens/activate_account_v2.dart/activate_account_v2.dart';
import 'package:finniu/presentation/screens/binnacle/binnacle_screen.dart';
import 'package:finniu/presentation/screens/catalog/catalog_screen.dart';
import 'package:finniu/presentation/screens/calendar_v2/v2_calendar.dart';
import 'package:finniu/presentation/screens/complete_details/complete_details_screen_v2.dart';
import 'package:finniu/presentation/screens/complete_details/validate_identity_screen.dart';
import 'package:finniu/presentation/screens/config_v2/frequently_questions_screen.dart';
import 'package:finniu/presentation/screens/config_v2/legal_documents_screen.dart';
import 'package:finniu/presentation/screens/config_v2/my_data_screen.dart';
import 'package:finniu/presentation/screens/config_v2/new_notifications_screen.dart';
import 'package:finniu/presentation/screens/config_v2/privacy_screen.dart';
import 'package:finniu/presentation/screens/config_v2/settings_screen.dart';
import 'package:finniu/presentation/screens/config_v2/support_help_screen.dart';
import 'package:finniu/presentation/screens/config_v2/support_ticket_screen.dart';
import 'package:finniu/presentation/screens/edit_about_v2/edit_about_screen.dart';
import 'package:finniu/presentation/screens/edit_job_v2/edit_job_screen.dart';
import 'package:finniu/presentation/screens/edit_location_v2/edit_location_screen.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/edit_personal_screen.dart';
import 'package:finniu/presentation/screens/form_about_me_v2/form_about_me_v2.dart';
import 'package:finniu/presentation/screens/form_job_v2/form_job_v2.dart';
import 'package:finniu/presentation/screens/form_legal_terms/form_legal_v2.dart';
import 'package:finniu/presentation/screens/form_location_v2/form_location_v2.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/form_personal_v2.dart';
import 'package:finniu/presentation/screens/fund_detail/fund_detail_screen.dart';
import 'package:finniu/presentation/screens/home_v2/home_screen.dart';
import 'package:finniu/presentation/screens/investment_aggro/investment_aggro_process_screen.dart';
import 'package:finniu/presentation/screens/investment_process.dart/step_1_screen.dart';
import 'package:finniu/presentation/screens/investment_process.dart/step_2_screen.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/investment_blue_gold_screen.dart';
import 'package:finniu/presentation/screens/investment_v2/investment_screen_v2.dart';
import 'package:finniu/presentation/screens/login_v2/login_sceen_v2.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/lot_detail_v2.dart';
import 'package:finniu/presentation/screens/my_accounts_v2/accounts_screen_v2.dart';
import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/notifications/notifications_screen.dart';
import 'package:finniu/presentation/screens/profile_v2/profile_screen_v2.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/on_boarding_screen_v2.dart';
import 'package:finniu/presentation/screens/reinvest_process/reinvestment_experience_eval.dart';
import 'package:finniu/presentation/screens/reinvest_process/reinvestment_step_2.dart';
import 'package:finniu/presentation/screens/scan_document_v2/scan_document_screen_v2.dart';
import 'package:finniu/presentation/screens/send_code_v2/send_code_v2.dart';
import 'package:finniu/presentation/screens/signup/activate_account.dart';
import 'package:finniu/presentation/screens/calculator/calculator_screen.dart';
import 'package:finniu/presentation/screens/calculator/result_calculator_screen.dart';
import 'package:finniu/presentation/screens/calendar.dart';
import 'package:finniu/presentation/screens/finance/finance_screen.dart';
import 'package:finniu/presentation/screens/finance/finance_screen_2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_4.dart';
import 'package:finniu/presentation/screens/investment_status/investment_history.dart';
import 'package:finniu/presentation/screens/investment_status/investment_status_screen.dart';
import 'package:finniu/presentation/screens/pdf.dart';
import 'package:finniu/presentation/screens/settings/profile_screen.dart';
import 'package:finniu/presentation/screens/settings/transfers_screen.dart';
import 'package:finniu/presentation/screens/signup/confirmation_phone_screen.dart';
import 'package:finniu/presentation/screens/help/help_screen.dart';
import 'package:finniu/presentation/screens/home/home.dart';
import 'package:finniu/presentation/screens/home/notification.dart';
import 'package:finniu/presentation/screens/intro_screen.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/presentation/screens/onboarding_question/result.dart';
import 'package:finniu/presentation/screens/onboarding_question/question.dart';
import 'package:finniu/presentation/screens/onboarding_question/start_invesment.dart';
import 'package:finniu/presentation/screens/languages/languages_screen.dart';
import 'package:finniu/presentation/screens/login/email_screen.dart';
import 'package:finniu/presentation/screens/login/forgot_password.dart';
import 'package:finniu/presentation/screens/login/invalid_email.dart';
import 'package:finniu/presentation/screens/plans/plans_screen.dart';
import 'package:finniu/presentation/screens/settings/privacy_screen.dart';
import 'package:finniu/presentation/screens/signup/email_screen.dart';
import 'package:finniu/presentation/screens/login/start_screen.dart';
import 'package:finniu/presentation/screens/onboarding/start_onboarding.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_3.dart';
import 'package:finniu/presentation/screens/reinvest_process/reinvestment_step_1.dart';
import 'package:finniu/presentation/screens/simulator_v2/simulator_v2_screen.dart';
import 'package:finniu/presentation/screens/v2_user_profile/v2_register_screen.dart';
import 'package:finniu/presentation/screens/user_profil_v2/user_register_v2.dart';
import 'package:finniu/presentation/screens/investment_aggro/booking.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const IntroScreen(),
    '/login_start': (BuildContext context) => const StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/onboarding_questions': (BuildContext context) => const Questions(),
    '/sign_up_email': (BuildContext context) => const SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => const ForgotPassword(),
    '/login_invalid': (BuildContext context) => const InvalidEmail(),
    '/on_boarding_start': (BuildContext context) => StartOnboarding(),
    '/onboarding_questions_start': (BuildContext context) =>
        const StartInvestment(),
    '/investment_result': (BuildContext context) => const ResultInvestment(),
    '/home_home': (BuildContext context) => const HomeScreen(),
    '/home_v2': (BuildContext context) => const HomeScreenV2(),
    '/home_notification': (BuildContext context) => const NotificationScreen(),
    '/profile': (BuildContext context) => const ProfileScreen(),
    '/plan_list': (BuildContext context) => const PlanListScreen(),
    '/privacy': (BuildContext context) => const PrivacyScreen(),
    '/transfers': (BuildContext context) => TransfersScreen(),
    '/languages': (BuildContext context) => LanguagesStart(),
    '/help': (BuildContext context) => const HelpScreen(),
    '/send_code': (BuildContext context) => const SendCode(),
    '/investment_step1': (BuildContext context) => const Step1(),
    '/investment_step2': (BuildContext context) => const Step2(),
    '/investment_step3': (BuildContext context) => const Step3(),
    '/set_new_password': (BuildContext context) => const NewPassword(),
    '/calculator_tool': (BuildContext context) => const Calculator(),
    '/calculator_result': (BuildContext context) => const ResultCalculator(),
    '/finance': (BuildContext context) => const FinanceScreen(),
    '/catalog': (BuildContext context) => const CatalogScreen(),
    '/finance_screen2': (BuildContext context) => Finance_Screen_2(),
    '/contract_view': (BuildContext context) => const ContractViewPDF(),
    '/calendar_page': (BuildContext context) => const Calendar(),
    '/finish_investment': (BuildContext context) => const FinishInvestment(),
    '/process_investment': (BuildContext context) => InvestmentStatusScreen(),
    '/investment_history': (BuildContext context) => const InvestmentHistory(),
    '/reinvestment_step_1': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ReinvestmentStep1(
        preInvestmentUUID: args['preInvestmentUUID'],
        preInvestmentAmount: args['preInvestmentAmount'],
        currency: args['currency'],
        reInvestmentType: args['reInvestmentType'],
      );
    },
    '/reinvestment_step_2': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ReInvestmentStep2(
        plan: args['plan'],
        resultCalculator: args['resultCalculator'],
        reInvestment: args['reInvestment'],
      );
    },
    '/evaluation': (BuildContext context) => const EvalExperienceScreen(),
    '/empty_transference': (BuildContext context) => const EmptyTransference(),
    '/activate_account': (BuildContext context) => const ActivateAccount(),
    // '/fund_detail': (BuildContext context) => const FundDetailScreen(),
    '/fund_detail': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FundDetailScreen(
        fund: args['fund'],
      );
    },
    '/v2/investment/step-1': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return InvestmentProcessStep1Screen(
        fund: args['fund'],
        amount: args['amount'],
        deadLine: args['deadLine'],
        preInvestmentUUID: args['preInvestmentUUID'],
        isReInvestment: args['isReInvestment'],
        reInvestmentType: args['reInvestmentType'],
        currency: args['currency'],
        originInvestmentRentability: args['originInvestmentRentability'],
      );
    },
    '/v2/investment/step-2': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return InvestmentProcessStep2Screen(
        fund: args['fund'],
        preInvestmentUUID: args['preInvestmentUUID'],
        amount: args['amount'],
        isReInvestment: args['isReInvestment'] ?? false,
      );
    },
    '/v2/aggro-investment/booking': (BuildContext context) =>
        ManualConfirmationBookingWidget(),
    // '/v2/aggro-investment': (BuildContext context) => const InvestmentAggroProcessScreen(),
    '/v2/aggro-investment': (BuildContext context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return InvestmentAggroProcessScreen(
        fund: args['fund'],
      );
    },
    '/v2/investment_blue_gold': (BuildContext context) =>
        const InvestmentBlueGoldScreen(),
    '/v2/simulator': (BuildContext context) => const V2SimulatorScreen(),
    '/v2/binnacle': (BuildContext context) => const BinnacleScreen(),

    // '/fund_detail': (BuildContext context) => const FundDetailScreen(),
    // '/v2/investment/step-1': (BuildContext context) =>
    //     const InvestmentProcessStep1Screen(),
    // '/v2/investment/step-2': (BuildContext context) =>
    //     const InvestmentProcessStep2Screen(),
    // '/business_investment': (BuildContext context) =>
    //     const BusinessInvestmentsScreen(),
    // '/blue_gold_investment': (BuildContext context) =>
    //     const BlueGoldInvestmentsScreen(),
    // '/v2/investment_blue_gold': (BuildContext context) =>
    //     const InvestmentBlueGoldScreen(),
    '/v2/summary': (BuildContext context) => const V2SummaryScreen(),
    '/v2/calendar': (BuildContext context) => const CalendarV2(),
    '/v2/investment': (BuildContext context) => const InvestmentsV2Screen(),
    // '/v2/simulator': (BuildContext context) => const V2SimulatorScreen(),
    '/v2/notifications': (BuildContext context) => const NotificationsScreen(),
    '/v2/lot_detail': (BuildContext context) => const LotDetailScreenV2(),
    '/v2/register': (BuildContext context) => const RegisterScreenV2(),
    '/v2/send_code': (BuildContext context) => const SendCodeV2(),
    'v2/activate_account': (BuildContext context) => const ActivateAccountV2(),

    'v2/complete_details': (BuildContext context) =>
        const CompleteDetailsScreenV2(),
    'v2/validate_identity': (BuildContext context) =>
        const ValidateIdentityScreenV2(),
    '/v2/login': (BuildContext context) => const UserRegisterV2(),
    '/v2/verification_code': (BuildContext context) => const UserRegisterV2(),
    '/v2/activate_account': (BuildContext context) => const UserRegisterV2(),
    '/v2/upload_document': (BuildContext context) => const UserRegisterV2(),
    '/v2/scan_document': (BuildContext context) => const ScanDocumentScreenV2(),
    '/v2/form_personal_data': (BuildContext context) =>
        const FormPersonalDataV2(),
    '/v2/form_location': (BuildContext context) => const FormLocationDataV2(),
    '/v2/form_job': (BuildContext context) => const FormJobDataV2(),
    '/v2/form_legal_terms': (BuildContext context) =>
        const FormLegalTermsDataV2(),
    '/v2/form_about_me': (BuildContext context) => const AboutMeDataV2(),
    '/v2/profile': (BuildContext context) => const UserProfileV2(),
    '/v2/on_boarding': (BuildContext context) => const OnBoardingScreen(),
    '/v2/my_data': (BuildContext context) => const MyDataScreen(),
    '/v2/settings': (BuildContext context) => const SettingsScreen(),
    '/v2/new_notifications': (BuildContext context) =>
        const NotificationsScreenV2(),
    '/v2/privacy': (BuildContext context) => const PrivacyScreenV2(),
    '/v2/legal_documents': (BuildContext context) =>
        const LegalDocumentsScreen(),
    '/v2/support': (BuildContext context) => const SupportHelpScreen(),
    '/v2/support_ticket': (BuildContext context) => SupportTicketScreen(),
    '/v2/frequently_questions': (BuildContext context) =>
        const FrequentlyQuestionsScreen(),
    '/v2/edit_personal_data': (BuildContext context) =>
        const EditPersonalDataScreen(),
    '/v2/edit_location_data': (BuildContext context) =>
        const EditLocationDataScreen(),
    '/v2/edit_job_data': (BuildContext context) => const EditJobDataScreen(),
    '/v2/edit_about_me': (BuildContext context) => const EditAboutDataScreen(),
    '/v2/my_accounts': (BuildContext context) => const AccountsV2Screen(),
    '/v2/login_email': (BuildContext context) => const LoginScreenV2(),
  };
}
