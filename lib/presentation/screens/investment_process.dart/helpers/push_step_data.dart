import 'package:finniu/domain/entities/pre_investment.dart';
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

Future<bool> stepTwoPushData(context, ref, PushStepData pushStepData) async {
  try {
    bool success;
    String? errorMessage;

    if (pushStepData.isReInvestment) {
      final updateReInvestmentParams = UpdateReInvestmentParams(
        preInvestmentUUID: pushStepData.preInvestmentUUID,
        userReadContract: pushStepData.readContract,
        files: pushStepData.base64Image,
        bankAccountReceiver: pushStepData.bankAccountReceiverId,
        bankAccountSender: pushStepData.bankAccountSendedId,
      );

      final reInvestmentResponse = await ref.read(
        updateReInvestmentProvider(updateReInvestmentParams).future,
      );
      success = reInvestmentResponse.success;
      errorMessage = reInvestmentResponse.messages?.firstOrNull?.message;
    } else {
      final preInvestmentResponse = await PreInvestmentDataSourceImp().update(
        client: ref.watch(gqlClientProvider).value!,
        uuid: pushStepData.preInvestmentUUID,
        readContract: pushStepData.readContract,
        bankAccountReceiverUUID: pushStepData.bankAccountReceiverId,
        bankAccountSenderUUID: pushStepData.bankAccountSendedId,
        files: pushStepData.base64Image,
      );
      success = preInvestmentResponse.success;
      errorMessage = preInvestmentResponse.error;
    }

    if (!success) {
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
        message: errorMessage ?? 'Hubo un problema al guardar',
        snackType: SnackType.error,
      );
      return false;
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
      return true;
    }
  } catch (e) {
    showSnackBarV2(
      context: context,
      title: "Error",
      message: "Hubo un problema inesperado",
      snackType: SnackType.error,
    );
    return false;
  }
}
