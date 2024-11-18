import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/form_accounts/helpers/create_bank_account_v2.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/banks_dropdown_provider.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/input_select_accounts.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/input_text_accounts.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormAccountsScreen extends StatelessWidget {
  const FormAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Agregar cuenta bancaria",
      children: FormAccountsBody(),
    );
  }
}

class FormAccountsBody extends StatelessWidget {
  const FormAccountsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: FormAccounts(),
      ),
    );
  }
}

class FormAccounts extends HookConsumerWidget {
  FormAccounts({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controllerExpanded = ExpansionTileController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    const int activeColor = 0xff0D3A5C;
    const int activeTrackColor = 0xffD4F5FF;
    const int inactiveThumbColor = 0xff828282;
    const int inactiveTrackColor = 0xffF3F3F3;

    final isJointAccount = useState(false);
    final personalAccountDeclaration = useState(false);
    final useForFutureOperations = useState(false);

    final bankController = useTextEditingController();
    final accountTypeController = useTextEditingController();
    final accountNumberController = useTextEditingController();
    final cciNumberController = useTextEditingController();
    final accountNameController = useTextEditingController();

    final jointHolderNameController = useTextEditingController();
    final jointHolderLastNameController = useTextEditingController();
    final jointHolderMothersLastNameController = useTextEditingController();
    final jointHolderDocTypeController = useTextEditingController();
    final jointHolderDocNumberController = useTextEditingController();

    final bankError = useState(false);
    final accountTypeError = useState(false);
    final accountNumberError = useState(false);
    final cciNumberError = useState(false);
    final accountNameError = useState(false);
    final jointHolderNameError = useState(false);
    final jointHolderLastNameError = useState(false);
    final jointHolderMothersLastNameError = useState(false);
    final jointHolderDocTypeError = useState(false);
    final jointHolderDocNumberError = useState(false);

    void onTap() {
      isJointAccount.value = !isJointAccount.value;

      if (isJointAccount.value) {
        controllerExpanded.expand();
      } else {
        controllerExpanded.collapse();
        jointHolderNameError.value = false;
        jointHolderLastNameError.value = false;
        jointHolderMothersLastNameError.value = false;
        jointHolderDocTypeError.value = false;
        jointHolderDocNumberError.value = false;

        jointHolderNameController.clear();
        jointHolderLastNameController.clear();
        jointHolderMothersLastNameController.clear();
        jointHolderDocTypeController.clear();
        jointHolderDocNumberController.clear();
      }
    }

    pushData() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (!formKey.currentState!.validate()) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.formValidateError,
          parameters: {
            "screen": FirebaseScreen.formAccountsV2,
            "error": "input_form",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (!personalAccountDeclaration.value && !isJointAccount.value) {
          showSnackBarV2(
            context: context,
            title: "Seleccione tipo de cuenta",
            message: "Por favor, seleccione cuenta personal o conjunta.",
            snackType: SnackType.warning,
          );
          return;
        }
        if (bankError.value) return;
        if (accountTypeError.value) return;
        if (accountNumberError.value) return;
        if (cciNumberError.value) return;
        if (accountNameError.value) return;
        if (jointHolderNameError.value) return;
        if (jointHolderLastNameError.value) return;
        if (jointHolderMothersLastNameError.value) return;
        if (jointHolderDocTypeError.value) return;
        if (jointHolderDocNumberError.value) return;

        final isSoles = ref.read(isSolesStateProvider);
        context.loaderOverlay.show();
        CreateBankAccountInput input = CreateBankAccountInput(
          bankUUID: bankController.text,
          typeAccount: accountTypeController.text.toUpperCase(),
          currency: isSoles ? 'SOLES' : 'DOLARES',
          bankAccount: accountNumberController.text,
          cci: cciNumberController.text,
          aliasBankAccount: accountNameController.text,
          isDefault: useForFutureOperations.value,
          isPersonalAccount: personalAccountDeclaration.value,
          jointAccount: isJointAccount.value
              ? JointAccountInput(
                  name: jointHolderNameController.text,
                  lastName: jointHolderLastNameController.text,
                  documentType: jointHolderDocTypeController.text,
                  documentNumber: jointHolderDocNumberController.text,
                )
              : null,
        );
        createBankAccountV2(
          context: context,
          input: input,
          ref: ref,
        );
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return BankDropdownAccounts(
                itemSelectedValue: bankController.text,
                isError: isError,
                onError: () => bankError.value = false,
                selectController: bankController,
                hintText: "Selecione su banco",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "Banco obligatorio",
                      message: "Por favor, completa seleccione su banco.",
                      snackType: SnackType.warning,
                    );
                    bankError.value = true;
                    return null;
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: accountTypeError,
            builder: (context, isError, child) {
              return SelectableDropdownAccounts(
                title: "  Tipo de cuenta  ",
                options: const ['Ahorros', 'Corriente'],
                itemSelectedValue: accountTypeController.text,
                isError: isError,
                onError: () => accountTypeError.value = false,
                selectController: accountTypeController,
                hintText: "Selecciona el tipo de cuenta",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "Tipo de cuenta obligatorio",
                      message: "Por favor, completa el tipo de cuenta.",
                      snackType: SnackType.warning,
                    );
                    accountTypeError.value = true;
                    return null;
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Número de cuenta",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textDark: 0xffA2E6FA,
            textLight: 0xff0D3A5C,
            align: TextAlign.start,
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: accountNumberError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => accountNumberError.value = false,
                controller: accountNumberController,
                hintText: "Escribe el número de cuenta",
                isNumeric: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "Número de cuenta obligatorio",
                      message:
                          "Por favor, completa ingresar el número de cuenta.",
                      snackType: SnackType.warning,
                    );
                    accountNumberError.value = true;
                    return null;
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Número de cuenta interbancaria (CCI)",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textDark: 0xffA2E6FA,
            textLight: 0xff0D3A5C,
            align: TextAlign.start,
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: cciNumberError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => cciNumberError.value = false,
                controller: cciNumberController,
                hintText: "Escribe el número de cuenta CCI",
                isNumeric: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "Número de cuenta CCI obligatorio",
                      message:
                          "Por favor, completa ingresar el número de cuenta CCI.",
                      snackType: SnackType.warning,
                    );
                    cciNumberError.value = true;
                    return null;
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              TextPoppins(
                text: "Nombre de la cuenta ",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: 0xffA2E6FA,
                textLight: 0xff0D3A5C,
                align: TextAlign.start,
              ),
              TextPoppins(
                text: "*Opcional",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textDark: 0xffA2E6FA,
                textLight: 0xff0D3A5C,
                align: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: accountNameError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => accountNameError.value = false,
                controller: accountNameController,
                hintText: "Escribe el nombre de cuenta",
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<bool>(
            valueListenable: isJointAccount,
            builder: (context, value, child) {
              return ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isJointAccount.value,
                trailing: Switch(
                  value: isJointAccount.value,
                  activeColor: const Color(activeColor),
                  inactiveThumbColor: const Color(inactiveThumbColor),
                  activeTrackColor: const Color(activeTrackColor),
                  inactiveTrackColor: const Color(inactiveTrackColor),
                  onChanged: (_) => {onTap()},
                ),
                controller: controllerExpanded,
                shape: const Border(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: TextPoppins(
                        text: '¿Es una cuenta mancomunada?',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.start,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg_icons/message_question_icon.svg',
                      width: 20,
                      height: 20,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                    ),
                    const SizedBox(width: 5),
                    TextPoppins(
                      text: value ? 'Si' : 'No',
                      fontSize: 11,
                      align: TextAlign.start,
                    ),
                  ],
                ),
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: jointHolderNameError,
                    builder: (context, isError, child) {
                      return InputTextFileAccounts(
                        isError: isError,
                        onError: () => jointHolderNameError.value = false,
                        controller: jointHolderNameController,
                        hintText: "Nombres de la otra persona titular",
                        validator: (value) {
                          if (isJointAccount.value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "Nombres obligatorio",
                                message:
                                    "Por favor, completa ingresar los nombres de la otra persona titular.",
                                snackType: SnackType.warning,
                              );
                              jointHolderNameError.value = true;
                              return null;
                            }
                          }

                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: jointHolderLastNameError,
                        builder: (context, isError, child) {
                          return Expanded(
                            child: InputTextFileAccounts(
                              isRow: true,
                              isError: isError,
                              onError: () =>
                                  jointHolderLastNameError.value = false,
                              controller: jointHolderLastNameController,
                              hintText: "Apellido paterno",
                              validator: (value) {
                                if (isJointAccount.value) {
                                  if (value == null || value.isEmpty) {
                                    showSnackBarV2(
                                      context: context,
                                      title: "Nombres Paterno obligatorio",
                                      message:
                                          "Por favor, completa ingresar los nombres de la otra persona titular.",
                                      snackType: SnackType.warning,
                                    );
                                    jointHolderLastNameError.value = true;
                                    return null;
                                  }
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: jointHolderMothersLastNameError,
                        builder: (context, isError, child) {
                          return Expanded(
                            child: InputTextFileAccounts(
                              isRow: true,
                              isError: isError,
                              onError: () =>
                                  jointHolderMothersLastNameError.value = false,
                              controller: jointHolderMothersLastNameController,
                              hintText: "Apellido materno",
                              validator: (value) {
                                if (isJointAccount.value) {
                                  if (value == null || value.isEmpty) {
                                    showSnackBarV2(
                                      context: context,
                                      title: "Nombres Materno obligatorio",
                                      message:
                                          "Por favor, completa ingresar los nombres de la otra persona titular.",
                                      snackType: SnackType.warning,
                                    );
                                    jointHolderMothersLastNameError.value =
                                        true;
                                    return null;
                                  }
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: jointHolderDocTypeError,
                        builder: (context, isError, child) {
                          return Expanded(
                            child: SelectableDropdownAccounts(
                              isRow: true,
                              title: "  Documento  ",
                              options: documentType,
                              itemSelectedValue:
                                  jointHolderDocTypeController.text,
                              isError: isError,
                              onError: () =>
                                  jointHolderDocTypeError.value = false,
                              selectController: jointHolderDocTypeController,
                              hintText: "Tipo",
                              validator: (value) {
                                if (isJointAccount.value) {
                                  if (value == null || value.isEmpty) {
                                    showSnackBarV2(
                                      context: context,
                                      title: "Tipo Documento obligatorio",
                                      message:
                                          "Por favor, seleccione tipo de documento.",
                                      snackType: SnackType.warning,
                                    );
                                    jointHolderDocTypeError.value = true;
                                    return null;
                                  }
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: jointHolderDocNumberError,
                        builder: (context, isError, child) {
                          return Expanded(
                            child: InputTextFileAccounts(
                              isRow: true,
                              isError: isError,
                              onError: () =>
                                  jointHolderDocNumberError.value = false,
                              controller: jointHolderDocNumberController,
                              hintText: "Nº de documento",
                              validator: (value) {
                                if (isJointAccount.value) {
                                  if (value == null || value.isEmpty) {
                                    showSnackBarV2(
                                      context: context,
                                      title: "Nº Documento obligatorio",
                                      message:
                                          "Por favor, ingresa el Nº de documento.",
                                      snackType: SnackType.warning,
                                    );
                                    jointHolderDocNumberError.value = true;
                                    return null;
                                  }
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
                onExpansionChanged: (expanded) {
                  if (isJointAccount.value) {
                    controllerExpanded.expand();
                  } else {
                    controllerExpanded.collapse();
                    jointHolderNameController.clear();
                    jointHolderLastNameController.clear();
                    jointHolderMothersLastNameController.clear();
                    jointHolderDocTypeController.clear();
                    jointHolderDocNumberController.clear();
                  }
                },
              );
            },
          ),
          Row(
            children: [
              CheckBoxWidget(
                value: useForFutureOperations.value,
                onChanged: (a) {
                  useForFutureOperations.value = !useForFutureOperations.value;
                },
              ),
              const TextPoppins(
                text: "Usar en mis futuras operaciones",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          isJointAccount.value
              ? const SizedBox()
              : Row(
                  children: [
                    CheckBoxWidget(
                      value: personalAccountDeclaration.value,
                      onChanged: (a) {
                        personalAccountDeclaration.value =
                            !personalAccountDeclaration.value;
                      },
                    ),
                    const TextPoppins(
                      text: "Declaro que es mi cuenta personal",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
          ButtonInvestment(text: "Guardar cuenta", onPressed: () => pushData()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
