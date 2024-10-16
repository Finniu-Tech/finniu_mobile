import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_date_picker.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/input_text_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/edit_personal_screen.dart';
import 'package:finniu/presentation/screens/v2_user_profile/helpers/validate_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdditionalInformationScreen extends StatelessWidget {
  const AdditionalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "",
      children: _BodyAdditional(),
    );
  }
}

class _BodyAdditional extends HookConsumerWidget {
  const _BodyAdditional();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);

    final nickNameController = useTextEditingController(
      text: userProfile.nickName ?? '',
    );
    final dateController = useTextEditingController();

    final ValueNotifier<bool> nickNameError = useState(false);
    final ValueNotifier<bool> dateError = useState(false);
    final ValueNotifier<bool> isEdit = useState(false);

    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextPoppins(
              text: "Información adicional",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isEdit,
              builder: (context, isEditValue, child) {
                return isEditValue
                    ? const SizedBox()
                    : EditWidget(
                        onTap: () => isEdit.value = true,
                      );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: nickNameError,
                      builder: (context, isError, child) {
                        return InputTextFileUserProfile(
                          onError: () => nickNameError.value = false,
                          isError: isError,
                          hintText: "Como te llaman",
                          controller: nickNameController,
                          validator: (value) {
                            validateName(
                              value: value,
                              context: context,
                              boolNotifier: nickNameError,
                            );
                            return null;
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: dateError,
                      builder: (context, isError, child) {
                        return InputDatePickerUserProfile(
                          isError: isError,
                          onError: () => dateError.value = false,
                          hintText: "Fecha de nacimiento",
                          controller: dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              showSnackBarV2(
                                context: context,
                                title: "Fecha de nacimiento incorrecta",
                                message: "Por favor, completa la fecha.",
                                snackType: SnackType.warning,
                              );
                              dateError.value = true;
                              return null;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isEdit,
                  builder: (context, isEditValue, child) {
                    return isEditValue
                        ? const SizedBox()
                        : Positioned.fill(
                            child: IgnorePointer(
                              ignoring: false,
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextPoppins(
                text: "Marcaste que eres",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                align: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text:
                  "Eres miembro o familiar de un funcionario público o una persona políticamente expuesta.",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              lines: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text:
                  "Eres director o accionista del 10% de una corporación que cotiza en bolsa.",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              lines: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isEdit,
              builder: (context, isEditValue, child) {
                return isEditValue ? const RequestChange() : const SizedBox();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isEdit,
              builder: (context, isEditValue, child) {
                return isEditValue
                    ? const ButtonInvestment(
                        text: "Guardar",
                        onPressed: null,
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RequestChange extends ConsumerWidget {
  const RequestChange({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int divider = 0xffD9D9D9;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Column(
      children: [
        const Divider(
          color: Color(divider),
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.help_outline,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextPoppins(
                    text: "¿Quieres cambiarlo?",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextPoppins(
                    text: "Solicita el cambio y el motivo al correo",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    align: TextAlign.start,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  TextPoppins(
                    text: "operaciones@finniu.com",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.start,
                    textDark: iconDark,
                    textLight: iconLight,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
