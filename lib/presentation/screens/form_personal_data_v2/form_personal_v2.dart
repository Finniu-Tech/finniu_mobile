import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormPersonalDataV2 extends StatelessWidget {
  const FormPersonalDataV2({super.key});

  final int textDark = 0xffFFFFFF;
  final int textLight = 0xff0D3A5C;

  @override
  Widget build(BuildContext context) {
    return const ScaffoldUserProfile(
      appBar: AppBarLogo(),
      children: [
        SizedBox(
          height: 10,
        ),
        SliderForm(),
      ],
    );
  }
}

class SliderForm extends ConsumerWidget {
  const SliderForm({
    super.key,
  });

  final int progressDark = 0xffA2E6FA;
  final int progressLight = 0xff0D3A5C;
  final int unSelectDark = 0xff353535;
  final int unSelectLight = 0xffC1F1FF;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Color(unSelectDark) : Color(unSelectLight),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Color(progressDark) : Color(progressLight),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          height: 7,
        ),
      ],
    );
  }
}
