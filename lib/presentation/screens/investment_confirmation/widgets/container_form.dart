import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/forms/investment_form_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/select_bank_modal.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerForm extends ConsumerWidget {
  final Future<void> calculate;
  const ContainerForm({
    super.key,
    required this.calculate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formNotifierProvider);
    final formNotifier = ref.read(formNotifierProvider.notifier);
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);
    final deadLineController = TextEditingController();
    final isSoles = ref.watch(isSolesStateProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Monto",
              hintText: 'Escriba su monto de inversion',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final amount = int.tryParse(value) ?? 0;
              formNotifier.updateAmount(amount);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomSelectButton(
            width: 1000,
            height: 42,
            asyncItems: (String filter) async {
              final response = await deadLineFuture;
              return response.map((e) => e.name).toList();
            },
            callbackOnChange: (value) async {
              print(value);
              final selectDeadLine = await deadLineFuture.then(
                (e) => e.firstWhere((element) => element.name == value),
              );
              print(selectDeadLine);
              formNotifier.updateDeadline(selectDeadLine);
              if (formState.deadline != null && formState.amount != 0) {
                calculate;
              }
            },
            textEditingController: deadLineController,
            labelText: "Plazo",
            hintText: "Seleccione su plazo de inversión",
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onTap: () => showBankAccountInvestmentModal(context, ref, '', true),
            controller: TextEditingController(
              text: formState.bankAccount?.bankAccount,
            ),
            decoration: const InputDecoration(
              labelText: 'Desde qué banco realizaras la tranferencia',
              hintText: "Precione para selecionar cuenta",
            ),
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ingresa tu código promocional, si tienes uno',
              hintText: "Ingrese cupon",
            ),
            onChanged: (value) {
              formNotifier.updateCoupon(value);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes manejar el envío del formulario
              formNotifier.updateCurrency(isSoles ? 'S/' : 'dolar');
              final amount = formState.amount;
              final uuidBank = formState.bankAccount?.id;
              final uuidDeadline = formState.deadline?.uuid;
              final uuidPlan = formState.uuidPlan;
              final coupon = formState.coupon;
              print(amount);
              print(uuidBank);
              print(uuidDeadline);
              print("${formState.bankAccount?.alias} alias");
              print("${formState.bankAccount?.id} id");
              print("${formState.bankAccount?.bankAccount} account");
              print("${formState.bankAccount?.bankName} name");
              print("${formState.bankAccount?.currency} currency");
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Datos del formulario'),
                  content: Text(
                    'Amount: $amount\n'
                    'UUID Bank: $uuidBank\n'
                    'UUID Deadline: $uuidDeadline\n'
                    'UUID Plan: $uuidPlan\n'
                    'Currency: ${isSoles ? 'S/' : 'dolar'}\n'
                    'Coupon: $coupon',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
