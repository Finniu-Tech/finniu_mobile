import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class UserRegisterV2 extends StatelessWidget {
  const UserRegisterV2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: TextPoppins(
          text: 'UserRegisterV2',
          fontSize: 20,
        ),
      ),
    );
  }
}
