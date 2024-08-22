import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/dropdown_select_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_location_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
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

class FormLocationDataV2 extends HookConsumerWidget {
  FormLocationDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressTextController = useTextEditingController();
    final houseNumberController = useTextEditingController();
    final postalCodeController = useTextEditingController();
    final countrySelectController = useTextEditingController(
      text: "Peru",
    );
    final regionsSelectController = useTextEditingController();
    final provinceSelectController = useTextEditingController();
    final districtSelectController = useTextEditingController();

    void uploadLocationData() {
      if (formKey.currentState!.validate()) {
        DtoLocationForm data = DtoLocationForm(
          country: countrySelectController.text,
          region: regionsSelectController.text,
          province: provinceSelectController.text,
          district: districtSelectController.text,
          address: addressTextController.text,
          houseNumber: houseNumberController.text,
          postalCode: postalCodeController.text,
        );
        context.loaderOverlay.show();
        pushLocationDataForm(context, data, ref);
      }
    }

    void continueLater() {
      Navigator.pushNamed(context, "/home_v2");
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
            houseNumberController: houseNumberController,
            postalCodeController: postalCodeController,
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

class LocationForm extends ConsumerStatefulWidget {
  const LocationForm({
    super.key,
    required this.formKey,
    required this.addressTextCompleteController,
    required this.houseNumberController,
    required this.postalCodeController,
    required this.countrySelectController,
    required this.regionsSelectController,
    required this.provinceSelectController,
    required this.districtSelectController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController addressTextCompleteController;
  final TextEditingController houseNumberController;
  final TextEditingController postalCodeController;
  final TextEditingController countrySelectController;
  final TextEditingController regionsSelectController;
  final TextEditingController provinceSelectController;
  final TextEditingController districtSelectController;

  @override
  LocationFormState createState() => LocationFormState();
}

class LocationFormState extends ConsumerState<LocationForm> {
  List<GeoLocationItemV2> districts = [
    GeoLocationItemV2(
      id: "Error de carga",
      name: "Error de carga",
    ),
  ];

  bool showRegionProvinceDistrict = true;

  @override
  void initState() {
    super.initState();

    // widget.countrySelectController.addListener(() {
    //   setState(() {
    //     showRegionProvinceDistrict =
    //         widget.countrySelectController.text == "Peru";
    //   });
    //   widget.regionsSelectController.clear();
    //   widget.provinceSelectController.clear();
    //   widget.districtSelectController.clear();
    // });

    widget.regionsSelectController.addListener(() {
      ref.invalidate(
        provincesSelectProvider(widget.regionsSelectController.text),
      );
      widget.provinceSelectController.clear();
      widget.districtSelectController.clear();
      setState(() {});
    });

    widget.provinceSelectController.addListener(() {
      ref.invalidate(
        districtsSelectProvider(widget.provinceSelectController.text),
      );
      widget.districtSelectController.clear();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: widget.formKey,
      child: Column(
        children: [
          SelectableDropdownItem(
            options: const ["Peru"],
            itemSelectedValue: widget.countrySelectController.text,
            selectController: widget.countrySelectController,
            hintText: "Selecciona el país de residencia",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor seleccione tipo';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          if (showRegionProvinceDistrict) ...[
            ProviderSelectableDropdownItem(
              regionsSelectProvider: regionsSelectProvider,
              itemSelectedValue: widget.regionsSelectController.text,
              selectController: widget.regionsSelectController,
              hintText: "Selecciona el departamento",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione tipo';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            widget.regionsSelectController.text.isEmpty
                ? SelectableGeoLocationDropdownItem(
                    itemSelectedValue: widget.provinceSelectController.text,
                    options: const [],
                    selectController: widget.provinceSelectController,
                    hintText: "Debe seleccionar un departamento",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione tipo';
                      }
                      return null;
                    },
                  )
                : ProviderSelectableDropdownItem(
                    regionsSelectProvider: provincesSelectProvider(
                      widget.regionsSelectController.text,
                    ),
                    itemSelectedValue: widget.provinceSelectController.text,
                    selectController: widget.provinceSelectController,
                    hintText: "Selecciona la provincia",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione tipo';
                      }
                      return null;
                    },
                  ),
            const SizedBox(
              height: 15,
            ),
            widget.provinceSelectController.text.isEmpty
                ? SelectableGeoLocationDropdownItem(
                    itemSelectedValue: widget.districtSelectController.text,
                    options: const [],
                    selectController: widget.districtSelectController,
                    hintText: "Debe seleccionar una provincia",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione tipo';
                      }
                      return null;
                    },
                  )
                : ProviderSelectableDropdownItem(
                    regionsSelectProvider: districtsSelectProvider(
                      widget.provinceSelectController.text,
                    ),
                    itemSelectedValue: widget.districtSelectController.text,
                    selectController: widget.districtSelectController,
                    hintText: "Selecciona el distrito",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione tipo';
                      }
                      return null;
                    },
                  ),
            const SizedBox(
              height: 15,
            ),
          ] else ...[
            InputTextFileUserProfile(
              controller: widget.regionsSelectController,
              hintText: "Escribe tu departamento",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu departamento';
                }
                return null;
              },
            ),
            InputTextFileUserProfile(
              controller: widget.provinceSelectController,
              hintText: "Escribe tu provincia",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu provincia';
                }
                return null;
              },
            ),
            InputTextFileUserProfile(
              controller: widget.districtSelectController,
              hintText: "Escribe tu distrito",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu distrito';
                }
                return null;
              },
            ),
          ],
          InputTextFileUserProfile(
            controller: widget.addressTextCompleteController,
            hintText: "Escribe tu dirección de domicilio",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu domicilio';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            isNumeric: true,
            controller: widget.houseNumberController,
            hintText: "Número de tu domicilio",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu número de domicilio';
              }
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Solo puedes usar números';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            isNumeric: true,
            controller: widget.postalCodeController,
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
