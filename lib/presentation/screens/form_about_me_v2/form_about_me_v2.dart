import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutMeDataV2 extends HookConsumerWidget {
  AboutMeDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final facebookTextController =
        useTextEditingController(text: "https://facebook.com/");
    final instagramTextController =
        useTextEditingController(text: "https://instagram.com/");
    final linkedinTextController =
        useTextEditingController(text: "https://linkendIn.com/");
    final profilAreaController = useTextEditingController();
    void uploadJobData() {
      if (formKey.currentState!.validate()) {
        print("add personal data");
        print(facebookTextController.text);
        print(instagramTextController.text);
        print(linkedinTextController.text);
        print(profilAreaController.text);
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
            facebookTextController: facebookTextController,
            instagramTextController: instagramTextController,
            linkedinTextController: linkedinTextController,
            profilAreaController: profilAreaController,
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
    required this.facebookTextController,
    required this.instagramTextController,
    required this.linkedinTextController,
    required this.profilAreaController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController facebookTextController;
  final TextEditingController instagramTextController;
  final TextEditingController linkedinTextController;
  final TextEditingController profilAreaController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextAreaUserProfile(
            controller: profilAreaController,
            hintText: "Escribe una breve biografía sobre tí.",
            validator: null,
          ),
          const SizedBox(
            height: 5,
          ),
          const TextPoppins(text: "Redes Sociales", fontSize: 14),
          const SizedBox(
            height: 5,
          ),
          InputTextNetworkUserProfile(
            urlIcon: "assets/svg_icons/facebook_icon_v2.svg",
            textTitle: "Facebook",
            controller: facebookTextController,
            hintText: "Facebook",
            validator: null,
          ),
          InputTextNetworkUserProfile(
            urlIcon: "assets/svg_icons/instagram_icon_v2.svg",
            textTitle: "Instagram",
            controller: instagramTextController,
            hintText: "Instagram",
            validator: null,
          ),
          InputTextNetworkUserProfile(
            urlIcon: "assets/svg_icons/linkedin_icon_v2.svg",
            textTitle: "Linkedin",
            controller: linkedinTextController,
            hintText: "Linkedin",
            validator: null,
          ),
        ],
      ),
    );
  }
}
