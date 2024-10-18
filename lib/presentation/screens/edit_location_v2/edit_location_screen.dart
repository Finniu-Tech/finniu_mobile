import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/dropdown_select_provider.dart';
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
  const EditLocationForm({
    super.key,
    required this.isEdit,
    required this.onEdit,
  });
  final ValueNotifier<bool> isEdit;
  final VoidCallback onEdit;

  @override
  LocationFormState createState() => LocationFormState();
}

class LocationFormState extends ConsumerState<EditLocationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final countrySelectController = TextEditingController(
    text: "Peru",
  );
  final regionsSelectController = TextEditingController();
  final provinceSelectController = TextEditingController();
  final districtSelectController = TextEditingController();
  final addressTextController = TextEditingController();
  // final houseNumberController = TextEditingController();

  final ValueNotifier<bool> regionsError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> provinceError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> districtError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> addressError = ValueNotifier<bool>(false);
  // final ValueNotifier<bool> houseNumberError = ValueNotifier<bool>(false);

  void uploadLocationData() {
    if (!formKey.currentState!.validate()) {
      showSnackBarV2(
        context: context,
        title: "Datos obligatorios incompletos",
        message: "Por favor, completa todos los campos.",
        snackType: SnackType.warning,
      );
    } else {
      if (regionsError.value) return;
      if (provinceError.value) return;
      if (districtError.value) return;
      if (addressError.value) return;
      // if (houseNumberError.value) return;
      DtoLocationForm data = DtoLocationForm(
        country: countrySelectController.text,
        region: regionsSelectController.text,
        province: provinceSelectController.text,
        district: districtSelectController.text,
        address: addressTextController.text.trim(),
        // houseNumber: houseNumberController.text.trim(),
      );
      context.loaderOverlay.show();
      pushLocationDataForm(
        context,
        data,
        ref,
        navigate: '/home_v2',
        isNavigate: true,
      );
      widget.onEdit();
    }
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
    regionsSelectController.text = userProfile.region ?? "";
    provinceSelectController.text = userProfile.provincia ?? "";
    districtSelectController.text = userProfile.distrito ?? "";
    addressTextController.text = userProfile.address ?? "";
    // houseNumberController.text = userProfile.houseNumber ?? "";
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
        height: MediaQuery.of(context).size.height < 700
            ? 490
            : MediaQuery.of(context).size.height * 0.70,
        child: Column(
          children: [
            const LocationMessage(),
            const SizedBox(
              height: 15,
            ),
            SelectableDropdownItem(
              options: const ["Peru"],
              itemSelectedValue: countrySelectController.text,
              selectController: countrySelectController,
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
                          message:
                              "Por favor, completa el seleciona el departamento.",
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
                                message:
                                    "Por favor, completa el seleciona el provincia.",
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
                                message:
                                    "Por favor, completa el seleciona el departamento.",
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
                                message:
                                    "Por favor, completa el seleciona el provincia.",
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
                                message:
                                    "Por favor, completa el seleciona el departamento.",
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
              InputTextFileUserProfile(
                controller: regionsSelectController,
                hintText: "Escribe tu departamento",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu departamento';
                  }
                  return null;
                },
              ),
              InputTextFileUserProfile(
                controller: provinceSelectController,
                hintText: "Escribe tu provincia",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu provincia';
                  }
                  return null;
                },
              ),
              InputTextFileUserProfile(
                controller: districtSelectController,
                hintText: "Escribe tu distrito",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu distrito';
                  }
                  return null;
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
            // ValueListenableBuilder<bool>(
            //   valueListenable: houseNumberError,
            //   builder: (context, isError, child) {
            //     return InputTextFileUserProfile(
            //       isNumeric: true,
            //       isError: isError,
            //       onError: () => houseNumberError.value = false,
            //       controller: houseNumberController,
            //       hintText: "Número de tu domicilio",
            //       validator: (value) {
            //         validateNumber(
            //           value: value,
            //           field: "Número de tu domicilio",
            //           context: context,
            //           boolNotifier: houseNumberError,
            //         );
            //         return null;
            //       },
            //     );
            //   },
            // ),
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
