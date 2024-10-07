import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class FirebaseTestScreen extends StatelessWidget {
  const FirebaseTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics
        .logEvent(name: 'en_pagina_firebase', parameters: <String, dynamic>{
      "prueba_parametro": 'test123',
    });
    return ScaffoldConfig(
      title: 'Firebase Test',
      children: Column(
        children: [
          const Text('Firebase Test'),
          ButtonInvestment(
            text: 'Firebase Test',
            onPressed: () => firebaseTest(),
          ),
        ],
      ),
    );
  }
}

void firebaseTest() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: "prueba");
}
