import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_jod_form.dart';
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

class FormJobDataV2 extends HookConsumerWidget {
  FormJobDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laborSituationSelectController = useTextEditingController();
    final occupationTextController = useTextEditingController();
    final companyNameTextController = useTextEditingController();
    final serviceTimeSelectController = useTextEditingController();

    void uploadJobData() {
      if (formKey.currentState!.validate()) {
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
      Navigator.pushNamed(context, "/home_v2");
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldUserProfile(
        bottomNavigationBar: FormDataNavigator(
          addData: () => uploadJobData(),
          continueLater: () => continueLater(),
        ),
        appBar: const AppBarLogo(),
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProgressForm(
            progress: 0.6,
          ),
          const TitleForm(
            title: "Mi ocupación",
            subTitle: "¿Cuál es tu ocupación o profesión?",
            icon: "assets/svg_icons/bag_icon_v2.svg",
          ),
          LocationForm(
            formKey: formKey,
            laborSituationSelectController: laborSituationSelectController,
            occupationTextController: occupationTextController,
            companyNameTextController: companyNameTextController,
            serviceTimeSelectController: serviceTimeSelectController,
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
    required this.laborSituationSelectController,
    required this.occupationTextController,
    required this.companyNameTextController,
    required this.serviceTimeSelectController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController laborSituationSelectController;
  final TextEditingController serviceTimeSelectController;
  final TextEditingController occupationTextController;
  final TextEditingController companyNameTextController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          SelectableDropdownItem(
            itemSelectedValue: laborSituationSelectController.text,
            options: workSituation,
            selectController: laborSituationSelectController,
            hintText: "Selecciona tu situación laboral",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione situacion';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          InputTextFileUserProfile(
            controller: occupationTextController,
            hintText: "Escribe tu ocupación/profesión",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu ocupación/profesión';
              }
              return null;
            },
          ),
          InputTextFileUserProfile(
            controller: companyNameTextController,
            hintText: "Escribe el nombre de tu empresa",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu empresa';
              }
              return null;
            },
          ),
          SelectableDropdownItem(
            itemSelectedValue: serviceTimeSelectController.text,
            options: serviceTime,
            selectController: serviceTimeSelectController,
            hintText: "Tiempo de servicio",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione tiempo';
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
