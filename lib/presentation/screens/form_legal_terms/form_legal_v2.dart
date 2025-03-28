import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_terms_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/check_box_input.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormLegalTermsDataV2 extends HookConsumerWidget {
  const FormLegalTermsDataV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final isPublicOfficialOrFamilyCheckbox = useState(userProfile.isPublicOfficialOrFamily ?? false);
    final isDirectorOrShareholder10PercentCheckbox = useState(userProfile.isDirectorOrShareholder10Percent ?? false);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldUserProfile(
        appBar: const AppBarLogo(),
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProgressForm(
            progress: 0.3,
          ),
          const TitleForm(
            title: "Términos legales",
            subTitle: "",
            icon: "assets/svg_icons/legal_icon_v2.svg",
          ),
          LegalTermsForm(
            formKey: formKey,
            publicOfficialCheckboxValue: isPublicOfficialOrFamilyCheckbox,
            amDirectorCheckboxValue: isDirectorOrShareholder10PercentCheckbox,
          ),
        ],
      ),
    );
  }
}

class LegalTermsForm extends ConsumerWidget {
  const LegalTermsForm({
    super.key,
    required this.formKey,
    required this.publicOfficialCheckboxValue,
    required this.amDirectorCheckboxValue,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> publicOfficialCheckboxValue;
  final ValueNotifier<bool> amDirectorCheckboxValue;
  final String civilServantText =
      "Eres miembro o familiar de un funcionario público o una persona políticamente expuesta.";
  final String amDirectorText = "Soy un director o un accionista del 10% de una corporación que cotiza en bolsa.";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadJobData() {
      if (formKey.currentState!.validate()) {
        context.loaderOverlay.show();
        final data = DtoLegalTermsForm(
          isPublicOfficialOrFamily: publicOfficialCheckboxValue.value,
          isDirectorOrShareholder10Percent: amDirectorCheckboxValue.value,
        );
        context.loaderOverlay.show();
        pushLegalTermsDataForm(context, data, ref);
      }
    }

    void continueLater() {
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.pushNamedAndRemoveUntil(context, '/v2/home', (Route<dynamic> route) => false);
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          CheckBoxInput(
            text: civilServantText,
            checkboxValue: publicOfficialCheckboxValue.value,
            onPressed: () {
              publicOfficialCheckboxValue.value = !publicOfficialCheckboxValue.value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CheckBoxInput(
            text: amDirectorText,
            checkboxValue: amDirectorCheckboxValue.value,
            onPressed: () {
              amDirectorCheckboxValue.value = !amDirectorCheckboxValue.value;
            },
          ),
          FormDataNavigator(
            addData: () => uploadJobData(),
            continueLater: continueLater,
            continueLaterBool: false,
          ),
        ],
      ),
    );
  }
}
