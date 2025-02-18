import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/reinvest_process/helpers/create_bank_account.dart';
import 'package:finniu/presentation/screens/reinvest_process/helpers/validate_add_account.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void showAccountTransferModal(
  BuildContext context,
  String currency,
  bool isSender,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return AccountTransferModal(
        currency: currency,
        isSender: isSender,
      );
    },
  );
}

class AccountTransferModal extends StatefulHookConsumerWidget {
  const AccountTransferModal({
    super.key,
    required this.currency,
    required this.isSender,
  });

  @override
  AccountTransferModalState createState() => AccountTransferModalState();
  final String currency;
  final bool isSender;
}

class AccountTransferModalState extends ConsumerState<AccountTransferModal> {
  bool isJointAccount = false;
  bool personalAccountDeclaration = false;
  bool useForFutureOperations = false;
  final TextEditingController bankController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController jointHolderNameController = TextEditingController();
  final TextEditingController jointHolderLastNameController = TextEditingController();
  final TextEditingController jointHolderMothersLastNameController = TextEditingController();
  final TextEditingController jointHolderDocTypeController = TextEditingController();
  final TextEditingController jointHolderDocNumberController = TextEditingController();
  final TextEditingController cciNumberController = TextEditingController();
  List<SnackBarContainerV2> errors = [];

