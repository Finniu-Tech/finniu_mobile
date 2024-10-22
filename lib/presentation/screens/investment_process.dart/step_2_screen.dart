import 'dart:io';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/datasources/contract_datasource_imp.dart';
import 'package:finniu/infrastructure/datasources/pre_investment_imp_datasource.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/simulation_modal/feedback_modal.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/accept_tems.dart';
import 'package:finniu/presentation/screens/investment_process.dart/helpers/step_helpers.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/buttons.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/header.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/modals.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:finniu/utils/color_utils.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class InvestmentProcessStep2Screen extends ConsumerWidget {
  final FundEntity fund;
  final String preInvestmentUUID;
  final String amount;
  final bool? isReInvestment;

  const InvestmentProcessStep2Screen({
    super.key,
    required this.fund,
    required this.preInvestmentUUID,
    required this.amount,
    this.isReInvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomLoaderOverlay(
      child: ScaffoldInvestment(
        isDarkMode: currentTheme.isDarkMode,
        backgroundColor: currentTheme.isDarkMode
            ? Color(fund.getHexDetailColorDark())
            : Color(fund.getHexDetailColorLight()),
        body: Step2Body(
          fund: fund,
          amount: amount,
          preInvestmentUUID: preInvestmentUUID,
          isReInvestment: isReInvestment,
        ),
      ),
    );
  }
}

