import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/user_get_legal_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/helpers/inputs_user_helpers_v2.dart/helper_terms_form.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/row_dowload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalDocumentsScreen extends ConsumerWidget {
  const LegalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Documentos legales",
      floatingNull: true,
      children: _BodyLegalDocuments(),
    );
  }
}

class _BodyLegalDocuments extends HookConsumerWidget {
  const _BodyLegalDocuments();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final legalDocuments = ref.watch(userGetLegalProvider);

    final ValueNotifier<bool> politicallyExposed =
        useState(userProfile.isPublicOfficialOrFamily ?? false);
    final ValueNotifier<bool> amDirector =
        useState(userProfile.isDirectorOrShareholder10Percent ?? false);
    final ValueNotifier<bool> termsConditions =
        useState(userProfile.acceptTermsConditions ?? false);

    void setPoliticallyExposed(bool? value) {
      if (value != null) politicallyExposed.value = value;
      context.loaderOverlay.show();
      final data = DtoLegalTermsForm(
        isPublicOfficialOrFamily: politicallyExposed.value,
        isDirectorOrShareholder10Percent: amDirector.value,
      );
      changeLegalTermsData(context, data, ref);
    }

    void setDirector(bool? value) {
      if (value != null) amDirector.value = value;
      context.loaderOverlay.show();
      final data = DtoLegalTermsForm(
        isPublicOfficialOrFamily: politicallyExposed.value,
        isDirectorOrShareholder10Percent: amDirector.value,
      );
      changeLegalTermsData(context, data, ref);
    }

    void setTermsConditions(bool? value) {
      showSnackBarV2(
        context: context,
        title: "Términos y condiciones",
        message: "Es obligatorio aceptar los términos y condiciones",
        snackType: SnackType.warning,
      );
    }

    void openUrl(String? url) async {
      if (url == null) {
        showSnackBarV2(
          context: context,
          title: "Redireccion no disponible",
          message: "No hay redireccion disponible, por favor intenta de nuevo",
          snackType: SnackType.warning,
        );
        return;
      }

      if (url.isEmpty) {
        showSnackBarV2(
          context: context,
          title: "Redireccion no disponible",
          message: "No hay redireccion disponible, por favor intenta de nuevo",
          snackType: SnackType.warning,
        );
        return;
      } else {
        try {
          launch(url);
        } catch (e) {
          showSnackBarV2(
            context: context,
            title: "Redireccion no disponible",
            message:
                "No hay redireccion disponible, por favor intenta de nuevo",
            snackType: SnackType.warning,
          );
        }
      }
    }

    return legalDocuments.when(
      error: (e, s) {
        return Column(
          children: [
            ExpansionTitleLegal(
              title: "Verificación legal",
              children: [
                ChildrenCheckboxTitle(
                  text:
                      "Eres miembro o familiar de un funcionario público o una persona políticamente expuesta.",
                  value: politicallyExposed.value,
                  onChanged: setPoliticallyExposed,
                ),
                ChildrenCheckboxTitle(
                  text:
                      "Soy un director o un accionista del 10% de una corporación que cotiza en bolsa.",
                  value: amDirector.value,
                  onChanged: setDirector,
                ),
                ChildrenCheckboxTitle(
                  text: "Estoy de acuerdo con los ",
                  value: termsConditions.value,
                  onChanged: setTermsConditions,
                  isTextRich: true,
                  textRich: "Términos & condiciones y Políticas de privacidad ",
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const CircularLoader(width: 10, height: 10),
      data: (documents) {
        return Column(
          children: [
            ExpansionTitleLegal(
              title: "Verificación legal",
              children: [
                ChildrenCheckboxTitle(
                  text:
                      "Eres miembro o familiar de un funcionario público o una persona políticamente expuesta.",
                  value: politicallyExposed.value,
                  onChanged: setPoliticallyExposed,
                ),
                ChildrenCheckboxTitle(
                  text:
                      "Soy un director o un accionista del 10% de una corporación que cotiza en bolsa.",
                  value: amDirector.value,
                  onChanged: setDirector,
                ),
                ChildrenCheckboxTitle(
                  text: "Estoy de acuerdo con los ",
                  value: termsConditions.value,
                  onChanged: setTermsConditions,
                  isTextRich: true,
                  textRich: "Términos & condiciones y Políticas de privacidad ",
                ),
              ],
            ),
            ExpansionTitleLegal(
              title: "Declaración de la Sunat",
              children: [
                const ChildrenOnlyText(
                  textBig: true,
                  text:
                      "Este 5% es la tributación correspondiente por renta de 2da categoría (inversiones). Aplica sobre tus intereses ganados.",
                ),
                const TitleLegal(),
                ...documents.sunatDeclarations.map(
                  (e) => GestureDetector(
                    onTap: () => openUrl(null),
                    child: RowDownload(
                      title: e.nameFile,
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTitleLegal(
              title: "Aceptaciones legales y/o tributarios",
              children: [
                GestureDetector(
                  onTap: () => openUrl(documents.legalAcceptance.privacyPolicy),
                  child: const RowDownload(
                    title: "Términos y Condiciones",
                  ),
                ),
                GestureDetector(
                  onTap: () => openUrl(documents.legalAcceptance.privacyPolicy),
                  child: const RowDownload(
                    title: "Política de Privacidad",
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TitleLegal extends StatelessWidget {
  const TitleLegal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const TextPoppins(
          text: "Declaraciones Trimestrales ",
          fontSize: 16,
          isBold: true,
          align: TextAlign.start,
          textDark: titleDark,
          textLight: titleLight,
        ),
      ),
    );
  }
}
