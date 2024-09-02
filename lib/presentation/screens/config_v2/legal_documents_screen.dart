import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LegalDocumentsScreen extends ConsumerWidget {
  const LegalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Configuraciones",
      children: _BodyLegalDocuments(),
    );
  }
}

class _BodyLegalDocuments extends HookConsumerWidget {
  const _BodyLegalDocuments();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> politicallyExposed = useState(false);
    final ValueNotifier<bool> amDirector = useState(false);
    final ValueNotifier<bool> termsConditions = useState(false);
    void setPoliticallyExposed(bool? value) {
      if (value != null) politicallyExposed.value = value;
    }

    void setDirector(bool? value) {
      if (value != null) amDirector.value = value;
    }

    void setTermsConditions(bool? value) {
      if (value != null) termsConditions.value = value;
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
        const ExpansionTitleLegal(
          title: "Declaración de la Sunat",
          children: [
            ChildrenOnlyText(
              textBig: true,
              text:
                  "Este 5% es la tributación correspondiente por renta de 2da categoría (inversiones). Aplica sobre tus intereses ganados.",
            ),
          ],
        ),
      ],
    );
  }
}
