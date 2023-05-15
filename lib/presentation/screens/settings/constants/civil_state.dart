import 'package:flutter/material.dart';

class MaritalStatusMapper {
  final Map<String, String> mapping = {
    'Soltero': 'SINGLE',
    'Casado': 'MARRIED',
    'Divorciado': 'DIVORCED',
    'Viudo': 'WIDOWED'
  };

  final List<String> values = ['Soltero', 'Casado', 'Divorciado', 'Viudo'];

  // List<DropdownMenuItem<String>> getDropdownItems() {
  //   return values.map((value) {
  //     return DropdownMenuItem<String>(
  //       value: value,
  //       child: Text(value),
  //     );
  //   }).toList();
  // }

  String mapStatus(String selectValue) {
    return mapping[selectValue] ?? '';
  }
}
