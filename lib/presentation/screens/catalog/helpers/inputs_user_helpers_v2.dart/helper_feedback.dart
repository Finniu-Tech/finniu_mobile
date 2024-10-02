import 'package:finniu/infrastructure/datasources/nps_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DtoFedbackForm {
  final String message;
  final String rating;

  DtoFedbackForm({
    required this.message,
    required this.rating,
  });
}

pushFeedbackData(
  BuildContext context,
  DtoFedbackForm data,
  WidgetRef ref,
) async {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: "Error al registrar",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
  }
  final npsDataSource = NPSDataSourceImpl();
  final response = await npsDataSource.save(
    question: data.message,
    answer: data.rating,
    comment: "",
    client: gqlClient!,
  );

  if (response) {
    showSnackBarV2(
      context: context,
      title: "Experiencia registrada",
      message: "Gracias por compartir tu experiencia",
      snackType: SnackType.success,
    );
  } else {
    showSnackBarV2(
      context: context,
      title: "Error al registrar",
      message: "No se pudo registrar la experiencia",
      snackType: SnackType.error,
    );
    context.loaderOverlay.hide();
  }
}
