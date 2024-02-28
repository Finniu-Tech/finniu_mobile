import 'package:flutter/material.dart';

class MaritalStatusMapper {
  final Map<String, String> mapping = {
    'Soltero': 'SINGLE',
    'Casado': 'MARRIED',
    'Divorciado': 'DIVORCED',
  };


  final List<String> values = ['Soltero', 'Casado', 'Divorciado'];

  String mapStatus(String selectValue) {
    return mapping[selectValue] ?? '';
  }

  String mapStatusToText(String selectValue) {
    return values.firstWhere((element) => mapStatus(element) == selectValue);
  }

}
