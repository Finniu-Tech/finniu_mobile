import 'package:finniu/screens/intro_screen.dart';
import 'package:finniu/screens/login/email_screen.dart';
import 'package:finniu/screens/login/forgot_password.dart';
import 'package:finniu/screens/login/invalid_email.dart';
import 'package:finniu/screens/signup/email_screen.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/screens/signup/welcome_finniu.dart';
import 'package:flutter/material.dart';
// import 'package:teve_empresa_app/src/pages/chapter.dart';
// import 'package:teve_empresa_app/src/pages/home.dart';
// import 'package:teve_empresa_app/src/pages/intro.dart';
// import 'package:teve_empresa_app/src/pages/program_list.dart';
// import 'package:teve_empresa_app/src/pages/search.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => IntroScreen(),
    '/login_start': (BuildContext context) => StartLoginScreen(),
    '/login_email': (BuildContext context) => EmailLoginScreen(),
    '/sign_up_email': (BuildContext context) => SignUpEmailScreen(),
    '/sign_up_welcome': (BuildContext context) => WelcomeFinniu(),
    '/login_forgot': (BuildContext context) => ForgotPassword(),
    '/login_invalid': (BuildContext context) => InvalidEmail(),
    // '/home': (BuildContext context) => HomePage(),
    // '/chapter': (BuildContext context) => ChapterPage(),
    // '/program_list': (BuildContext context) => ProgramListPage(),
    // '/search': (BuildContext context) => Search()
  };
}
