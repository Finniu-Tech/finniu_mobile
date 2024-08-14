// ignore_for_file: avoid_print
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/selectable_dropdown_v2.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormPersonalDataV2 extends HookConsumerWidget {
  FormPersonalDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namesCompleteController = useTextEditingController();
    final namesFaderController = useTextEditingController();
    final namesMotherController = useTextEditingController();
    final documentTypeController = useTextEditingController();
    final documentNumberController = useTextEditingController();
    final maritalStatusController = useTextEditingController();
    final phoneController = useTextEditingController();

    void uploadPersonalData() {
      if (formKey.currentState!.validate()) {
        print("add personal data");
        print(namesCompleteController.text);
        print(namesFaderController.text);
        print(namesMotherController.text);
        print(documentTypeController.text);
        print(documentNumberController.text);
        print(maritalStatusController.text);
        print(phoneController.text);
      }
    }

    void continueLater() {
      print("continue later");

      Navigator.pop(context);
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
            namesCompleteController: namesCompleteController,
            namesFaderController: namesFaderController,
            namesMotherController: namesMotherController,
            documentTypeController: documentTypeController,
            documentNumberController: documentNumberController,
            maritalStatusController: maritalStatusController,
            phoneController: phoneController,
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
    required this.namesCompleteController,
    required this.namesFaderController,
    required this.namesMotherController,
    required this.documentTypeController,
    required this.documentNumberController,
    required this.maritalStatusController,
    required this.phoneController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController namesCompleteController;
  final TextEditingController namesFaderController;
  final TextEditingController namesMotherController;
  final TextEditingController documentTypeController;
  final TextEditingController documentNumberController;
  final TextEditingController maritalStatusController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> maritalStatus = [
      'Soltero',
      'Casado',
      'Divorciadoa',
    ];
    final List<String> documentType = [
      'DNI',
      'Carné de extranjeria',
      'DNI1',
      'Carné de extranjeria1',
      'DNI2',
      'Carné de extranjeria2',
      'DNI3',
      'Carné de extranjeria3',
      'DNI4',
      'Carné de extranjeria4',
      'DNI5',
      'Carné de extranjeria5',
      'DNI6',
      'Carné de extranjeria6',
      'DNI7',
      'Carné de extranjeria7',
      'DNI8',
      'Carné de extranjeria8',
      'DNI9',
      'Carné de extranjeria9',
      'DNI10',
      'Carné de extranjeria10',
    ];
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          InputTextFileUserProfile(
            controller: namesCompleteController,
            hintText: "Nombres completos",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            controller: namesFaderController,
            hintText: "Apellido Paterno",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu padre';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            controller: namesMotherController,
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
            itemSelectedValue: maritalStatusController.text,
            options: maritalStatus,
            selectController: maritalStatusController,
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
          InputTextFileUserProfile(
            controller: phoneController,
            hintText: "Número telefónico",
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Ingresa tu nómero de telefono';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
