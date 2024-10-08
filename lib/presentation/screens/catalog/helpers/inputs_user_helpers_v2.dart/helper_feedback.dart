import 'package:finniu/infrastructure/datasources/nps_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DtoFedbackForm {
  final String question;
  final String answer;
  final String? questionSecond;
  final String? answerSecond;

  DtoFedbackForm({
    required this.question,
    required this.answer,
    this.questionSecond,
    this.answerSecond,
  });
}

Future<bool> pushFeedbackData(
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
    return false;
  }

  final npsDataSource = NPSDataSourceImpl();
  final futures = <Future<bool>>[];
  futures.add(
    npsDataSource.save(
      question: data.question,
      answer: data.answer,
      comment: "",
      client: gqlClient,
    ),
  );
  if (data.answerSecond != null) {
    futures.add(
      npsDataSource.save(
        question: data.questionSecond ?? "",
        answer: data.answerSecond ?? "",
        comment: "",
        client: gqlClient,
      ),
    );
  }

  final results = await Future.wait(futures);

  if (results.every((result) => result)) {
    return true;
  } else {
    return false;
  }
}
