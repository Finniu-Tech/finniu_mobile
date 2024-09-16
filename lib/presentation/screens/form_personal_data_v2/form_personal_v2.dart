import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_personal_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldUserProfile(
        floatingActionButton: Container(
          width: 0,
          height: 90,
          color: Colors.transparent,
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

    void continueLater() {
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.pushNamed(context, "/home_v2");
    }

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

        context.loaderOverlay.show();
        final DtoPersonalForm data = DtoPersonalForm(
          firstName: firstNameController.text.trim(),
          lastNameFather: lastNameFatherController.text.trim(),
          lastNameMother: lastNameMotherController.text.trim(),
          documentType: getTypeDocumentEnum(documentTypeController.text),
          documentNumber: documentNumberController.text.trim(),
          civilStatus: getCivilStatusEnum(civilStatusController.text) ??
              CivilStatusEnum.SINGLE,
          gender: getGenderEnum(genderTypeController.text) ?? GenderEnum.OTHER,
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height < 700
            ? 600
            : MediaQuery.of(context).size.height * 0.77,
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
                  isNumeric: true,
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
                  hintText: "Selecciona estado civil",
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
            const ContainerMessage(),
            const Expanded(
              child: SizedBox(),
            ),
            FormDataNavigator(
              addData: () => uploadPersonalData(),
              continueLater: () => continueLater(),
            ),
          ],
        ),
      ),
    );
  }
}
