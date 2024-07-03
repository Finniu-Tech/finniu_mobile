// import 'dart:html';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  _AccountTransferModalState createState() => _AccountTransferModalState();
  final String currency;
  final bool isSender;
}

class _AccountTransferModalState extends ConsumerState<AccountTransferModal> {
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
    super.dispose();
  }

  bool validate(BuildContext context) {
    bool result = true;
    if (bankController.text.isEmpty) {
      CustomSnackbar.show(context, "Debe seleccionar un banco", 'error');
      return false;
    }
    if (accountTypeController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        "Debe seleccionar un tipo de cuenta",
        'error',
      );
      return false;
    }
    if (accountNumberController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        "Debe ingresar un número de cuenta",
        'error',
      );
      return false;
    }
    if (accountNumberController.text.length > 20) {
      CustomSnackbar.show(context, "El número de cuenta es inválido", 'error');
      return false;
    }
    if (isJointAccount) {
      if (jointHolderNameController.text.isEmpty) {
        CustomSnackbar.show(
          context,
          "Debe ingresar el nombre del titular",
          'error',
        );
        return false;
      }
      if (jointHolderLastNameController.text.isEmpty) {
        CustomSnackbar.show(
          context,
          "Debe ingresar el apellido paterno del titular",
          'error',
        );
        return false;
      }
      if (jointHolderMothersLastNameController.text.isEmpty) {
        CustomSnackbar.show(
          context,
          "Debe ingresar el apellido materno del titular",
          'error',
        );
        return false;
      }
      if (jointHolderDocTypeController.text.isEmpty) {
        CustomSnackbar.show(
          context,
          "Debe seleccionar un tipo de documento",
          'error',
        );
        return false;
      }
      if (jointHolderDocNumberController.text.isEmpty) {
        CustomSnackbar.show(
          context,
          "Debe ingresar el número de documento",
          'error',
        );
        return false;
      }
      if (jointHolderDocTypeController.text == 'DNI' && jointHolderDocNumberController.text.length != 8) {
        CustomSnackbar.show(context, "El DNI debe tener 8 dígitos", 'error');
        return false;
      } else {
        if (jointHolderDocTypeController.text == 'Carnet de Extranjería' &&
            jointHolderDocNumberController.text.length != 20) {
          CustomSnackbar.show(context, "El Carnet de Extranjería debe tener 20 dígitos", 'error');
          return false;
        }
      }
    }
    if (!isJointAccount) {
      if (!personalAccountDeclaration) {
        CustomSnackbar.show(
          context,
          "Debe declarar que es su cuenta personal",
          'error',
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
                      color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
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
                    items: const ['Ahorros', 'Corriente', 'Mancomunada'],
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
                        color: theme.isDarkMode ? const Color(secondaryGrayText) : const Color(primaryDark),
                      ),
                    ),
                    const Spacer(),
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
                              borderRadius: BorderRadius.all(Radius.circular(25)),
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
                              borderRadius: BorderRadius.all(Radius.circular(25)),
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
                        constraints: const BoxConstraints(minWidth: 154, maxWidth: 154),
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

                      CreateBankAccountInput input = CreateBankAccountInput(
                        bankUUID: BankEntity.getUuidByName(
                          bankController.text,
                          await bankFuture,
                        ),
                        typeAccount: mapTypeAccount(accountTypeController.text),
                        currency: widget.currency == currencyEnum.PEN ? 'SOLES' : 'DOLARES',
                        bankAccount: accountNumberController.text,
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
                      ref.read(createBankAccountProvider(input).future).then(
                        (response) {
                          if (response.success) {
                            ref.invalidate(bankAccountFutureProvider);
                            CustomSnackbar.show(
                              context,
                              "Cuenta guardada correctamente",
                              'success',
                            );
                            //wait 3 seconds
                            ref.read(boolCreatedNewBankAccountProvider.notifier).state = true;
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });
                          } else {
                            CustomSnackbar.show(
                              context,
                              "Hubo un error al guardar la cuenta, verifique los datos e intente nuevamente",
                              'error',
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
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
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
      ),
    );
  }
}
