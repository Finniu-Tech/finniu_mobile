import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class FirebaseTestScreen extends StatelessWidget {
  const FirebaseTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldConfig(
      title: 'Firebase Test',
      children: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ButtonInvestment(
            text: 'log event',
            onPressed: () => firebaseLogEvent(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "registra un evento de inicio de sesion",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'set logLogin',
            onPressed: () => firebaseLogLogin(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "permiten definir atributos que pueden segmentar a los usuarios",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'set id',
            onPressed: () => firebaseSetId(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "Establece una propiedad de usuario personalizada. Las propiedades de usuario te permiten definir atributos que pueden segmentar a los usuarios en Firebase.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'set UserProperty',
            onPressed: () => firebaseSetUserProperty(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Habilita o deshabilita la recolección de datos de análisis.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'setAnalyticsCollectionEnabled',
            onPressed: () => firebaseSetAnalyticsCollectionEnabled(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: " deshabilita la recolección de datos de análisis.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'setAnalyticsCollectionEnabledFalse',
            onPressed: () => firebaseSetAnalyticsCollectionEnabledFalse(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Establece la duración del tiempo de espera de sesión.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'setSessionTimeoutDuration',
            onPressed: () => firebaseSetSessionTimeoutDuration(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "Elimina todos los datos analíticos asociados con el dispositivo actual",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'resetAnalyticsData',
            onPressed: () => firebaseResetAnalyticsData(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "Registra un evento que indica que la aplicación ha sido abierta.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logAppOpen',
            onPressed: () => firebaseLogAppOpen(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Registra la selección de algún contenido",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logSelectContent',
            onPressed: () => firebaseLogSelectContent(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Registra el inicio de un tutorial.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logTutorialBegin',
            onPressed: () => firebaseLogTutorialBegin(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Registra la finalización de un tutorial.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logTutorialComplete',
            onPressed: () => firebaseLogTutorialComplete(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "Registra una transacción de compra.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logPurchase',
            onPressed: () => firebaseLogPurchase(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "Registra cuando un usuario agrega un artículo al carrito de compras.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logAddToCart',
            onPressed: () => firebaseLogAddToCart(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text:
                "Registra cuando un usuario quita un artículo del carrito de compras.",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'logRemoveFromCart',
            onPressed: () => firebaseLogRemoveFromCart(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextPoppins(
            text: "registrar manualmente la pantalla actual",
            fontSize: 20,
          ),
          ButtonInvestment(
            text: 'firebaseLogScreenView',
            onPressed: () => firebaseLogScreenView(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

void firebaseLogEvent() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(
      name: "prueba_global_true",
      parameters: {
        "prueba": "prueba",
        "prueba2": "prueba2",
      },
      callOptions: AnalyticsCallOptions(global: true));
}

void firebaseSetId() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setUserId(id: "userId");
}

void firebaseLogLogin() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logLogin(loginMethod: "email@gmail.com");
}

void firebaseSetUserProperty() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setUserProperty(
    name: 'preferencia_lenguaje',
    value: 'español',
  );
}

void firebaseSetAnalyticsCollectionEnabled() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);
}

void firebaseSetAnalyticsCollectionEnabledFalse() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(false);
}

void firebaseSetSessionTimeoutDuration() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setSessionTimeoutDuration(const Duration(minutes: 10));
}

void firebaseResetAnalyticsData() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.resetAnalyticsData();
}

void firebaseLogAppOpen() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();
}

void firebaseLogSelectContent() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logSelectContent(
    contentType: 'imagen',
    itemId: 'imagen_123',
  );
}

void firebaseLogTutorialBegin() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logTutorialBegin();
}

void firebaseLogTutorialComplete() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logTutorialComplete();
}

void firebaseLogPurchase() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logPurchase(
    currency: 'Sol',
    value: 9.99,
    transactionId: 'txn_12345',
  );
}

void firebaseLogAddToCart() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAddToCart(
    currency: 'Sol',
    value: 19.99,
  );
}

void firebaseLogRemoveFromCart() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logRemoveFromCart(
    currency: 'Sol',
    value: 19.99,
  );
}

void firebaseLogScreenView() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logScreenView(
    screenName: 'screenName',
    screenClass: 'screenClass',
  );
}
