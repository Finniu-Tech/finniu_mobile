import 'package:finniu/screens/intro_screen.dart';
import 'package:finniu/screens/login/email_screen.dart';
import 'package:finniu/screens/login/forgot_password.dart';
import 'package:finniu/screens/login/invalid_email.dart';
import 'package:finniu/screens/signup/email_screen.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/screens/signup/finally_welcome.dart';
import 'package:finniu/screens/signup/middle_welcome.dart';
import 'package:finniu/screens/signup/start_welcome.dart';
import 'package:finniu/screens/signup/welcome_finniu.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => IntroScreen(),
    '/login_start': (BuildContext context) => StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/sign_up_email': (BuildContext context) => SignUpEmailScreen(),
    '/login_forgot': (BuildContext context) => ForgotPassword(),
    '/login_invalid': (BuildContext context) => InvalidEmail(),
    '/sign_up_welcome': (BuildContext context) => WelcomeFinniu(),
    '/sign_up_start': (BuildContext context) => StartWelcomeFinniu(),
    '/sign_up_middle': (BuildContext context) => WelcomeMiddle(),
    '/sign_up_finally': (BuildContext context) => WelcomeFinally(),

    // '/home': (BuildContext context) => HomePage(),
    // '/chapter': (BuildContext context) => ChapterPage(),
    // '/program_list': (BuildContext context) => ProgramListPage(),
    // '/search': (BuildContext context) => Search()
  };
}
