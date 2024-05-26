import 'dart:convert';
import 'package:flutter/material.dart';

class TypeUserNotificationEnum {
  static const String REINVESTMENT = 'POTENTIAL_RE_INVESTMENT';
  static const String IN_PROCESS = 'IN_PROCESS_INVESTMENT';
}

class UserNotificationEntity {
  final String title;
  final String message;
  final String type;
  final String? imageURL;
  final GradientData? gradient;
  final MetaDataReinvestment? metaData;

  UserNotificationEntity({
    required this.title,
    required this.message,
    required this.type,
    this.imageURL,
    this.gradient,
    this.metaData,
  });

  factory UserNotificationEntity.fromJson(Map<String, dynamic> json) {
    return UserNotificationEntity(
      title: json['title'],
      message: json['content'],
      imageURL: json['imageSlider'],
      type: json['type'],
      gradient: json['gradientData'] != null
          ? GradientData.fromJson(jsonDecode(json['gradientData'].replaceAll("'", "\"")))
          : null,
      metaData: json['metadata'] != null
          ? MetaDataReinvestment.fromJson(jsonDecode(json['metadata'].replaceAll("'", "\"")))
          : null,
    );
  }
}

class GradientData {
  final Color startColor;
  final Color endColor;

  GradientData({
    required this.startColor,
    required this.endColor,
  });

  factory GradientData.fromJson(Map<String, dynamic> json) {
    final colors = json['colors'];
    return GradientData(
      startColor: HexColor.fromHex(colors[0]['color']),
      endColor: HexColor.fromHex(colors[1]['color']),
    );
  }
}

class MetaDataReinvestment {
  final String preinvestmentUUID;
  final double amount;
  final double percentageBaseRentability;
  final double percentageFinalRentability;
  final String currency;

  MetaDataReinvestment({
    required this.preinvestmentUUID,
    required this.amount,
    required this.percentageBaseRentability,
    required this.percentageFinalRentability,
    required this.currency,
  });

  factory MetaDataReinvestment.fromJson(Map<String, dynamic> json) {
    return MetaDataReinvestment(
      preinvestmentUUID: json['pre_investment_uuid'],
      amount: double.parse(json['pre_investment_amount']),
      percentageBaseRentability: double.parse(json['pre_investment_percentage_base']),
      percentageFinalRentability: double.parse(json['pre_investment_percentage_final']),
      currency: json['pre_investment_currency'] == 'nuevo sol' ? 'PEN' : 'USD',
    );
  }
}

class HexColor extends Color {
  HexColor(final int hex) : super(hex);

  factory HexColor.fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return HexColor(int.parse(buffer.toString(), radix: 16));
  }
}
