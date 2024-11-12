import 'package:finniu/infrastructure/datasources/forms_v2/support_ticket_formv2_imp.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DtoSupportForm {
  final String category;
  final String email;
  final String firstName;
  final String lastName;
  final String message;
  final String imageBase64;

  const DtoSupportForm({
    required this.category,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.imageBase64,
  });
}

Future<bool?> sendTicketSupport(
  BuildContext context,
  DtoSupportForm data,
  WidgetRef ref,
) async {
  final gqlClient = ref.watch(gqlClientProvider).value;

  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: "Error al enviar el ticket",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
  }
  final Future<bool> response =
      SupportTicketFormv2Imp(gqlClient!).saveSupportTicketV2(
    data: data,
  );
  response.then((value) {
    if (value) {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataSucces,
        parameters: {
          "screen": FirebaseScreen.supportTicketV2,
          "success": "push_data_succes",
        },
      );
      context.loaderOverlay.hide();
      showSnackBarV2(
        context: context,
        title: "Ticket enviado con exito",
        message: "Se a enviado un ticket de soporte",
        snackType: SnackType.success,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home_v2',
        (route) => false,
      );
      return value;
    } else {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataError,
        parameters: {
          "screen": FirebaseScreen.supportTicketV2,
          "error": "push_data_error",
        },
      );
      context.loaderOverlay.hide();
      showSnackBarV2(
        context: context,
        title: "Error al enviar el ticket",
        message: "No se pudo conectar con el servidor",
        snackType: SnackType.error,
      );
      return value;
    }
  });
  return null;
}
