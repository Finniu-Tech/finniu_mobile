import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/dropdown_select_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_location_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/selectable_dropdown_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/edit_personal_screen.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/widgets/image_edit_stack.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditLocationDataScreen extends StatelessWidget {
  const EditLocationDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Datos personales",
      children: _BodyEditLocation(),
    );
  }
}

class _BodyEditLocation extends ConsumerWidget {
  const _BodyEditLocation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isEdit = ValueNotifier<bool>(false);
    const int backgroundImage = 0xffC1F1FF;
    return Column(
      children: [
        const IconEditStack(
          svgUrl: "assets/svg_icons/map_icon_v2.svg",
          backgroundImage: backgroundImage,
        ),
        const TextPoppins(
          text: "Información de mi ubicación",
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
                EditLocationForm(
                  isEdit: isEdit,
                  onEdit: () => isEdit.value = !isEdit.value,
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

class EditLocationForm extends ConsumerStatefulWidget {
  EditLocationForm({
    super.key,
    required this.isEdit,
    required this.onEdit,
  });
  final ValueNotifier<bool> isEdit;
  final VoidCallback onEdit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  LocationFormState createState() => LocationFormState();
}

class LocationFormState extends ConsumerState<EditLocationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final countrySelectController = TextEditingController();
  final regionsSelectController = TextEditingController();
  final provinceSelectController = TextEditingController();
  final districtSelectController = TextEditingController();
  final addressTextController = TextEditingController();
  // final houseNumberController = TextEditingController();
  final extRegionController = TextEditingController();
  final extProvinceController = TextEditingController();
  final extDistrictController = TextEditingController();

  final ValueNotifier<bool> regionsError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> provinceError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> districtError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> addressError = ValueNotifier<bool>(false);
  // final ValueNotifier<bool> houseNumberError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> extRegionError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> extProvinceError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> extDistrictError = ValueNotifier<bool>(false);

  void uploadLocationData() {
    if (!formKey.currentState!.validate()) {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.formValidateError,
        parameters: {
          "screen": FirebaseScreen.editLocationDataV2,
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
    }
    print('isPeru ${countrySelectController.text == "Peru"}');
    final isPeru = countrySelectController.text == "Peru";

    if (isPeru) {
      if (regionsError.value || provinceError.value || districtError.value || addressError.value) return;
    } else {
      if (extRegionError.value || extProvinceError.value || extDistrictError.value || addressError.value) return;
    }

    DtoLocationForm data = DtoLocationForm(
      country: countrySelectController.text,
      region: isPeru ? regionsSelectController.text : '',
      province: isPeru ? provinceSelectController.text : '',
      district: isPeru ? districtSelectController.text : '',
      address: addressTextController.text.trim(),
      extRegion: !isPeru ? extRegionController.text : '',
      extProvince: !isPeru ? extProvinceController.text : '',
      extDistrict: !isPeru ? extDistrictController.text : '',
    );

    context.loaderOverlay.show();
    pushLocationDataForm(
      context,
      data,
      ref,
      navigate: '/v4/home',
      isNavigate: true,
    );
    widget.onEdit();
  }

  void continueLater() {
    Navigator.pushNamed(context, "/form_legal_terms");
  }

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
    final userProfile = ref.read(userProfileNotifierProvider);
    print('user profile country!!!!!${userProfile.country}');
    countrySelectController.text = userProfile.country ?? "";
    regionsSelectController.text = userProfile.region ?? "";
    provinceSelectController.text = userProfile.provincia ?? "";
    districtSelectController.text = userProfile.distrito ?? "";
    addressTextController.text = userProfile.address ?? "";
    extRegionController.text = userProfile.extRegion ?? "";
    extProvinceController.text = userProfile.extProvince ?? "";
    extDistrictController.text = userProfile.extDistrict ?? "";
    // houseNumberController.text = userProfile.houseNumber ?? "";
    showRegionProvinceDistrict = countrySelectController.text == "Peru";

    regionsSelectController.addListener(() {
      ref.invalidate(
        provincesSelectProvider(regionsSelectController.text),
      );
      provinceSelectController.clear();
      districtSelectController.clear();
      setState(() {});
    });

    provinceSelectController.addListener(() {
      ref.invalidate(
        districtsSelectProvider(provinceSelectController.text),
      );
      districtSelectController.clear();
      setState(() {});
    });

    countrySelectController.addListener(() {
      setState(() {
        showRegionProvinceDistrict = countrySelectController.text == "Perú";
        if (countrySelectController.text != "Perú") {
          regionsSelectController.clear();
          provinceSelectController.clear();
          districtSelectController.clear();
        }
      });
    });
  }

  @override
  void dispose() {
    countrySelectController.dispose();
    regionsSelectController.dispose();
    provinceSelectController.dispose();
    districtSelectController.dispose();
    addressTextController.dispose();
    // houseNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height < 700 ? 490 : MediaQuery.of(context).size.height * 0.70,
        child: Column(
          children: [
            const LocationMessage(),
            const SizedBox(
              height: 15,
            ),
            GetFunctionSelectableDropdownItem(
              selectController: countrySelectController,
              hintText: 'Selecciona el país de residencia',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione país';
                }
                return null;
              },
              itemSelectedValue: countrySelectController.text,
            ),
            const SizedBox(
              height: 15,
            ),
            if (showRegionProvinceDistrict) ...[
              ValueListenableBuilder<bool>(
                valueListenable: regionsError,
                builder: (context, isError, child) {
                  return ProviderSelectableDropdownItem(
                    onError: () => regionsError.value = false,
                    isError: isError,
                    regionsSelectProvider: regionsSelectProvider,
                    itemSelectedValue: regionsSelectController.text,
                    selectController: regionsSelectController,
                    hintText: "Selecciona el departamento",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        showSnackBarV2(
                          context: context,
                          title: "El departamento es obligatorio",
                          message: "Por favor, completa el seleciona el departamento.",
                          snackType: SnackType.warning,
                        );
                        regionsError.value = true;
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
              regionsSelectController.text.isEmpty
                  ? ValueListenableBuilder<bool>(
                      valueListenable: regionsError,
                      builder: (context, isError, child) {
                        return SelectableGeoLocationDropdownItem(
                          onError: () => regionsError.value = false,
                          isError: isError,
                          itemSelectedValue: provinceSelectController.text,
                          options: const [],
                          selectController: provinceSelectController,
                          hintText: "Debe seleccionar un provincia",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "El provincia es obligatorio",
                                message: "Por favor, completa el seleciona el provincia.",
                                snackType: SnackType.warning,
                              );
                              provinceError.value = true;
                              return null;
                            }

                            return null;
                          },
                        );
                      },
                    )
                  : ValueListenableBuilder<bool>(
                      valueListenable: provinceError,
                      builder: (context, isError, child) {
                        return ProviderSelectableDropdownItem(
                          onError: () => provinceError.value = false,
                          isError: isError,
                          regionsSelectProvider: provincesSelectProvider(
                            regionsSelectController.text,
                          ),
                          itemSelectedValue: provinceSelectController.text,
                          selectController: provinceSelectController,
                          hintText: "Selecciona la provincia",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "El departamento es obligatorio",
                                message: "Por favor, completa el seleciona el departamento.",
                                snackType: SnackType.warning,
                              );
                              provinceError.value = true;
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
              provinceSelectController.text.isEmpty
                  ? ValueListenableBuilder<bool>(
                      valueListenable: districtError,
                      builder: (context, isError, child) {
                        return SelectableGeoLocationDropdownItem(
                          onError: () => districtError.value = false,
                          isError: isError,
                          itemSelectedValue: districtSelectController.text,
                          options: const [],
                          selectController: districtSelectController,
                          hintText: "Debe seleccionar una provincia",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "El provincia es obligatorio",
                                message: "Por favor, completa el seleciona el provincia.",
                                snackType: SnackType.warning,
                              );
                              districtError.value = true;
                              return null;
                            }

                            return null;
                          },
                        );
                      },
                    )
                  : ValueListenableBuilder<bool>(
                      valueListenable: districtError,
                      builder: (context, isError, child) {
                        return ProviderSelectableDropdownItem(
                          onError: () => districtError.value = false,
                          isError: isError,
                          regionsSelectProvider: districtsSelectProvider(
                            provinceSelectController.text,
                          ),
                          itemSelectedValue: districtSelectController.text,
                          selectController: districtSelectController,
                          hintText: "Selecciona el distrito",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "El departamento es obligatorio",
                                message: "Por favor, completa el seleciona el departamento.",
                                snackType: SnackType.warning,
                              );
                              districtError.value = true;
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
            ] else ...[
              ValueListenableBuilder<bool>(
                valueListenable: extRegionError,
                builder: (context, isError, child) {
                  return InputTextFileUserProfile(
                    isError: isError,
                    onError: () => extRegionError.value = false,
                    controller: extRegionController,
                    hintText: "Escribe el nombre de tu región/estado",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        extRegionError.value = true;
                        showSnackBarV2(
                          context: context,
                          title: "La región es obligatoria",
                          message: "Por favor, ingresa tu región.",
                          snackType: SnackType.warning,
                        );
                      }
                      return null;
                    },
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: extProvinceError,
                builder: (context, isError, child) {
                  return InputTextFileUserProfile(
                    isError: isError,
                    onError: () => extProvinceError.value = false,
                    controller: extProvinceController,
                    hintText: "Escribe el nombre de tu provincia/ciudad",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        extProvinceError.value = true;
                        showSnackBarV2(
                          context: context,
                          title: "La provincia es obligatoria",
                          message: "Por favor, ingresa tu provincia.",
                          snackType: SnackType.warning,
                        );
                      }
                      return null;
                    },
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: extDistrictError,
                builder: (context, isError, child) {
                  return InputTextFileUserProfile(
                    isError: isError,
                    onError: () => extDistrictError.value = false,
                    controller: extDistrictController,
                    hintText: "Escribe el nombre de tu distrito/localidad",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        extDistrictError.value = true;
                        showSnackBarV2(
                          context: context,
                          title: "El distrito es obligatorio",
                          message: "Por favor, ingresa tu distrito.",
                          snackType: SnackType.warning,
                        );
                      }
                      return null;
                    },
                  );
                },
              ),
            ],
            ValueListenableBuilder<bool>(
              valueListenable: addressError,
              builder: (context, isError, child) {
                return InputTextFileUserProfile(
                  isError: isError,
                  onError: () => addressError.value = false,
                  controller: addressTextController,
                  hintText: "Escribe tu dirección de domicilio",
                  validator: (value) {
                    validateAddress(
                      value: value,
                      field: "Dirección de domicilio",
                      context: context,
                      boolNotifier: addressError,
                    );
                    return null;
                  },
                );
              },
            ),
            const Expanded(
              child: SizedBox(),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: widget.isEdit,
              builder: (context, isEditValue, child) {
                return Column(
                  children: [
                    isEditValue
                        ? ButtonInvestment(
                            text: "Guardar datos",
                            onPressed: uploadLocationData,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
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
