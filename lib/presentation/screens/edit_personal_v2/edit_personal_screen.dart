import 'package:finniu/constants/number_format.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_personal_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_date_picker.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/selectable_dropdown_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/widgets/image_edit_stack.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditPersonalDataScreen extends StatelessWidget {
  const EditPersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Datos personales",
      children: _BodyEditPersonal(),
    );
  }
}

class _BodyEditPersonal extends HookConsumerWidget {
  const _BodyEditPersonal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final ValueNotifier<bool> isEdit = useState(false);
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: isEdit,
          builder: (context, isEditValue, child) {
            return isEditValue
                ? const PickImageEditStack()
                : ImageEditStack(
                    profileImage: "${userProfile.imageProfileUrl}",
                  );
          },
        ),
        const TextPoppins(
          text: "Información de mis datos personales",
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<bool>(
          valueListenable: isEdit,
          builder: (context, isEditValue, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    isEditValue
                        ? const SizedBox()
                        : EditWidget(
                            onTap: () => isEdit.value = true,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isEdit,
          builder: (context, isEditValue, child) {
            return Stack(
              children: [
                EditPersonalForm(
                  isEdit: isEdit,
                  onEdit: () => isEdit.value = false,
                ),
                isEditValue
                    ? const SizedBox()
                    : Positioned.fill(
                        child: IgnorePointer(
                          ignoring: false,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class EditPersonalForm extends HookConsumerWidget {
  EditPersonalForm({
    super.key,
    required this.isEdit,
    required this.onEdit,
  });
  final VoidCallback onEdit;
  final ValueNotifier<bool> isEdit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(userProfileNotifierProvider);
    final String? imageBase64 = ref.watch(imageBase64Provider);

    final firstNameController =
        useTextEditingController(text: userProfile.firstName ?? '');
    final lastNameFatherController =
        useTextEditingController(text: userProfile.lastNameFather ?? '');
    final lastNameMotherController =
        useTextEditingController(text: userProfile.lastNameMother ?? '');
    final documentTypeController = useTextEditingController(
      text: userProfile.documentType == null
          ? ""
          : getTypeDocumentByUser(userProfile.documentType!),
    );
    final documentNumberController =
        useTextEditingController(text: userProfile.documentNumber);
    final civilStatusController = useTextEditingController(
      text: userProfile.civilStatus == null
          ? ""
          : getCivilStatusByUser(userProfile.civilStatus!),
    );
    final genderTypeController = useTextEditingController(
      text: userProfile.gender == null
          ? ""
          : getGenderByUser(userProfile.gender!),
    );
    final dateController = useTextEditingController(
      text: userProfile.birthDate == null
          ? ""
          : formatDate(userProfile.birthDate!),
    );

    final ValueNotifier<bool> firstNameError = useState(false);
    final ValueNotifier<bool> lastNameFatherError = useState(false);
    final ValueNotifier<bool> lastNameMotherError = useState(false);
    final ValueNotifier<bool> documentTypeError = useState(false);
    final ValueNotifier<bool> documentNumberError = useState(false);
    final ValueNotifier<bool> civilStatusError = useState(false);
    final ValueNotifier<bool> genderTypeError = useState(false);
    final ValueNotifier<bool> birthDateError = useState(false);

    void uploadPersonalData() {
      if (!formKey.currentState!.validate()) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.formValidateError,
          parameters: {
            "screen": FirebaseScreen.editPersonalDataV2,
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
        if (firstNameError.value) return;
        if (lastNameFatherError.value) return;
        if (lastNameMotherError.value) return;
        if (documentTypeError.value) return;
        if (documentNumberError.value) return;
        if (civilStatusError.value) return;
        if (genderTypeError.value) return;
        if (birthDateError.value) return;

        context.loaderOverlay.show();
        DateTime parsedDate =
            DateFormat("d/M/yyyy").parse(dateController.text.trim());
        String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
        final DtoPersonalForm data = DtoPersonalForm(
          firstName: firstNameController.text.trim(),
          lastNameFather: lastNameFatherController.text.trim(),
          lastNameMother: lastNameMotherController.text.trim(),
          documentType: getTypeDocumentEnum(documentTypeController.text),
          documentNumber: documentNumberController.text.trim(),
          civilStatus: getCivilStatusEnum(civilStatusController.text) ??
              CivilStatusEnum.SINGLE,
          imageProfile: imageBase64,
          gender: getGenderEnum(genderTypeController.text) ?? GenderEnum.OTHER,
          birthday: formattedDate,
        );

        context.loaderOverlay.show();
        pushPersonalDataForm(
          context,
          data,
          ref,
          navigate: '/v4/home',
          isEdit: true,
          isNavigate: true,
        );

        onEdit();
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        // height: MediaQuery.of(context).size.height < 700
        //     ? 630
        //     : MediaQuery.of(context).size.height - 250,
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                        message: "Por favor, completa el tipo de documento.",
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
                        message: "Por favor, completa el estado civil",
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
                        title: "El género es obligatorio",
                        message: "Por favor, completa el género",
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
            ValueListenableBuilder<bool>(
              valueListenable: birthDateError,
              builder: (context, isError, child) {
                return InputDatePickerUserProfile(
                  isError: isError,
                  onError: () => birthDateError.value = false,
                  hintText: "Fecha de nacimiento",
                  controller: dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Fecha de nacimiento incorrecta",
                        message: "Por favor, completa la fecha.",
                        snackType: SnackType.warning,
                      );
                      birthDateError.value = true;
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
            // const Expanded(
            //   child: SizedBox(),
            // ),
            ValueListenableBuilder<bool>(
              valueListenable: isEdit,
              builder: (context, isEditValue, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      isEditValue
                          ? ButtonInvestment(
                              text: "Guardar datos",
                              onPressed: uploadPersonalData,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class EditWidget extends StatelessWidget {
  const EditWidget({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  final int colorContainer = 0xffCFF4FF;
  final int colorText = 0xff000000;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(colorContainer),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        width: 118,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextPoppins(
              text: "Editar datos",
              fontSize: 12,
              textDark: colorText,
              textLight: colorText,
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(
              "assets/svg_icons/edit_icon.svg",
              height: 16,
              width: 16,
              color: Color(colorText),
            ),
          ],
        ),
      ),
    );
  }
}
