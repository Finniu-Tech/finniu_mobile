import 'package:finniu/screens/intro_screen.dart';

import 'package:finniu/screens/login/email_screen.dart';
import 'package:finniu/screens/login/forgot_password.dart';
import 'package:finniu/screens/login/invalid_email.dart';
import 'package:finniu/screens/signup/email_screen.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/screens/onboarding/finally_welcome.dart';
import 'package:finniu/screens/onboarding/middle_welcome.dart';
import 'package:finniu/screens/onboarding/start_welcome.dart';
import 'package:finniu/screens/onboarding/welcome_finniu.dart';
import 'package:flutter/material.dart';

import '../screens/investment_question.dart/start_invesment.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => IntroScreen(),
    '/login_start': (BuildContext context) => StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/sign_up_email': (BuildContext context) => SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => ForgotPassword(),
    '/login_invalid': (BuildContext context) => InvalidEmail(),
    '/on_boarding_welcome': (BuildContext context) => WelcomeFinniu(),
    '/on_boarding_start': (BuildContext context) => StartWelcomeFinniu(),
    '/on_boarding_middle': (BuildContext context) => WelcomeMiddle(),
    '/on_boarding_finally': (BuildContext context) => WelcomeFinally(),
    '/investment_start': (BuildContext context) => StartInvestment(),
    // '/home': (BuildContext context) => HomePage(),
    // '/chapter': (BuildContext context) => ChapterPage(),
    // '/program_list': (BuildContext context) => ProgramListPage(),
    // '/search': (BuildContext context) => Search()
  };
}
