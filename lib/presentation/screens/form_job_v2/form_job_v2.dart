import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_jod_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/list_select_dropdown.dart';
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

class FormJobDataV2 extends ConsumerWidget {
  const FormJobDataV2({super.key});

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
            progress: 0.6,
          ),
          TitleForm(
            title: "Mi ocupación",
            subTitle: "¿Cuál es tu ocupación o profesión?",
            icon: "assets/svg_icons/bag_icon_v2.svg",
          ),
          LocationForm(),
        ],
      ),
    );
  }
}

class LocationForm extends HookConsumerWidget {
  const LocationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final laborSituationSelectController = useTextEditingController();
    final occupationTextController = useTextEditingController();
    final companyNameTextController = useTextEditingController();
    final serviceTimeSelectController = useTextEditingController();

    final ValueNotifier<bool> laborSituationError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> occupationError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> companyNameError = ValueNotifier<bool>(false);
    final ValueNotifier<bool> serviceTimeError = ValueNotifier<bool>(false);

    void uploadJobData() {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (laborSituationError.value) return;
        if (occupationError.value) return;
        if (companyNameError.value) return;
        if (serviceTimeError.value) return;

        context.loaderOverlay.show();
        DtoOccupationForm data = DtoOccupationForm(
          companyName: companyNameTextController.text.trim(),
          occupation: occupationTextController.text.trim(),
          serviceTime: getServiceTimeEnum(serviceTimeSelectController.text) ??
              ServiceTimeEnum.LESS_THAN_ONE_YEAR,
          laborSituation:
              getLaborsStatusEnum(laborSituationSelectController.text) ??
                  LaborSituationEnum.EMPLOYED,
        );
        pushOccupationDataForm(context, data, ref);
      }
    }

    void continueLater() {
      Navigator.pushNamed(context, "/form_legal_terms");
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height < 700
            ? 430
            : MediaQuery.of(context).size.height * 0.77,
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: laborSituationError,
              builder: (context, isError, child) {
                return SelectableDropdownItem(
                  isError: isError,
                  onError: () => laborSituationError.value = false,
                  itemSelectedValue: laborSituationSelectController.text,
                  options: workSituation,
                  selectController: laborSituationSelectController,
                  hintText: "Selecciona tu situación laboral",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "La situacion laboral es obligatoria",
                        message:
                            "Por favor, completa el seleciona tu situación laboral.",
                        snackType: SnackType.warning,
                      );
                      laborSituationError.value = true;
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
              valueListenable: occupationError,
              builder: (context, isError, child) {
                return InputTextFileUserProfile(
                  isError: isError,
                  onError: () => occupationError.value = false,
                  controller: occupationTextController,
                  hintText: "Escribe tu ocupación/profesión",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Ocupacion",
                      context: context,
                      boolNotifier: occupationError,
                    );
                    return null;
                  },
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: companyNameError,
              builder: (context, isError, child) {
                return InputTextFileUserProfile(
                  isError: isError,
                  onError: () => companyNameError.value = false,
                  controller: companyNameTextController,
                  hintText: "Escribe tu ocupación/profesión",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Nombre de la empresa",
                      context: context,
                      boolNotifier: companyNameError,
                    );
                    return null;
                  },
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: serviceTimeError,
              builder: (context, isError, child) {
                return SelectableDropdownItem(
                  isError: isError,
                  onError: () => serviceTimeError.value = false,
                  itemSelectedValue: serviceTimeSelectController.text,
                  options: serviceTime,
                  selectController: serviceTimeSelectController,
                  hintText: "Selecciona tu situación laboral",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "La situacion laboral es obligatoria",
                        message:
                            "Por favor, completa el seleciona tu situación laboral.",
                        snackType: SnackType.warning,
                      );
                      serviceTimeError.value = true;
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
              addData: () => uploadJobData(),
              continueLater: () => continueLater(),
            ),
          ],
        ),
      ),
    );
  }
}
