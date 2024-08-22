// ignore_for_file: avoid_print
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_personal_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/list_select_dropdown.dart';
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

class FormPersonalDataV2 extends HookConsumerWidget {
  FormPersonalDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final lastNameFatherController = useTextEditingController();
    final lastNameMotherController = useTextEditingController();
    final documentTypeController = useTextEditingController();
    final documentNumberController = useTextEditingController();
    final civilStatusController = useTextEditingController();
    final genderTypeController = useTextEditingController();

    void uploadPersonalData() {
      if (formKey.currentState!.validate()) {
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

    void continueLater() {
      Navigator.pushNamed(context, "/home_v2");
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldUserProfile(
        bottomNavigationBar: FormDataNavigator(
          addData: () => uploadPersonalData(),
          continueLater: () => continueLater(),
        ),
        appBar: const AppBarLogo(),
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProgressForm(
            progress: 0.2,
          ),
          const TitleForm(
            title: "Datos personales",
            subTitle: "¿Cuales son tus datos personales?",
            icon: "assets/svg_icons/user_icon_v2.svg",
          ),
          PersonalForm(
            formKey: formKey,
            firstNameController: firstNameController,
            lastNameFatherController: lastNameFatherController,
            lastNameMotherController: lastNameMotherController,
            documentTypeController: documentTypeController,
            documentNumberController: documentNumberController,
            civilStatusController: civilStatusController,
            genderTypeController: genderTypeController,
          ),
          const ContainerMessage(),
        ],
      ),
    );
  }
}

class PersonalForm extends ConsumerWidget {
  const PersonalForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameFatherController,
    required this.lastNameMotherController,
    required this.documentTypeController,
    required this.documentNumberController,
    required this.civilStatusController,
    required this.genderTypeController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameFatherController;
  final TextEditingController lastNameMotherController;
  final TextEditingController documentTypeController;
  final TextEditingController documentNumberController;
  final TextEditingController civilStatusController;
  final TextEditingController genderTypeController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          InputTextFileUserProfile(
            controller: firstNameController,
            hintText: "Nombres completos",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            controller: lastNameFatherController,
            hintText: "Apellido Paterno",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu padre';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            controller: lastNameMotherController,
            hintText: "Apellido Materno",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu madre';
              }
              return null;
            },
          ),
          SelectableDropdownItem(
            itemSelectedValue: documentTypeController.text,
            options: documentType,
            selectController: documentTypeController,
            hintText: "Selecciona tu documento de identidad",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione tipo';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          InputTextFileUserProfile(
            isNumeric: true,
            controller: documentNumberController,
            hintText: "Ingrese su Nº de documento de identidad",
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Ingresa tu nómero de documento';
              }
              return null;
            },
          ),
          SelectableDropdownItem(
            itemSelectedValue: civilStatusController.text,
            options: maritalStatus,
            selectController: civilStatusController,
            hintText: "Seleccione su estado civil",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione tipo';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          SelectableDropdownItem(
            itemSelectedValue: genderTypeController.text,
            options: genderType,
            selectController: genderTypeController,
            hintText: "Seleccione su genero",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione tipo';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
