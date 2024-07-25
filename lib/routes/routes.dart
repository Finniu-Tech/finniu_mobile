import 'package:finniu/presentation/screens/blue_gold_investments/blue_gold_investment_screen.dart';
import 'package:finniu/presentation/screens/business_investments/business_investments_screen.dart';
import 'package:finniu/presentation/screens/catalog/catalog_screen.dart';
import 'package:finniu/presentation/screens/fund_detail/fund_detail_screen.dart';
import 'package:finniu/presentation/screens/home_v2/home_screen.dart';
import 'package:finniu/presentation/screens/investment_aggro/investment_aggro_process_screen.dart';
import 'package:finniu/presentation/screens/investment_process.dart/step_1_screen.dart';
import 'package:finniu/presentation/screens/investment_process.dart/step_2_screen.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/investment_blue_gold_screen.dart';
import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/reinvest_process/reinvestment_experience_eval.dart';
import 'package:finniu/presentation/screens/reinvest_process/reinvestment_step_2.dart';
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
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const IntroScreen(),
    '/login_start': (BuildContext context) => const StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/onboarding_questions': (BuildContext context) => const Questions(),
    '/sign_up_email': (BuildContext context) => SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => const ForgotPassword(),
    '/login_invalid': (BuildContext context) => const InvalidEmail(),
    '/on_boarding_start': (BuildContext context) => StartOnboarding(),
    '/onboarding_questions_start': (BuildContext context) => const StartInvestment(),
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
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ReinvestmentStep1(
        preInvestmentUUID: args['preInvestmentUUID'],
        preInvestmentAmount: args['preInvestmentAmount'],
        currency: args['currency'],
        reInvestmentType: args['reInvestmentType'],
      );
    },
    '/reinvestment_step_2': (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FundDetailScreen(
        fund: args['fund'],
      );
    },
    '/v2/investment/step-1': (BuildContext context) => const InvestmentProcessStep1Screen(),
    '/v2/investment/step-2': (BuildContext context) => const InvestmentProcessStep2Screen(),
    // '/v2/aggro-investment': (BuildContext context) => const InvestmentAggroProcessScreen(),
    '/v2/aggro-investment': (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return InvestmentAggroProcessScreen(
        fund: args['fund'],
      );
    },
    '/business_investment': (BuildContext context) => const BusinessInvestmentsScreen(),
    '/v2/investment_blue_gold': (BuildContext context) => const InvestmentBlueGoldScreen(),
    '/blue_gold_investment': (BuildContext context) => const BlueGoldInvestmentsScreen(),
    '/v2/simulator': (BuildContext context) => const V2SummaryScreen(),
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
    '/v2/simulator': (BuildContext context) => const V2SimulatorScreen(),
  };
}
