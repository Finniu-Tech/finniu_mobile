import 'package:finniu/presentation/screens/calculator/calculator_screen.dart';
import 'package:finniu/presentation/screens/calculator/result_calculator_screen.dart';
import 'package:finniu/presentation/screens/calendar.dart';
import 'package:finniu/presentation/screens/finance/finance_screen.dart';
import 'package:finniu/presentation/screens/finance/finance_screen_2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_4.dart';
import 'package:finniu/presentation/screens/investment_process.dart/investment_history.dart';
import 'package:finniu/presentation/screens/investment_process.dart/investment_process_screen.dart';
import 'package:finniu/presentation/screens/pdf.dart';
import 'package:finniu/presentation/screens/reinvest_process.dart/reinvest_process_end.dart';
import 'package:finniu/presentation/screens/reinvest_process.dart/reinvest_process_start.dart';
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
import 'package:finniu/presentation/screens/privacy/privacy_screen.dart';
import 'package:finniu/presentation/screens/signup/email_screen.dart';
import 'package:finniu/presentation/screens/login/start_screen.dart';
import 'package:finniu/presentation/screens/onboarding/start_onboarding.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_3.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const IntroScreen(),
    '/login_start': (BuildContext context) => StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/onboarding_questions': (BuildContext context) => const Questions(),
    '/sign_up_email': (BuildContext context) => SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => const ForgotPassword(),
    '/login_invalid': (BuildContext context) => const InvalidEmail(),
    '/on_boarding_start': (BuildContext context) => StartOnboarding(),
    '/onboarding_questions_start': (BuildContext context) =>
        const StartInvestment(),
    '/investment_result': (BuildContext context) => const ResultInvestment(),
    '/home_home': (BuildContext context) => HomeScreen(),
    '/home_notification': (BuildContext context) => const NotificationScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/plan_list': (BuildContext context) => const PlanListScreen(),
    '/privacy': (BuildContext context) => PrivacyScreen(),
    '/transfers': (BuildContext context) => TransfersScreen(),
    '/languages': (BuildContext context) => LanguagesStart(),
    '/help': (BuildContext context) => const HelpScreen(),
    '/confirmation': (BuildContext context) => const ConfirmationPhone(),
    '/investment_step1': (BuildContext context) => Step1(),
    '/investment_step2': (BuildContext context) => const Step2(),
    '/investment_step3': (BuildContext context) => const Step3(),
    '/set_new_password': (BuildContext context) => const NewPassword(),
    '/calculator_tool': (BuildContext context) => const Calculator(),
    '/calculator_result': (BuildContext context) => const ResultCalculator(),
    '/finance': (BuildContext context) => const FinanceScreen(),
    '/finance_screen2': (BuildContext context) => Finance_Screen_2(),
    '/contract_view': (BuildContext context) => const ContractViewPDF(),
    '/calendar_page': (BuildContext context) => Calendar(),
    '/finish_investment': (BuildContext context) => const FinishInvestment(),
    '/process_investment': (BuildContext context) => InvestmentProcess(),
    '/investment_history': (BuildContext context) => InvestmentHistory(),
    '/reinvest': (BuildContext context) => const Reinvest(),
    '/reinvest_end': (BuildContext context) => ReinvestEnd(),
  };
}
