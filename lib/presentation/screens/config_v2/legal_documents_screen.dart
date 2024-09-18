import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
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
        title: "Terminos y condiciones",
        message: "Es obligatorio aceptar los terminos y condiciones",
        snackType: SnackType.warning,
      );
    }

    return Column(
      children: [
        ExpansionTitleLegal(
          title: "Verificación  legal",
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
            RowDownload(
              title: "Declaración - Marzo",
              onTap: () => print("pon tap download"),
            ),
            RowDownload(
              title: "Declaración - Junio",
              onTap: () => print("pon tap download"),
            ),
          ],
        ),
        ExpansionTitleLegal(
          title: "Aceptaciones legales y/o tributarios",
          children: [
            RowDownload(
              title: "Términos y Condiciones",
              onTap: () => print("pon tap download"),
            ),
            RowDownload(
              title: "Política de Privacidad",
              onTap: () => print("pon tap download"),
            ),
            RowDownload(
              title: "Reglamento de Participación",
              onTap: () => print("pon tap download"),
            ),
            RowDownload(
              title: "Contrato de Administración",
              onTap: () => print("pon tap download"),
            ),
          ],
        ),
      ],
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
