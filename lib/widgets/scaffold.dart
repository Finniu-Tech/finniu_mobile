import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomScaffoldReturn extends StatefulWidget {
  const CustomScaffoldReturn({super.key});

  @override
  State<CustomScaffoldReturn> createState() => _CustomScaffoldReturnState();
}

class _CustomScaffoldReturnState extends State<CustomScaffoldReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: CustomReturnButtom(),
      ),
    );
  }
}

//custom_scaffold_logo

class CustomScaffoldLogo extends StatefulWidget {
  const CustomScaffoldLogo({super.key});

  @override
  _CustomScaffoldLogoState createState() => _CustomScaffoldLogoState();
}

class _CustomScaffoldLogoState extends State<CustomScaffoldReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: CustomReturnButtom(),
      ),
    );
  }
}

//custom_scaffold_returnlogo

class CustomScaffoldReturnLogo extends StatefulWidget {
  const CustomScaffoldReturnLogo({super.key});

  @override
  _CustomScaffoldReturnLogo createState() => _CustomScaffoldReturnLogo();
}

class _CustomScaffoldReturnLogo extends State<CustomScaffoldReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: CustomReturnButtom(),
      ),
    );
  }
}
