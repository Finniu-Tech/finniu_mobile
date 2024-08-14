import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/container_message.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormPersonalDataV2 extends StatelessWidget {
  const FormPersonalDataV2({super.key});

  final int textDark = 0xffFFFFFF;
  final int textLight = 0xff0D3A5C;
  final String title = "Datos personales";
  final String subTitle = "¿Cuales son tus datos personales?";
  final String icon = "assets/svg_icons/user_icon_v2.svg";

  @override
  Widget build(BuildContext context) {
    // void uploadPersonalData() {
    //   print("add personal  data");
    // }

    // void continueLater() {
    //   print("continue later");

    //   Navigator.pop(context);
    // }

    return ScaffoldUserProfile(
      // bottomNavigationBar: ActionButtonScanDocument(
      //   uploadDocuments: () => uploadPersonalData(),
      //   continueLater: () => continueLater(),
      // ),
      bottomNavigationBar: const NavigationBarHome(),
      appBar: const AppBarLogo(),
      children: [
        const SizedBox(
          height: 10,
        ),
        const ProgressForm(
          progress: 0.2,
        ),
        TitleForm(
          title: title,
          subTitle: subTitle,
          icon: icon,
        ),
        const PersonalForm(),
        const ContainerMessage(),
      ],
    );
  }
}

class PersonalForm extends HookConsumerWidget {
  const PersonalForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: const Column(
        children: [],
      ),
    );
  }
}
