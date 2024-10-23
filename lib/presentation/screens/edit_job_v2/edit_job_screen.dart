import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_jod_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/edit_personal_screen.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/widgets/image_edit_stack.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditJobDataScreen extends StatelessWidget {
  const EditJobDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Ocupación laboral",
      children: _BodyEditJob(),
    );
  }
}

class _BodyEditJob extends ConsumerWidget {
  const _BodyEditJob();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isEdit = ValueNotifier<bool>(false);
    const int backgroundImage = 0xff0D3A5C;
    return Column(
      children: [
        const IconEditStack(
          svgUrl: "assets/svg_icons/bag_icon_v2.svg",
          backgroundImage: backgroundImage,
        ),
        const TextPoppins(
          text: "Información de mi ocupación laboral",
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
                EditPersonalForm(
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

class EditPersonalForm extends HookConsumerWidget {
  const EditPersonalForm({
    super.key,
    required this.isEdit,
    required this.onEdit,
  });
  final ValueNotifier<bool> isEdit;
  final VoidCallback onEdit;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(userProfileNotifierProvider);

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
        pushOccupationDataForm(
          context,
          data,
          ref,
          navigate: '/home_v2',
          isNavigate: true,
        );
        onEdit();
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height < 700
            ? 350
            : MediaQuery.of(context).size.height * 0.70,
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
            ValueListenableBuilder<bool>(
              valueListenable: isEdit,
              builder: (context, isEditValue, child) {
                return Column(
                  children: [
                    isEditValue
                        ? ButtonInvestment(
                            text: "Guardar datos",
                            onPressed: uploadJobData,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
