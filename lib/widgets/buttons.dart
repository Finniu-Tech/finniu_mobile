import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 230,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(primary_light),
          ),
          child: Center(
            child: Text(
              'Registrarme',
              style: TextStyle(
                  color: const Color(primary_dark),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
