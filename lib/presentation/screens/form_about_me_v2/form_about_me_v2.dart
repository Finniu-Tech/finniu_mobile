import 'dart:io';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/add_image.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_about_me_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/form_data_navigator.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/progress_form.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AboutMeDataV2 extends HookConsumerWidget {
  AboutMeDataV2({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final facebookTextController = useTextEditingController(text: "https://facebook.com/");
    final instagramTextController = useTextEditingController(text: "https://instagram.com/");
    final linkedinTextController = useTextEditingController(text: "https://linkendIn.com/");
    final biographyAreaController = useTextEditingController();
    final String? imageBase64 = ref.watch(imageBase64Provider);
    void uploadJobData() {
      if (formKey.currentState!.validate()) {
        context.loaderOverlay.show();
        final DtoAboutMeForm data = DtoAboutMeForm(
          imageProfile: imageBase64 ?? "",
          backgroundPhoto: imageBase64 ?? "",
          facebook: facebookTextController.text.trim(),
          instagram: instagramTextController.text.trim(),
          linkedin: linkedinTextController.text.trim(),
          biography: biographyAreaController.text.trim(),
          other: "",
        );
        pushAboutMeDataForm(context, data, ref);
      }
    }

    void continueLater() {
      Navigator.pushNamed(context, "/home_v2");
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
            subTitle: "Cuéntanos un poco sobre ti (Es opcional)",
            icon: "assets/svg_icons/user_icon_v2.svg",
          ),
          AboutMeForm(
            formKey: formKey,
            facebookTextController: facebookTextController,
            instagramTextController: instagramTextController,
            linkedinTextController: linkedinTextController,
            profilAreaController: biographyAreaController,
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
    final String? imagePath = ref.watch(imagePathProvider);
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          imagePath == null ? const AddImageProfile() : const ImageProfileRender(),
          const SizedBox(
            height: 10,
          ),
          InputTextAreaUserProfile(
            controller: profilAreaController,
            hintText: "Escribe una breve biografía sobre ti.",
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

class AddImageProfile extends ConsumerWidget {
  const AddImageProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff222222;
    const int backgroundLight = 0xffEEEEEE;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              addImage(context: context, ref: ref);
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg_icons/gallery_add_icon_v2.svg",
                  width: 20,
                  height: 20,
                  color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const TextPoppins(
            text: "Sube una foto",
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}

class ImageProfileRender extends ConsumerWidget {
  const ImageProfileRender({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imagePath = ref.watch(imagePathProvider);
    return imagePath != null
        ? GestureDetector(
            onTap: () {
              addImage(context: context, ref: ref);
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.fill,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextPoppins(
                    text: "Sube una foto",
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
