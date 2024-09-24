// import 'dart:html';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
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
  final TextEditingController jointHolderNameController =
      TextEditingController();
  final TextEditingController jointHolderLastNameController =
      TextEditingController();
  final TextEditingController jointHolderMothersLastNameController =
      TextEditingController();
  final TextEditingController jointHolderDocTypeController =
      TextEditingController();
  final TextEditingController jointHolderDocNumberController =
      TextEditingController();
  final TextEditingController cciNumberController = TextEditingController();

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

  bool validate(BuildContext context) {
    bool result = true;
    if (bankController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Debe seleccionar un banco",
        message: "Debe seleccionar un banco",
        snackType: SnackType.warning,
      );

      return false;
    }
    if (accountTypeController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Debe seleccionar un tipo de cuenta",
        message: "Debe seleccionar un tipo de cuenta",
        snackType: SnackType.warning,
      );

      return false;
    }
    if (accountNumberController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Debe ingresar un número de cuenta",
        message: "Debe ingresar un número de cuenta",
        snackType: SnackType.warning,
      );

      return false;
    }
    if (cciNumberController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Debe ingresar un número de cuenta interbancaria",
        message: "Debe ingresar un número de cuenta interbancaria",
        snackType: SnackType.warning,
      );
      return false;
    }

    if (accountTypeController.text == 'Mancomunada' &&
        isJointAccount == false) {
      showSnackBarV2(
        context: context,
        title: "Debe completar los datos de la cuenta mancomunada",
        message: "Debe completar los datos de la cuenta mancomunada",
        snackType: SnackType.warning,
      );

      return false;
    }
    if (isJointAccount) {
      if (jointHolderNameController.text.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Debe ingresar el nombre del titular",
          message: "Debe ingresar el nombre del titular",
          snackType: SnackType.warning,
        );

        return false;
      }
      if (jointHolderLastNameController.text.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Debe ingresar el apellido paterno del titular",
          message: "Debe ingresar el apellido paterno del titular",
          snackType: SnackType.warning,
        );

        return false;
      }
      if (jointHolderMothersLastNameController.text.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Debe ingresar el apellido materno del titular",
          message: "Debe ingresar el apellido materno del titular",
          snackType: SnackType.warning,
        );

        return false;
      }
      if (jointHolderDocTypeController.text.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Debe seleccionar un tipo de documento",
          message: "Debe seleccionar un tipo de documento",
          snackType: SnackType.warning,
        );

        return false;
      }
      if (jointHolderDocNumberController.text.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Debe ingresar el número de documento",
          message: "Debe ingresar el número de documento",
          snackType: SnackType.warning,
        );

        return false;
      }
      if (jointHolderDocTypeController.text == 'DNI' &&
          jointHolderDocNumberController.text.length != 8) {
        showSnackBarV2(
          context: context,
          title: "El DNI debe tener 8 dígitos",
          message: "El DNI debe tener 8 dígitos",
          snackType: SnackType.warning,
        );

        return false;
      } else {
        if (jointHolderDocTypeController.text == 'Carnet de Extranjería' &&
            jointHolderDocNumberController.text.length != 20) {
          showSnackBarV2(
            context: context,
            title: "El Carnet de Extranjería debe tener 20 dígitos",
            message: "El Carnet de Extranjería debe tener 20 dígitos",
            snackType: SnackType.warning,
          );

          return false;
        }
      }
    }
    if (!isJointAccount) {
      if (!personalAccountDeclaration) {
        showSnackBarV2(
          context: context,
          title: "Debe declarar que es su cuenta personal",
          message: "Debe declarar que es su cuenta personal",
          snackType: SnackType.warning,
        );

        return false;
      }
    }

    return result;
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

  @override
  Widget build(BuildContext context) {
    final bankFuture = ref.watch(bankFutureProvider.future);
    final theme = ref.watch(settingsNotifierProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // color: theme.isDarkMode ? const Color(primaryDark) : const Color(primaryLight),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 324),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    widget.isSender
                        ? '¿Desde qué cuenta nos transfieres el dinero? 💸'
                        : "¿A qué cuenta transferimos tu rentabilidad? 💸",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: theme.isDarkMode
                          ? const Color(secondaryGrayText)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 320,
                  // constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
                  child: CustomSelectButton(
                    textEditingController: bankController,
                    asyncItems: (String filter) async {
                      final response = await bankFuture;
                      return response.map((e) => e.name).toList();
                    },
                    callbackOnChange: (value) {
                      bankController.text = value;
                    },
                    labelText: "Desde qué banco realizas la transferencia",
                    hintText: "Seleccione su banco",
                    width: MediaQuery.of(context).size.width * 0.8,
                    enableColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 320,
                  // constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
                  child: CustomSelectButton(
                    textEditingController: accountTypeController,
                    items: const ['Ahorros', 'Corriente'],
                    callbackOnChange: (value) {
                      accountTypeController.text = value;
                    },
                    labelText: "Tipo de cuenta",
                    hintText: "Selecciona el tipo de cuenta",
                    width: MediaQuery.of(context).size.width * 0.8,
                    enableColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "¿Es una cuenta mancomunada?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.isDarkMode
                            ? const Color(secondaryGrayText)
                            : const Color(primaryDark),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      isJointAccount ? "Sí" : "No",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.isDarkMode
                            ? const Color(secondaryGrayText)
                            : const Color(primaryDark),
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
                const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: jointHolderLastNameController,
                          decoration: const InputDecoration(
                            labelText: "Apellido Paterno",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: jointHolderMothersLastNameController,
                          decoration: const InputDecoration(
                            labelText: "Apellido Materno",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        constraints:
                            const BoxConstraints(minWidth: 154, maxWidth: 154),
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: jointHolderDocNumberController,
                          decoration: const InputDecoration(
                            labelText: "Número de documento",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
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
                        color: theme.isDarkMode
                            ? const Color(secondaryGrayText)
                            : const Color(primaryDark),
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
                        color: theme.isDarkMode
                            ? const Color(secondaryGrayText)
                            : const Color(primaryDark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      backgroundColor: const Color(primaryDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Guardar cuenta",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      if (!validate(context)) {
                        return; // Detener ejecución si la validación falla
                      }
                      context.loaderOverlay.show();

                      CreateBankAccountInput input = CreateBankAccountInput(
                        bankUUID: BankEntity.getUuidByName(
                          bankController.text,
                          await bankFuture,
                        ),
                        typeAccount: mapTypeAccount(accountTypeController.text),
                        currency: widget.currency == currencyEnum.PEN
                            ? 'SOLES'
                            : 'DOLARES',
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
                                documentNumber:
                                    jointHolderDocNumberController.text,
                              )
                            : null,
                      );
                      ref.read(createBankAccountProvider(input).future).then(
                        (response) {
                          if (response.success) {
                            context.loaderOverlay.hide();
                            ref.invalidate(bankAccountFutureProvider);
                            showSnackBarV2(
                              context: context,
                              title: "Cuenta guardada correctamente",
                              message: "Cuenta guardada correctamente",
                              snackType: SnackType.success,
                            );

                            //wait 3 seconds
                            ref
                                .read(
                                  boolCreatedNewBankAccountProvider.notifier,
                                )
                                .state = true;
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });
                          } else {
                            context.loaderOverlay.hide();
                            ref.invalidate(bankAccountFutureProvider);
                            showSnackBarV2(
                              context: context,
                              title: "Error al guardar la cuenta",
                              message:
                                  "Verifique los datos e intente nuevamente",
                              snackType: SnackType.error,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                //add return button , only text and underline

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      "Regresar",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.isDarkMode
                            ? const Color(secondaryGrayText)
                            : const Color(primaryDark),
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
      ),
    );
  }
}
