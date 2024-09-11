import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_about_me_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/inputs_user_v2/about_me_inputs.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/edit_personal_v2/edit_personal_screen.dart';
import 'package:finniu/presentation/screens/form_about_me_v2/form_about_me_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditAboutDataScreen extends StatelessWidget {
  const EditAboutDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Sobre mi",
      children: _BodyEditAbout(),
    );
  }
}

class _BodyEditAbout extends ConsumerWidget {
  const _BodyEditAbout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isEdit = ValueNotifier<bool>(false);

    return Column(
      children: [
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
                EditAboutForm(
                  isEdit: isEdit,
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

class EditAboutForm extends HookConsumerWidget {
  const EditAboutForm({
    super.key,
    required this.isEdit,
  });
  final ValueNotifier<bool> isEdit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final facebookTextController =
        useTextEditingController(text: "https://facebook.com/");
    final instagramTextController =
        useTextEditingController(text: "https://instagram.com/");
    final linkedinTextController =
        useTextEditingController(text: "https://linkendIn.com/");
    final biographyAreaController = useTextEditingController();
    final String? imageBase64 = ref.watch(imageBase64Provider);
    void uploadJobData() {
      if (formKey.currentState!.validate()) {
        context.loaderOverlay.show();
        if (biographyAreaController.text == "" || imageBase64 == null) {
          Navigator.pushNamed(context, '/home_v2');
          context.loaderOverlay.hide();
          return;
        }
        final DtoAboutMeForm data = DtoAboutMeForm(
          imageProfile: imageBase64,
          backgroundPhoto: imageBase64,
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

    final String? imagePath = ref.watch(imagePathProvider);
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height < 700
            ? 650
            : MediaQuery.of(context).size.height * 0.77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            imagePath == null
                ? const AddImageProfile()
                : const ImageProfileRender(),
            const SizedBox(
              height: 10,
            ),
            InputTextAreaUserProfile(
              controller: biographyAreaController,
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
