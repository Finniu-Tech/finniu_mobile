import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/presentation/providers/dropdown_select_provider.dart';
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

class FormLocationDataV2 extends HookConsumerWidget {
  FormLocationDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressTextController = useTextEditingController();
    final addressNumberController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final countrySelectController = useTextEditingController();
    final regionsSelectController = useTextEditingController();
    final provinceSelectController = useTextEditingController();
    final districtSelectController = useTextEditingController();

    void uploadLocationData() {
      if (formKey.currentState!.validate()) {
        print("add personal data");
        print(countrySelectController.text);
        print(regionsSelectController.text);
        print(provinceSelectController.text);
        print(districtSelectController.text);
        print(addressTextController.text);
        print(addressNumberController.text);
        print(zipCodeController.text);
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
          addData: () => uploadLocationData(),
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
            addressTextCompleteController: addressTextController,
            addressNumberController: addressNumberController,
            zipCodeController: zipCodeController,
            countrySelectController: countrySelectController,
            regionsSelectController: regionsSelectController,
            provinceSelectController: provinceSelectController,
            districtSelectController: districtSelectController,
          ),
          const ContainerMessage(),
        ],
      ),
    );
  }
}

class LocationForm extends HookConsumerWidget {
  const LocationForm({
    super.key,
    required this.formKey,
    required this.addressTextCompleteController,
    required this.addressNumberController,
    required this.zipCodeController,
    required this.countrySelectController,
    required this.regionsSelectController,
    required this.provinceSelectController,
    required this.districtSelectController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController addressTextCompleteController;
  final TextEditingController addressNumberController;
  final TextEditingController zipCodeController;
  final TextEditingController countrySelectController;
  final TextEditingController regionsSelectController;
  final TextEditingController provinceSelectController;
  final TextEditingController districtSelectController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<GeoLocationItemV2> regions = [];
    List<GeoLocationItemV2> provinces = [
      GeoLocationItemV2(
        id: "Error de carga",
        name: "Error de carga",
      ),
    ];
    List<GeoLocationItemV2> districts = [
      GeoLocationItemV2(
        id: "Error de carga",
        name: "Error de carga",
      ),
    ];
    final geoLocationResponse = ref.watch(regionsSelectProvider);
    geoLocationResponse.when(
      data: (data) {
        regions = data.regions;
      },
      loading: () {},
      error: (error, stack) {
        regions = [
          GeoLocationItemV2(
            id: "Error de carga",
            name: "Error de carga",
          ),
        ];
      },
    );

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
          SelectableGeoLocationDropdownItem(
            itemSelectedValue: regionsSelectController.text,
            options: regions,
            selectController: regionsSelectController,
            hintText: "Selecciona el departamento",
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
          SelectableGeoLocationDropdownItem(
            itemSelectedValue: provinceSelectController.text,
            options: provinces,
            selectController: provinceSelectController,
            hintText: "Selecciona la provincia",
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
          SelectableGeoLocationDropdownItem(
            itemSelectedValue: districtSelectController.text,
            options: districts,
            selectController: districtSelectController,
            hintText: "Selecciona el distrito ",
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
