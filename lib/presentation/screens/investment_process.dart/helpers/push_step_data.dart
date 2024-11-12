import 'package:finniu/infrastructure/datasources/pre_investment_imp_datasource.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/simulation_modal/feedback_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';

class PushStepData {
  final bool isReInvestment;
  final bool readContract;
  final String preInvestmentUUID;
  final List<String> base64Image;
  final String bankAccountReceiverId;
  final String bankAccountSendedId;
  PushStepData({
    required this.isReInvestment,
    required this.preInvestmentUUID,
    required this.readContract,
    required this.base64Image,
    required this.bankAccountReceiverId,
    required this.bankAccountSendedId,
  });
}

void stepTwoPushData(context, ref, PushStepData pushStepData) async {
  var response;
  if (pushStepData.isReInvestment == true) {
    final UpdateReInvestmentParams updateReInvestmentParams =
        UpdateReInvestmentParams(
      preInvestmentUUID: pushStepData.preInvestmentUUID,
      userReadContract: pushStepData.readContract,
      files: pushStepData.base64Image,
      bankAccountReceiver: pushStepData.preInvestmentUUID,
      bankAccountSender: pushStepData.bankAccountSendedId,
    );
    response = await ref.read(
      updateReInvestmentProvider(updateReInvestmentParams).future,
    );
  } else {
    response = await PreInvestmentDataSourceImp().update(
      client: ref.watch(gqlClientProvider).value!,
      uuid: pushStepData.preInvestmentUUID,
      readContract: pushStepData.readContract,
      bankAccountReceiverUUID: pushStepData.bankAccountReceiverId,
      bankAccountSenderUUID: pushStepData.bankAccountSendedId,
      files: pushStepData.base64Image,
    );
  }

  if (response.success == false) {
    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
      eventName: FirebaseAnalyticsEvents.pushDataError,
      parameters: {
        "screen": FirebaseScreen.investmentStep2V2,
        "event": "error_push_data",
      },
    );
    showSnackBarV2(
      context: context,
      title: "Error al guardar",
      message: response.error ?? 'Hubo un problema al guardar',
      snackType: SnackType.error,
    );
  } else {
    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
      eventName: FirebaseAnalyticsEvents.pushDataSucces,
      parameters: {
        "screen": FirebaseScreen.investmentStep2V2,
        "event": "success_push_data",
      },
    );

    showFeedbackModal(
      context,
      isReInvestment: pushStepData.isReInvestment,
    );
  }
}
