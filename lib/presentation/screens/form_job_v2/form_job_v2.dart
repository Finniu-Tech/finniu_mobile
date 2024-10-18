import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_jod_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
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
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProgressForm(
            progress: 0.7,
          ),
          const TitleForm(
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
  LocationForm({
    super.key,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);

    final occupationTextController = useTextEditingController(
      text: userProfile.occupation ?? "",
    );
    final companyNameTextController = useTextEditingController(
      text: userProfile.companyName ?? "",
    );

    final ValueNotifier<bool> occupationError = useState(false);
    final ValueNotifier<bool> companyNameError = useState(false);

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
        if (occupationError.value) return;
        if (companyNameError.value) return;

        context.loaderOverlay.show();
        DtoOccupationForm data = DtoOccupationForm(
          companyName: companyNameTextController.text.trim(),
          occupation: occupationTextController.text.trim(),
        );
        pushOccupationDataForm(context, data, ref);
      }
    }

    void continueLater() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home_v2',
        (Route<dynamic> route) => false,
      );
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
                  hintText: "Escribe el nombre de la empresa",
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
            const Expanded(
              child: SizedBox(),
            ),
            const ContainerMessage(),
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
