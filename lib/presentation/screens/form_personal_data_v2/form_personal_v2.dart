import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';

class FormPersonalDataV2 extends StatelessWidget {
  const FormPersonalDataV2({super.key});

  final int textDark = 0xffFFFFFF;
  final int textLight = 0xff0D3A5C;

  @override
  Widget build(BuildContext context) {
    // void uploadPersonalData() {
    //   print("add personal  data");
    // }

    // void continueLater() {
    //   print("continue later");

    //   Navigator.pop(context);
    // }

    return const ScaffoldUserProfile(
      // bottomNavigationBar: ActionButtonScanDocument(
      //   uploadDocuments: () => uploadPersonalData(),
      //   continueLater: () => continueLater(),
      // ),
      bottomNavigationBar: NavigationBarHome(),
      appBar: AppBarLogo(),
      children: [
        SizedBox(
          height: 10,
        ),
        ProgressForm(
          progress: 0.2,
        ),
      ],
    );
  }
}
