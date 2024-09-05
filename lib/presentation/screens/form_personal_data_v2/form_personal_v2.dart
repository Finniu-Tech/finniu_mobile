// ignore_for_file: avoid_print
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_personal_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/list_select_dropdown.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/selectable_dropdown_v2.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormPersonalDataV2 extends ConsumerWidget {
  const FormPersonalDataV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadPersonalData() {}
    void continueLater() {
      Navigator.pushNamed(context, "/home_v2");
    }

    return GestureDetector(
      child: ScaffoldUserProfile(
        bottomNavigationBar: FormDataNavigator(
          addData: () => uploadPersonalData(),
          continueLater: () => continueLater(),
        ),
        appBar: const AppBarLogo(),
        children: const [
          SizedBox(
            height: 10,
          ),
          ProgressForm(
            progress: 0.2,
          ),
          TitleForm(
            title: "Datos personales",
            subTitle: "¿Cuales son tus datos personales?",
            icon: "assets/svg_icons/user_icon_v2.svg",
          ),
          PersonalForm(),
          ContainerMessage(),
        ],
      ),
    );
  }
}

class PersonalForm extends HookConsumerWidget {
  const PersonalForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final firstNameController = useTextEditingController();
    final lastNameFatherController = useTextEditingController();
    final lastNameMotherController = useTextEditingController();
    final documentTypeController = useTextEditingController();
    final documentNumberController = useTextEditingController();
    final civilStatusController = useTextEditingController();
    final genderTypeController = useTextEditingController();

    final ValueNotifier<bool> firstNameError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> lastNameFatherError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> lastNameMotherError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> documentTypeError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> documentNumberError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> civilStatusError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> genderTypeError = ValueNotifier<bool>(false);

    void uploadPersonalData() {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (firstNameError.value) return;
        if (lastNameFatherError.value) return;
        if (lastNameMotherError.value) return;
        if (documentTypeError.value) return;
        if (documentNumberError.value) return;
        if (civilStatusError.value) return;
        if (genderTypeError.value) return;
        print("upload personal data");
        print(firstNameController.text);
        print(lastNameFatherController.text);
        print(lastNameMotherController.text);
        print(documentTypeController.text);
        print(documentNumberController.text);
        print(civilStatusController.text);
        print(genderTypeController.text);
        context.loaderOverlay.show();
        final DtoPersonalForm data = DtoPersonalForm(
          firstName: firstNameController.text.trim(),
          lastNameFather: lastNameFatherController.text.trim(),
          lastNameMother: lastNameMotherController.text.trim(),
          documentType: getTypeDocumentEnum(documentTypeController.text) ??
              TypeDocumentEnum.DNI,
          documentNumber: documentNumberController.text.trim(),
          civilStatus: getCivilStatusEnum(civilStatusController.text) ??
              CivilStatusEnum.SINGLE,
          gender: genderTypeController.text,
        );
        context.loaderOverlay.show();
        pushPersonalDataForm(
          context,
          data,
          ref,
        );
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: firstNameError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                isError: isError,
                onError: () => firstNameError.value = false,
                controller: firstNameController,
                hintText: "Nombres completos",
                validator: (value) {
                  validateString(
                    value: value,
                    field: "Nombre",
                    context: context,
                    boolNotifier: firstNameError,
                  );
                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: lastNameFatherError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                isError: isError,
                onError: () => lastNameFatherError.value = false,
                controller: lastNameFatherController,
                hintText: "Apellido Paterno",
                validator: (value) {
                  validateString(
                    value: value,
                    field: "Apellido Paterno",
                    context: context,
                    boolNotifier: lastNameFatherError,
                  );
                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: lastNameMotherError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                isError: isError,
                onError: () => lastNameMotherError.value = false,
                controller: lastNameMotherController,
                hintText: "Apellido Materno",
                validator: (value) {
                  validateString(
                    value: value,
                    field: "Apellido Materno",
                    context: context,
                    boolNotifier: lastNameMotherError,
                  );
                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: documentTypeError,
            builder: (context, isError, child) {
              return SelectableDropdownItem(
                isError: isError,
                onError: () => documentTypeError.value = false,
                itemSelectedValue: documentTypeController.text,
                options: documentType,
                selectController: documentTypeController,
                hintText: "Selecciona tu documento de identidad",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "El tipo de documento es obligatorio",
                      message:
                          "Por favor, completa el seleciona el tipo de documento.",
                      snackType: SnackType.warning,
                    );
                    documentTypeError.value = true;
                    return null;
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: documentNumberError,
            builder: (context, isError, child) {
              return InputTextFileUserProfile(
                isError: isError,
                onError: () => documentNumberError.value = false,
                controller: documentNumberController,
                hintText: "Ingrese su Nº de documento de identidad",
                validator: (value) {
                  validateNumberDocument(
                    typeDocument:
                        getTypeDocumentEnum(documentTypeController.text),
                    value: value,
                    field: "Numero de documento",
                    context: context,
                    boolNotifier: documentNumberError,
                  );
                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: civilStatusError,
            builder: (context, isError, child) {
              return SelectableDropdownItem(
                isError: isError,
                onError: () => civilStatusError.value = false,
                itemSelectedValue: civilStatusController.text,
                options: maritalStatus,
                selectController: civilStatusController,
                hintText: "Selecciona tu documento de identidad",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "El estado civil es obligatorio",
                      message:
                          "Por favor, completa el seleciona el estado civil",
                      snackType: SnackType.warning,
                    );
                    civilStatusError.value = true;
                    return null;
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: genderTypeError,
            builder: (context, isError, child) {
              return SelectableDropdownItem(
                isError: isError,
                onError: () => genderTypeError.value = false,
                itemSelectedValue: genderTypeController.text,
                options: genderType,
                selectController: genderTypeController,
                hintText: "Seleccione su genero",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    showSnackBarV2(
                      context: context,
                      title: "El genero es obligatorio",
                      message: "Por favor, completa el seleciona el genero",
                      snackType: SnackType.warning,
                    );
                    genderTypeError.value = true;
                    return null;
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ButtonInvestment(
            text: "siguiente",
            onPressed: () => uploadPersonalData(),
          ),
        ],
      ),
    );
  }
}

String? validateString({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 2) {
    showSnackBarV2(
      context: context,
      title: "${field.toLowerCase()} obligatorio",
      message: "El ${field.toLowerCase()} debe tener al menos 1 caracter.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "${field.toLowerCase()} inválido",
      message:
          "El ${field.toLowerCase()} no debe contener números ni caracteres especiales.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}

String? validateNumber({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "${field.toLowerCase()} incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  boolNotifier.value = true;
  return null;
}

String? validateNumberDocument({
  required TypeDocumentEnum? typeDocument,
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (typeDocument == null) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Por favor seleccione tipo de documento',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.DNI && value.length != 8) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El DNI debe tener 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.CARNET_EXTRAJERIA && value.length < 8) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El Carnet de Extrajería debe tener 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.CARNET_EXTRAJERIA && value.length > 20) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El Carnet de Extrajería 20 debe tener mas de 20 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  return null;
}
