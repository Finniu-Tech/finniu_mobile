import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseTestScreen extends ConsumerWidget {
  const FirebaseTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsService = ref.watch(firebaseAnalyticsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ButtonInvestment(
              text: 'log event',
              onPressed: () async => await analyticsService
                  .logCustomEvent("test_event", {"param1": "value1"}),
            ),
            const SizedBox(height: 10),
            ButtonInvestment(
              text: 'logAddToWishlist',
              onPressed: () async => await analyticsService.logAddToWishlist(),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "registra un evento de inicio de sesion",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'set logLogin',
              onPressed: () async => await analyticsService.logLogin("Email"),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "permiten definir atributos que pueden segmentar a los usuarios",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'set id',
              onPressed: () async =>
                  await analyticsService.setUserId("user_id_123"),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Establece una propiedad de usuario personalizada. Las propiedades de usuario te permiten definir atributos que pueden segmentar a los usuarios en Firebase.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'set UserProperty',
              onPressed: () async => await analyticsService.setUserProperty(
                  "user_type", "premium"),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Habilita o deshabilita la recolección de datos de análisis.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'setAnalyticsCollectionEnabled',
              onPressed: () async =>
                  await analyticsService.setAnalyticsCollectionEnabled(true),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "deshabilita la recolección de datos de análisis.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'setAnalyticsCollectionEnabledFalse',
              onPressed: () async =>
                  await analyticsService.setAnalyticsCollectionEnabled(false),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Establece la duración del tiempo de espera de sesión.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'setSessionTimeoutDuration',
              onPressed: () async => await analyticsService
                  .setSessionTimeoutDuration(const Duration(minutes: 30)),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Elimina todos los datos analíticos asociados con el dispositivo actual",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'resetAnalyticsData',
              onPressed: () async =>
                  await analyticsService.resetAnalyticsData(),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Registra un evento que indica que la aplicación ha sido abierta.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logAppOpen',
              onPressed: () async => await analyticsService.logAppOpen(),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Registra la selección de algún contenido",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logSelectContent',
              onPressed: () async => await analyticsService.logSelectContent(
                "content_type",
                "item_id",
              ),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Registra el inicio de un tutorial.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logTutorialBegin',
              onPressed: () async => await analyticsService.logTutorialBegin(),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Registra la finalización de un tutorial.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logTutorialComplete',
              onPressed: () async =>
                  await analyticsService.logTutorialComplete(),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Registra una transacción de compra.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logPurchase',
              onPressed: () async => await analyticsService.logPurchase(
                "USD",
                9.99,
                "transaction_id_123",
              ),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Registra cuando un usuario agrega un artículo al carrito de compras.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logAddToCart',
              onPressed: () async =>
                  await analyticsService.logAddToCart("USD", 19.99),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text:
                  "Registra cuando un usuario quita un artículo del carrito de compras.",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'logRemoveFromCart',
              onPressed: () async =>
                  await analyticsService.logRemoveFromCart("USD", 19.99),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "registrar manualmente la pantalla actual",
              fontSize: 20,
            ),
            ButtonInvestment(
              text: 'firebaseLogScreenView',
              onPressed: () async => await analyticsService.logScreenView(
                "current_screen",
                "FirebaseTestScreen",
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