class Step2Body extends HookConsumerWidget {
  final FundEntity fund;
  final String amount;
  final String preInvestmentUUID;
  final bool? isReInvestment;
  const Step2Body({
    super.key,
    required this.fund,
    required this.amount,
    required this.preInvestmentUUID,
    this.isReInvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final voucherImageBase64 = ref.watch(preInvestmentVoucherImagesProvider);
    final isSoles = ref.watch(isSolesStateProvider);

    final userReadContract = useState(false);
    ValueNotifier<BankAccount?> senderBankAccountState = useState(null);
    ValueNotifier<BankAccount?> receiverBankAccountState = useState(null);
    final effectExecuted = useState(false);

    final isDarkMode = currentTheme.isDarkMode;
    final String textCurrency = isSoles ? 'soles' : 'dólares';
    final String currencyValue = isSoles ? currencyEnum.PEN : currencyEnum.USD;
    final String symbolCurrency = isSoles ? 'S/' : 'US\$';

    useEffect(
      () {
        if (!effectExecuted.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedBankAccountSenderProvider.notifier).state = null;
            ref.read(selectedBankAccountReceiverProvider.notifier).state = null;
            ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
            ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
                [];
            ref.read(userAcceptedTermsProvider.notifier).state = false;
            effectExecuted.value = true;
          });
        }
        return null;
      },
      [],
    );

    ref.listen<BankAccount?>(selectedBankAccountSenderProvider,
        (previous, next) {
      senderBankAccountState.value = next;
    });

    ref.listen<BankAccount?>(selectedBankAccountReceiverProvider,
        (previous, next) {
      receiverBankAccountState.value = next;
    });

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          // margin: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderWidget(
                containerColor: isDarkMode
                    ? fund.getHexDetailColorSecondaryDark()
                    : fund.getHexDetailColorSecondaryLight(),
                textColor: aboutTextBusinessColor,
                iconColor: isDarkMode
                    ? fund.getHexDetailColorSecondaryDark()
                    : fund.getHexDetailColorSecondaryLight(),
                urlIcon: fund.iconUrl!,
                labelText: 'Acerca de',
              ),
              const SizedBox(height: 20),
              Text(
                fund.name,
                style: const TextStyle(
                  color: Color(primaryDark),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                child: Text(
                  'Agrega tus cuentas',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SelectBankAccountButtonWidget(
                isDarkMode: currentTheme.isDarkMode,
                onPressed: () {
                  showBankAccountModal(
                    context,
                    ref,
                    currencyValue,
                    true,
                    "",
                  );
                },
                textButton: senderBankAccountState.value == null
                    ? 'Desde qué banco nos transfieres'
                    : senderBankAccountState.value!.bankAccount,
                svgPath: 'assets/svg_icons/card-send.svg',
                backgroundColor: isDarkMode
                    ? Color(fund.getHexDetailColorSecondaryDark())
                    : Color(fund.getHexDetailColorSecondaryLight()),
              ),
              const SizedBox(height: 10),
              SelectBankAccountButtonWidget(
                isDarkMode: currentTheme.isDarkMode,
                onPressed: () {
                  showBankAccountModal(
                    context,
                    ref,
                    currencyValue,
                    false,
                    "",
                  );
                },
                textButton: receiverBankAccountState.value == null
                    ? 'A qué banco te depositamos'
                    : receiverBankAccountState.value!.bankAccount,
                svgPath: 'assets/svg_icons/card-receive.svg',
                backgroundColor: isDarkMode
                    ? Color(fund.getHexDetailColorSecondaryDark())
                    : Color(fund.getHexDetailColorSecondaryLight()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(
                              primaryDark,
                            ), // Reemplaza estos valores con tus constantes
                    ),
                    children: [
                      const TextSpan(
                        text: 'Realiza tu transferencia de ',
                      ),
                      TextSpan(
                        text: symbolCurrency,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: amount,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' a la cuenta bancaria de Finniu: ',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AccountNumbersWidget(
                currentTheme: currentTheme,
                textCurrency: textCurrency,
                isSoles: isSoles,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 305,
                // alignment: Alignment.centerLeft,
                child: Text(
                  'Adjunta tu constancia(s) de transferencia: ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 320,
                height: 73,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21),
                  ),
                  // color: const Color(primaryLightAlternative)
                  color: adjustColor(
                    currentTheme.isDarkMode
                        ? Color(fund.getHexDetailColorSecondaryDark())
                        : Color(fund.getHexDetailColorSecondaryLight()),
                  ),
                  border: Border.all(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryLightAlternative),
                    width: 1,
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(firebaseAnalyticsServiceProvider)
                                  .logCustomEvent(
                                eventName: FirebaseAnalyticsEvents.addVoucher,
                                parameters: {},
                              );
                              photoHelp(context);
                            },
                            child: ImageIcon(
                              const AssetImage('assets/icons/questions.png'),
                              size: 20, // Tamaño de la imagen
                              color: currentTheme.isDarkMode
                                  ? const Color(grayText)
                                  : const Color(
                                      primaryDark,
                                    ), // Color de la imagen
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            getImageFromGallery(context, ref);
                          },
                          // onTap: () async {
                          //   final ImagePicker picker = ImagePicker();
                          //   final List<XFile> images = await picker.pickMultiImage();

                          child: Builder(
                            builder: (context) {
                              final voucherPreview = ref.watch(
                                preInvestmentVoucherImagesPreviewProvider,
                              );
                              return voucherPreview.isEmpty
                                  ? ImageIcon(
                                      const AssetImage(
                                        'assets/icons/photo.png',
                                      ),
                                      color: currentTheme.isDarkMode
                                          ? const Color(grayText)
                                          : const Color(primaryDark),
                                    )
                                  : SizedBox(
                                      height:
                                          60, // Ajusta este valor según tus necesidades
                                      child: ListView.builder(
                                        scrollDirection: Axis
                                            .horizontal, // Hace que la lista sea horizontal
                                        itemCount: voucherPreview.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ), // Añade un espacio a la derecha de cada imagen
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Image.file(
                                                    File(voucherPreview[index]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Código para eliminar la imagen
                                                        List<String>
                                                            voucherImageBase64 =
                                                            ref.watch(
                                                          preInvestmentVoucherImagesProvider,
                                                        );
                                                        List<String>
                                                            voucherPreviewImage =
                                                            ref.watch(
                                                          preInvestmentVoucherImagesPreviewProvider,
                                                        );
                                                        List<String>
                                                            modifiedVoucherImageBase64 =
                                                            List.from(
                                                          voucherImageBase64,
                                                        );

                                                        List<String>
                                                            modifiedVoucherPreviewImage =
                                                            List.from(
                                                          voucherPreviewImage,
                                                        );

                                                        modifiedVoucherImageBase64
                                                            .removeAt(index);
                                                        modifiedVoucherPreviewImage
                                                            .removeAt(index);
                                                        ref
                                                                .read(
                                                                  preInvestmentVoucherImagesProvider
                                                                      .notifier,
                                                                )
                                                                .state =
                                                            modifiedVoucherImageBase64;
                                                        ref
                                                                .read(
                                                                  preInvestmentVoucherImagesPreviewProvider
                                                                      .notifier,
                                                                )
                                                                .state =
                                                            modifiedVoucherPreviewImage;
                                                      },
                                                      child: Container(
                                                        width: 16,
                                                        height: 16,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.black38,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 8,
                                                          color: Colors.white,
                                                        ), // Icono de "x"
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Suba la foto(s) nítida donde sea visible el código de operación',
                            style: TextStyle(
                              color: currentTheme.isDarkMode
                                  ? const Color(grayText)
                                  : const Color(primaryDark),
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 25,
                    child: AcceptedTermCheckBox(),
                  ),
                  Text(
                    'He leido y acepto el ',
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String contractURL =
                          await ContractDataSourceImp().getContract(
                        uuid: preInvestmentUUID,
                        client: ref.watch(gqlClientProvider).value!,
                      );

                      if (contractURL.isNotEmpty) {
                        userReadContract.value = true;

                        Navigator.pushNamed(
                          context,
                          '/contract_view',
                          arguments: {
                            'contractURL': contractURL,
                          },
                        );
                      }
                    },
                    child: Text(
                      ' Contrato de Inversión de Finniu ',
                      style: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 224,
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      var response;
                      final base64Image = voucherImageBase64;
                      if (base64Image.isEmpty) {
                        showSnackBarV2(
                          context: context,
                          title: "La constancia es requerida",
                          message:
                              'Debe subir una imagen de la constancia de transferencia',
                          snackType: SnackType.warning,
                        );

                        return;
                      }

                      if (ref.watch(userAcceptedTermsProvider) == false) {
                        showSnackBarV2(
                          context: context,
                          title: "Debe aceptar y leer el contrato",
                          message: 'Debe aceptar y leer el contrato',
                          snackType: SnackType.warning,
                        );

                        return;
                      }
                      if (senderBankAccountState.value == null ||
                          receiverBankAccountState.value == null) {
                        showSnackBarV2(
                          context: context,
                          title: "Debe seleccionar una cuenta bancaria",
                          message: 'Debe seleccionar una cuenta bancaria',
                          snackType: SnackType.warning,
                        );

                        return;
                      }
                      if (isReInvestment == true) {
                        context.loaderOverlay.show();
                        final UpdateReInvestmentParams
                            updateReInvestmentParams = UpdateReInvestmentParams(
                          preInvestmentUUID: preInvestmentUUID,
                          userReadContract:
                              ref.watch(userAcceptedTermsProvider),
                          files: base64Image,
                          bankAccountReceiver:
                              receiverBankAccountState.value!.id,
                          bankAccountSender: senderBankAccountState.value!.id,
                        );
                        response = await ref.read(
                          updateReInvestmentProvider(updateReInvestmentParams)
                              .future,
                        );
                      } else {
                        context.loaderOverlay.show();
                        response = await PreInvestmentDataSourceImp().update(
                          client: ref.watch(gqlClientProvider).value!,
                          uuid: preInvestmentUUID,
                          readContract: ref.watch(userAcceptedTermsProvider),
                          bankAccountReceiverUUID:
                              receiverBankAccountState.value!.id,
                          bankAccountSenderUUID:
                              senderBankAccountState.value!.id,
                          files: base64Image,
                        );
                      }

                      if (response.success == false) {
                        context.loaderOverlay.hide();
                        showSnackBarV2(
                          context: context,
                          title: "Error al guardar",
                          message:
                              response.error ?? 'Hubo un problema al guardar',
                          snackType: SnackType.error,
                        );
                      } else {
                        context.loaderOverlay.hide();
                        showFeedbackModal(
                          context,
                          isReInvestment: isReInvestment ?? false,
                        );
                      }
                    },
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all<double>(2),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.grey),
                    ),
                    child: const Text(
                      'Finalizar mi proceso',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
