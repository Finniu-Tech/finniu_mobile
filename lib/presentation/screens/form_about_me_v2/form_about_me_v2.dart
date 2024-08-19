import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutMeDataV2 extends HookConsumerWidget {
  AboutMeDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadJobData() {
      if (formKey.currentState!.validate()) {
        print("add personal data");
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
          finishBool: true,
          addData: () => uploadJobData(),
          continueLater: () => continueLater(),
        ),
        appBar: const AppBarLogo(),
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProgressForm(
            progress: 0.8,
          ),
          const TitleForm(
            title: "Sobre mi",
            subTitle: "Cuéntanos un poco sobre tí (Es opcional)",
            icon: "assets/svg_icons/user_icon_v2.svg",
          ),
          AboutMeForm(
            formKey: formKey,
          ),
        ],
      ),
    );
  }
}

class AboutMeForm extends ConsumerWidget {
  const AboutMeForm({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: const Column(
        children: [],
      ),
    );
  }
}
