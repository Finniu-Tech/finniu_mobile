import 'package:finniu/screens/intro_screen.dart';

import 'package:finniu/screens/login/email_screen.dart';
import 'package:finniu/screens/login/forgot_password.dart';
import 'package:finniu/screens/login/invalid_email.dart';
import 'package:finniu/screens/signup/email_screen.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/screens/onboarding/start_onboarding.dart';
import 'package:flutter/material.dart';

import '../screens/investment_question.dart/start_invesment.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => IntroScreen(),
    '/login_start': (BuildContext context) => const StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/sign_up_email': (BuildContext context) => const SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => const ForgotPassword(),
    '/login_invalid': (BuildContext context) => const InvalidEmail(),
    '/on_boarding_start': (BuildContext context) => StartOnboarding(),
    '/investment_start': (BuildContext context) => const StartInvestment(),
    // '/home': (BuildContext context) => HomePage(),
    // '/chapter': (BuildContext context) => ChapterPage(),
    // '/program_list': (BuildContext context) => ProgramListPage(),
    // '/search': (BuildContext context) => Search()
  };
}