  final CarouselController errorsCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bankController.dispose();
    accountTypeController.dispose();
    accountNumberController.dispose();
    accountNameController.dispose();
    jointHolderNameController.dispose();
    jointHolderLastNameController.dispose();
    jointHolderMothersLastNameController.dispose();
    jointHolderDocTypeController.dispose();
    jointHolderDocNumberController.dispose();
    cciNumberController.dispose();
    super.dispose();
  }

  void validateIsPersonalAccount() {
    if (!isJointAccount) {
      jointHolderNameController.clear();
      jointHolderLastNameController.clear();
      jointHolderMothersLastNameController.clear();
      jointHolderDocTypeController.clear();
      jointHolderDocNumberController.clear();
    }
  }

  void saveAccount() async {
    final bankFuture = ref.watch(bankFutureProvider.future);
    List<SnackBarContainerV2> errorsInput = validateInputs(
      context: context,
      accountNameController: accountNameController,
      accountNumberController: accountNumberController,
      accountTypeController: accountTypeController,
      bankController: bankController,
      cciNumberController: cciNumberController,
      isJointAccount: isJointAccount,
      jointHolderDocNumberController: jointHolderDocNumberController,
      jointHolderDocTypeController: jointHolderDocTypeController,
      jointHolderLastNameController: jointHolderLastNameController,
      jointHolderMothersLastNameController: jointHolderMothersLastNameController,
      jointHolderNameController: jointHolderNameController,
      personalAccountDeclaration: personalAccountDeclaration,
    );
    if (errorsInput.isNotEmpty) {
      setState(() {
        errors = errorsInput;
      });
      return;
    }
    context.loaderOverlay.show();

    CreateBankAccountInput input = CreateBankAccountInput(
      bankUUID: BankEntity.getUuidByName(
        bankController.text,
        await bankFuture,
      ),
      typeAccount: mapTypeAccount(accountTypeController.text),
      currency: widget.currency == currencyEnum.PEN ? 'SOLES' : 'DOLARES',
      bankAccount: accountNumberController.text,
      cci: cciNumberController.text,
      aliasBankAccount: accountNameController.text,
      isDefault: useForFutureOperations,
      isPersonalAccount: personalAccountDeclaration,
      jointAccount: isJointAccount
          ? JointAccountInput(
              name: jointHolderNameController.text,
              lastName: jointHolderLastNameController.text,
              documentType: jointHolderDocTypeController.text,
              documentNumber: jointHolderDocNumberController.text,
            )
          : null,
    );
    final response = await createBankAccount(
      context: context,
      input: input,
      ref: ref,
    );

    if (response.isNotEmpty) {
      setState(() {
        errors = response;
      });
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bankFuture = ref.watch(bankFutureProvider.future);
    final theme = ref.watch(settingsNotifierProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        widget.isSender
                            ? '¿Desde qué cuenta nos transfieres el dinero ? 💸'
                            : "¿A qué cuenta transferimos tu rentabilidad? 💸",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomSelectButton(
                      textEditingController: bankController,
                      asyncItems: (String filter) async {
                        final response = await bankFuture;
                        return response.map((e) => e.name).toList();
                      },
                      callbackOnChange: (value) {
                        bankController.text = value;
                      },
                      labelText: widget.isSender
                          ? "Desde qué banco realizas la transferencia"
                          : "A qué banco transferimos tu rentabilidad",
                      hintText: "Seleccione su banco",
                      width: MediaQuery.of(context).size.width * 0.8,
                      enableColor: Colors.transparent,
                    ),
                    const SizedBox(height: 15),
                    CustomSelectButton(
                      textEditingController: accountTypeController,
                      items: const ['Ahorros', 'Corriente', 'Mancomunada'],
                      callbackOnChange: (value) {
                        accountTypeController.text = value;
                      },
                      labelText: "Tipo de cuenta",
                      hintText: "Selecciona el tipo de cuenta",
                      width: MediaQuery.of(context).size.width * 0.8,
                      enableColor: Colors.transparent,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: accountNumberController,
                      decoration: const InputDecoration(
                        labelText: "Número de cuenta bancaria",
                        hintText: "Escribe el número de cuenta",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: cciNumberController,
                      decoration: const InputDecoration(
                        labelText: "Número de cuenta interbancaria(CCI)",
                        hintText: "Escribe el número de cuenta interbancaria(CCI)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: accountNameController,
                      decoration: const InputDecoration(
                        labelText: "Nombre de la cuenta *Opcional",
                        hintText: "Escribe el nombre de la cuenta",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "¿Es una cuenta mancomunada?",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                          ),
                        ),
                        Text(
                          isJointAccount ? "Sí" : "No",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                          ),
                        ),
                        Switch(
                          value: isJointAccount,
                          onChanged: (value) {
                            setState(() {
                              isJointAccount = value;
                              if (!value) {
                                jointHolderNameController.clear();
                                jointHolderLastNameController.clear();
                                jointHolderMothersLastNameController.clear();
                                jointHolderDocTypeController.clear();
                                jointHolderDocNumberController.clear();
                              }
                            });
                          },
                          activeColor: const Color(primaryDark),
                        ),
                      ],
                    ),
                    if (isJointAccount) ...[
                      TextFormField(
                        controller: jointHolderNameController,
                        decoration: const InputDecoration(
                          labelText: "Nombres de la otra persona titular",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: jointHolderLastNameController,
                              decoration: const InputDecoration(
                                labelText: "Apellido Paterno",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: TextFormField(
                              controller: jointHolderMothersLastNameController,
                              decoration: const InputDecoration(
                                labelText: "Apellido Materno",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CustomSelectButton(
                              width: 154,
                              textEditingController: jointHolderDocTypeController,
                              items: const ['DNI', 'Carnet de Extranjería'],
                              callbackOnChange: (value) {
                                jointHolderDocTypeController.text = value;
                              },
                              labelText: "Tipo de documento",
                              hintText: "Selecciona el tipo de documento",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: TextFormField(
                              controller: jointHolderDocNumberController,
                              decoration: const InputDecoration(
                                labelText: "Número de documento",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                    Row(
                      children: [
                        Checkbox(
                          value: useForFutureOperations,
                          onChanged: (value) {
                            setState(() {
                              useForFutureOperations = value!;
                            });
                          },
                        ),
                        Text(
                          "Usar en mis futuras operaciones",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: personalAccountDeclaration,
                          onChanged: (value) {
                            setState(() {
                              personalAccountDeclaration = value!;
                            });
                          },
                        ),
                        Text(
                          "Declaro que es mi cuenta personal",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    errors.isNotEmpty
                        ? CarouselSlider(
                            carouselController: errorsCarouselController,
                            items: errors,
                            options: CarouselOptions(
                              autoPlayAnimationDuration: const Duration(seconds: 1),
                              height: 80,
                              autoPlay: true,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                if (index == errors.length - 1) {
                                  errorsCarouselController.stopAutoPlay();

                                  Future.delayed(const Duration(seconds: 2), () {
                                    setState(() {
                                      errors.clear();
                                    });
                                  });
                                }
                              },
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 15),
                    ButtonInvestment(
                      text: "Guardar cuenta",
                      onPressed: () => saveAccount(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          backgroundColor: WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          "Regresar",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // const Positioned(
            //   bottom: 40,
            //   child: Center(
            //     child: SnackBarContainerV2(
            //       title: "asd",
            //       message: "asd",
            //       snackType: SnackType.info,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
