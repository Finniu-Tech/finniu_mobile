import 'package:finniu/constants/number_format.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_personal_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_date_picker.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_about_me_v2/form_about_me_v2.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/selectable_dropdown_v2.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormPersonalDataV2 extends StatelessWidget {
  const FormPersonalDataV2({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const ScaffoldUserProfile(
        floatingActionButton: SizedBox(
          width: 0,
          height: 90,
        ),
        appBar: AppBarLogo(),
        children: [
          SizedBox(
            height: 10,
          ),
          ProgressForm(
            progress: 0.2,
          ),
          TitleForm(
            title: "Datos personales",
            subTitle: "¿Cuáles son tus datos personales?",
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
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, bool>?;

    final userProfile = ref.watch(userProfileNotifierProvider);
    final String? imagePath = ref.watch(imagePathProvider);
    final String? imageBase64 = ref.watch(imageBase64Provider);

    final firstNameController = useTextEditingController(text: userProfile.firstName ?? '');
    final lastNameFatherController = useTextEditingController(text: userProfile.lastNameFather ?? '');
    final lastNameMotherController = useTextEditingController(text: userProfile.lastNameMother ?? '');
    final documentTypeController = useTextEditingController(
      text: userProfile.documentType == null ? "" : getTypeDocumentByUser(userProfile.documentType!),
    );
    final documentNumberController = useTextEditingController(text: userProfile.documentNumber);
    final civilStatusController = useTextEditingController(
      text: userProfile.civilStatus == null ? "" : getCivilStatusByUser(userProfile.civilStatus!),
    );
    final genderTypeController = useTextEditingController(
      text: userProfile.gender == null ? "" : getGenderByUser(userProfile.gender!),
    );
    final dateController = useTextEditingController(
      text: userProfile.birthDate == null ? "" : formatDate(userProfile.birthDate!),
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
            "screen": FirebaseScreen.formPersonalDataV2,
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

        if (userProfile.imageProfileUrl == null || userProfile.imageProfileUrl == "") {
          if (imagePath == null) {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.formValidateError,
              parameters: {
                "screen": FirebaseScreen.formPersonalDataV2,
                "error": "input_image",
              },
            );
            showSnackBarV2(
              context: context,
              title: "Falta imagen de perfil",
              message: "Por favor, agrega una imagen de perfil.",
              snackType: SnackType.warning,
            );
            return;
          }
          if (imageBase64 == null) {
            showSnackBarV2(
              context: context,
              title: "Falta imagen de perfil",
              message: "Por favor, agrega una imagen de perfil.",
              snackType: SnackType.warning,
            );
            return;
          }
        }

        context.loaderOverlay.show();
        if (args != null && args.containsKey('birthday') && args['birthday'] == true) {
          FocusManager.instance.primaryFocus?.unfocus();
          DateTime parsedDate = DateFormat("d/M/yyyy").parse(dateController.text.trim());
          String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
          final DtoPersonalForm data = DtoPersonalForm(
            firstName: firstNameController.text.trim(),
            lastNameFather: lastNameFatherController.text.trim(),
            lastNameMother: lastNameMotherController.text.trim(),
            documentType: getTypeDocumentEnum(documentTypeController.text),
            documentNumber: documentNumberController.text.trim(),
            civilStatus: getCivilStatusEnum(civilStatusController.text) ?? CivilStatusEnum.SINGLE,
            imageProfile: imageBase64,
            gender: getGenderEnum(genderTypeController.text) ?? GenderEnum.OTHER,
            birthday: formattedDate,
          );

          context.loaderOverlay.show();
          pushPersonalDataForm(
            context,
            data,
            ref,
            isNavigate: false,
          );
        } else {
          final DtoPersonalForm data = DtoPersonalForm(
            firstName: firstNameController.text.trim(),
            lastNameFather: lastNameFatherController.text.trim(),
            lastNameMother: lastNameMotherController.text.trim(),
            documentType: getTypeDocumentEnum(documentTypeController.text),
            documentNumber: documentNumberController.text.trim(),
            civilStatus: getCivilStatusEnum(civilStatusController.text) ?? CivilStatusEnum.SINGLE,
            imageProfile: imageBase64,
            gender: getGenderEnum(genderTypeController.text) ?? GenderEnum.OTHER,
          );

          context.loaderOverlay.show();
          pushPersonalDataForm(
            context,
            data,
            ref,
            isNavigate: false,
          );
        }
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        child: Column(
          children: [
            imagePath == null ? const AddImageProfile() : const ImageProfileRender(),
            const SizedBox(height: 15),
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
                      typeDocument: getTypeDocumentEnum(documentTypeController.text),
                      value: value,
                      field: "Número de documento",
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
                        message: "Por favor,  selecciona el estado civil",
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
                  hintText: "Seleccione su género",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "El genero es obligatorio",
                        message: "Por favor, selecciona el genero",
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
            args != null && args.containsKey('birthday') && args['birthday'] == true
                ? ValueListenableBuilder<bool>(
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
                  )
                : const SizedBox(),
            const SizedBox(
              height: 15,
            ),
            // const Expanded(
            //   child: SizedBox(),
            // ),
            const ContainerMessage(),
            FormDataNavigator(
              addData: () => uploadPersonalData(),
              continueLater: null,
              continueLaterBool: false,
            ),
          ],
        ),
      ),
    );
  }
}
