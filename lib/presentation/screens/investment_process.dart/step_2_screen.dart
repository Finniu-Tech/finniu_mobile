import 'dart:convert';
import 'dart:io';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/infrastructure/datasources/contract_datasource_imp.dart';
import 'package:finniu/infrastructure/datasources/pre_investment_imp_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/accept_tems.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../investment_confirmation/widgets/modal_set_bank_account_user_input.dart';

class InvestmentProcessStep2Screen extends ConsumerWidget {
  const InvestmentProcessStep2Screen({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomLoaderOverlay(
      child: ScaffoldInvestment(
        isDarkMode: currentTheme.isDarkMode,
        backgroundColor:
            currentTheme.isDarkMode ? const Color(scaffoldBlackBackground) : const Color(scaffoldSkyBlueBackground),
        body: const Step2Body(),
      ),
    );
  }
}

class Step2Body extends HookConsumerWidget {
  const Step2Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final voucherImageBase64 = ref.watch(preInvestmentVoucherImagesProvider);
    final userReadContract = useState(false);
    final isSoles = ref.watch(isSolesStateProvider);
    final String textCurrency = isSoles ? 'soles' : 'dólares';

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                width: 310,
                height: 40,
                child: Text(
                  // plan.name,
                  'Plan test',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(Theme.of(context).colorScheme.secondary.value),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: 100,
                      // width: MediaQuery.of(context).size.width * 0.60,
                      // width: double.maxFinite,
                      alignment: Alignment.center,

                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircularImage(
                            // months: resultCalculator.months,
                            months: 12,
                            planImageUrl:
                                'https://finniu-statics.s3.amazonaws.com/finniu/images/plan/b16f8016/7dd34ecb.png',
                            // planImageUrl: plan.imageUrl,
                          ),
                          Positioned(
                            right: 108,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 59.49,
                                height: 35,
                                // padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                                  border: Border.all(
                                    width: 4,
                                    color:
                                        currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // color: Color(primaryDark),

                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        // '${resultCalculator.finalRentability?.toString() ?? 0}% ',
                                        '10.00%',
                                        style: TextStyle(
                                          color: currentTheme.isDarkMode
                                              ? const Color(primaryDark)
                                              : const Color(primaryLight),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Rentabilidad',
                                      style: TextStyle(
                                        color:
                                            currentTheme.isDarkMode ? const Color(blackText) : const Color(whiteText),
                                        fontSize: 7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 116,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(primaryLight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // isSoles
                                //     ? formatterSoles.format(preInvestment.amount)
                                //     : formatterUSD.format(preInvestment.amount),
                                '11 000.00',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(primaryDark),
                                ),
                              ),
                              const Text(
                                'Tu monto invertido',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(blackText),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 60,
                          width: 116,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(secondary),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // isSoles
                                //     ? formatterSoles.format(resultCalculator.profitability)
                                //     : formatterUSD.format(resultCalculator.profitability),
                                '11 000.00',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(primaryDark),
                                ),
                              ),
                              const Text(
                                'Monto que recibirás',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(blackText),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                child: Text(
                  'Realiza tu transferencia a la cuenta bancaria de Finniu: ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 320,
                height: 154,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(38),
                  ),
                  color: currentTheme.isDarkMode
                      ? const Color(
                          primaryDark,
                        )
                      : const Color(gradient_secondary),
                  border: Border.all(
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(gradient_secondary),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Finniu S.A.C',
                          style: TextStyle(
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'RUC ',
                              style: TextStyle(
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '20609327210',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              'N de cuenta $textCurrency Interbank ',
                              style: TextStyle(
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              isSoles ? '2003004077570' : '2003004754309',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: isSoles ? "2003004077570" : "2003004754309",
                                  ),
                                ).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Copiado!'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: ImageIcon(
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                                size: 18,
                                const AssetImage(
                                  'assets/icons/double_square.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              'CCI ',
                              style: TextStyle(
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              isSoles ? '003 200 00300407757039' : '003 20000300475430932',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: isSoles ? "00320000300407757039" : '00320000300475430932',
                                  ),
                                ).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Copiado!'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: ImageIcon(
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                                size: 18,
                                const AssetImage(
                                  'assets/icons/double_square.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 305,
                // alignment: Alignment.centerLeft,
                child: Text(
                  'Adjunta tu constancia de transferencia: ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
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
                  color: const Color(primaryLight),
                  border: Border.all(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryLightAlternative),
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
                              photoHelp(context);
                            },
                            child: ImageIcon(
                              const AssetImage('assets/icons/questions.png'),
                              size: 20, // Tamaño de la imagen
                              color: currentTheme.isDarkMode
                                  ? const Color(grayText)
                                  : const Color(primaryDark), // Color de la imagen
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final List<XFile> images = await picker.pickMultiImage();

                            if (images.isNotEmpty) {
                              var voucherImageListBase64 = [];
                              var voucherImageListPreview = [];
                              for (var image in images) {
                                final File imageFile = File(image.path);
                                final List<int> imageBytes = await imageFile.readAsBytes();
                                final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";
                                voucherImageListBase64.add(base64Image);
                                voucherImageListPreview.add(image.path);
                              }
                              ref.read(preInvestmentVoucherImagesProvider.notifier).state =
                                  List.from(voucherImageListBase64);
                              ref
                                  .read(
                                    preInvestmentVoucherImagesPreviewProvider.notifier,
                                  )
                                  .state = List.from(voucherImageListPreview);
                            }
                          },
                          child: Builder(
                            builder: (context) {
                              final voucherPreview = ref.watch(preInvestmentVoucherImagesPreviewProvider);
                              return voucherPreview.isEmpty
                                  ? ImageIcon(
                                      const AssetImage('assets/icons/photo.png'),
                                      color: currentTheme.isDarkMode ? const Color(grayText) : const Color(primaryDark),
                                    )
                                  : SizedBox(
                                      height: 60, // Ajusta este valor según tus necesidades
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal, // Hace que la lista sea horizontal
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
                                                  padding: const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Código para eliminar la imagen
                                                        List<String> voucherImageBase64 = ref.watch(
                                                          preInvestmentVoucherImagesProvider,
                                                        );
                                                        List<String> voucherPreviewImage = ref.watch(
                                                          preInvestmentVoucherImagesPreviewProvider,
                                                        );
                                                        List<String> modifiedVoucherImageBase64 = List.from(
                                                          voucherImageBase64,
                                                        );

                                                        List<String> modifiedVoucherPreviewImage = List.from(
                                                          voucherPreviewImage,
                                                        );

                                                        modifiedVoucherImageBase64.removeAt(index);
                                                        modifiedVoucherPreviewImage.removeAt(index);
                                                        ref
                                                            .read(
                                                              preInvestmentVoucherImagesProvider.notifier,
                                                            )
                                                            .state = modifiedVoucherImageBase64;
                                                        ref
                                                            .read(
                                                              preInvestmentVoucherImagesPreviewProvider.notifier,
                                                            )
                                                            .state = modifiedVoucherPreviewImage;
                                                      },
                                                      child: Container(
                                                        width: 16,
                                                        height: 16,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.black38, // Color semitransparente
                                                          shape: BoxShape.circle, // Forma redonda
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
                            'Suba la foto nitida donde sea visible el código de operación',
                            style: TextStyle(
                              color: currentTheme.isDarkMode ? const Color(grayText) : const Color(primaryDark),
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
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String contractURL = await ContractDataSourceImp().getContract(
                        // uuid: preInvestment.uuid,
                        uuid: "123123123",
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
                        color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
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
              SizedBox(
                width: 224,
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    final base64Image = voucherImageBase64;
                    if (base64Image.isEmpty) {
                      CustomSnackbar.show(
                        context,
                        'Debe subir una imagen de la constancia de transferencia',
                        'error',
                      );
                      return;
                    }

                    if (ref.watch(userAcceptedTermsProvider) == false) {
                      CustomSnackbar.show(
                        context,
                        'Debe aceptar y leer el contrato',
                        'error',
                      );
                      return;
                    }
                    context.loaderOverlay.show();
                    final response = await PreInvestmentDataSourceImp().update(
                      client: ref.watch(gqlClientProvider).value!,
                      // uuid: preInvestment.uuid,
                      uuid: "123123123",
                      readContract: ref.watch(userAcceptedTermsProvider),
                      files: base64Image,
                    );
                    if (response.success == false) {
                      context.loaderOverlay.hide();
                      CustomSnackbar.show(
                        context,
                        response.error ?? 'Hubo un problema al guardar',
                        'error',
                      );
                    } else {
                      final isSoles = ref.watch(isSolesStateProvider);
                      final currency = isSoles ? currencyEnum.PEN : currencyEnum.USD;
                      // showBankAccountSetBankMutationModal(context, ref, currency, false, "", preInvestment.uuid);
                      showBankAccountSetBankMutationModal(context, ref, currency, false, "", "123123123");
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}