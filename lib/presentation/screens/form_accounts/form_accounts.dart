import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/account_expanded.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/input_select_accounts.dart';
import 'package:finniu/presentation/screens/form_accounts/widget/input_text_accounts.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormAccountsScreen extends StatelessWidget {
  const FormAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Agregar cuenta bancaria",
      children: FormAccountsBody(),
    );
  }
}

class FormAccountsBody extends StatelessWidget {
  const FormAccountsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: FormAccounts(),
      ),
    );
  }
}

class FormAccounts extends HookConsumerWidget {
  FormAccounts({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankController = useTextEditingController();
    final ValueNotifier<bool> bankError = useState(false);
    final ValueNotifier<bool> acceptPrivacyAndTerms = useState(false);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return SelectableDropdownAccounts(
                title: "  Banco  ",
                options: const ["Peru"],
                itemSelectedValue: bankController.text,
                isError: isError,
                onError: () => bankError.value = false,
                selectController: bankController,
                hintText: "Selecione su banco",
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return SelectableDropdownAccounts(
                title: "  Tipo de cuenta  ",
                options: const ["Peru"],
                itemSelectedValue: bankController.text,
                isError: isError,
                onError: () => bankError.value = false,
                selectController: bankController,
                hintText: "Selecciona el tipo de cuenta",
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Número de cuenta",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textDark: 0xffA2E6FA,
            textLight: 0xff0D3A5C,
            align: TextAlign.start,
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => bankError.value = false,
                controller: bankController,
                hintText: "Escribe el número de cuenta",
                isNumeric: true,
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Número de cuenta interbancaria (CCI)",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textDark: 0xffA2E6FA,
            textLight: 0xff0D3A5C,
            align: TextAlign.start,
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => bankError.value = false,
                controller: bankController,
                hintText: "Escribe el número de cuenta",
                isNumeric: true,
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              TextPoppins(
                text: "Nombre de la cuenta ",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: 0xffA2E6FA,
                textLight: 0xff0D3A5C,
                align: TextAlign.start,
              ),
              TextPoppins(
                text: "*Opcional",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textDark: 0xffA2E6FA,
                textLight: 0xff0D3A5C,
                align: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<bool>(
            valueListenable: bankError,
            builder: (context, isError, child) {
              return InputTextFileAccounts(
                isError: isError,
                onError: () => bankError.value = false,
                controller: bankController,
                hintText: "Escribe el número de cuenta",
                validator: (value) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          AccountExpanded(
            children: [
              const SizedBox(
                height: 5,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bankError,
                builder: (context, isError, child) {
                  return InputTextFileAccounts(
                    isError: isError,
                    onError: () => bankError.value = false,
                    controller: bankController,
                    hintText: "Nombres de la otra persona titular",
                    validator: (value) {
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bankError,
                builder: (context, isError, child) {
                  return InputTextFileAccounts(
                    isError: isError,
                    onError: () => bankError.value = false,
                    controller: bankController,
                    hintText: "Apellido paterno",
                    validator: (value) {
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bankError,
                builder: (context, isError, child) {
                  return InputTextFileAccounts(
                    isError: isError,
                    onError: () => bankError.value = false,
                    controller: bankController,
                    hintText: "Apellido materno",
                    validator: (value) {
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bankError,
                builder: (context, isError, child) {
                  return SelectableDropdownAccounts(
                    title: "",
                    options: const ["Peru"],
                    itemSelectedValue: bankController.text,
                    isError: isError,
                    onError: () => bankError.value = false,
                    selectController: bankController,
                    hintText: "Tipo de Documento",
                    validator: (value) {
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bankError,
                builder: (context, isError, child) {
                  return InputTextFileAccounts(
                    isError: isError,
                    onError: () => bankError.value = false,
                    controller: bankController,
                    hintText: "Número de documento",
                    validator: (value) {
                      return null;
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              CheckBoxWidget(
                value: acceptPrivacyAndTerms.value,
                onChanged: (a) {
                  acceptPrivacyAndTerms.value = !acceptPrivacyAndTerms.value;
                },
              ),
              const TextPoppins(
                text: "Usar en mis futuras operaciones",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            children: [
              CheckBoxWidget(
                value: acceptPrivacyAndTerms.value,
                onChanged: (a) {
                  acceptPrivacyAndTerms.value = !acceptPrivacyAndTerms.value;
                },
              ),
              const TextPoppins(
                text: "Declaro que es mi cuenta personal",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          ButtonInvestment(text: "Guardar cuenta", onPressed: () {}),
        ],
      ),
    );
  }
}
