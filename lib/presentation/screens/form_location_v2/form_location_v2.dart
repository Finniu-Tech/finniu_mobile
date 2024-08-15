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

class FormLocationDataV2 extends HookConsumerWidget {
  FormLocationDataV2({super.key});
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
            progress: 0.4,
          ),
          const TitleForm(
            title: "Ubicación",
            subTitle: "¿Donde te encuentras?",
            icon: "assets/svg_icons/map_icon_v2.svg",
          ),
          LocationForm(
            formKey: formKey,
            addressTextCompleteController: namesCompleteController,
            addressNumberController: namesFaderController,
            zipCodeController: namesMotherController,
            countrySelectController: documentTypeController,
            departmentSelectController: documentNumberController,
            provinceSelectController: maritalStatusController,
            districtSelectController: phoneController,
          ),
          const ContainerMessage(),
        ],
      ),
    );
  }
}

class LocationForm extends ConsumerWidget {
  const LocationForm({
    super.key,
    required this.formKey,
    required this.addressTextCompleteController,
    required this.addressNumberController,
    required this.zipCodeController,
    required this.countrySelectController,
    required this.departmentSelectController,
    required this.provinceSelectController,
    required this.districtSelectController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController addressTextCompleteController;
  final TextEditingController addressNumberController;
  final TextEditingController zipCodeController;
  final TextEditingController countrySelectController;
  final TextEditingController departmentSelectController;
  final TextEditingController provinceSelectController;
  final TextEditingController districtSelectController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> countrys = [
      'Peru',
      'Chile',
      'Bolivia',
      'Colombia',
      'Venezuela',
      'Ecuador',
      'Brasil',
      'Paraguay',
      'Uruguay',
      'Bolivia',
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
          SelectableDropdownItem(
            itemSelectedValue: countrySelectController.text,
            options: countrys,
            selectController: countrySelectController,
            hintText: "Selecciona el país de residencia",
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
            itemSelectedValue: countrySelectController.text,
            options: documentType,
            selectController: countrySelectController,
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
          SelectableDropdownItem(
            itemSelectedValue: countrySelectController.text,
            options: documentType,
            selectController: countrySelectController,
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
          SelectableDropdownItem(
            itemSelectedValue: countrySelectController.text,
            options: documentType,
            selectController: countrySelectController,
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
            controller: addressTextCompleteController,
            hintText: "Escribe tu dirección de domicilio",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu domicilioo';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            isNumeric: true,
            controller: addressNumberController,
            hintText: "Número de tu domicilio",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu nómero de domicilio';
              }
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Solo puedes usar números';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            isNumeric: true,
            controller: zipCodeController,
            hintText: "Código postal (opcional)",
            validator: (value) {
              return null;
            },
          ),
        ],
      ),
    );
  }
}
