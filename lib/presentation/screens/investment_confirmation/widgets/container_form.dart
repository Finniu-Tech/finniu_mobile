import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/forms/investment_form_provider.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Monto'),
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
              int months = int.parse(value.split(' ')[0]);
              formNotifier.updateUuidDeadline(months);
              calculate;
            },
            textEditingController: deadLineController,
            labelText: "Plazo",
            hintText: "Seleccione su plazo de inversión",
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'UUID Bank'),
            onChanged: (value) {
              formNotifier.updateUuidBank(value);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'UUID Deadline'),
            onChanged: (value) {
              formNotifier.updateUuidDeadline(int.parse(value));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'UUID Plan'),
            onChanged: (value) {
              formNotifier.updateUuidPlan(value);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Currency'),
            onChanged: (value) {
              formNotifier.updateCurrency(value);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Coupon'),
            onChanged: (value) {
              formNotifier.updateCoupon(value);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes manejar el envío del formulario
              final amount = formState.amount;
              final uuidBank = formState.uuidBank;
              final uuidDeadline = formState.uuidDeadline;
              final uuidPlan = formState.uuidPlan;
              final currency = formState.currency;
              final coupon = formState.coupon;

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Datos del formulario'),
                  content: Text(
                    'Amount: $amount\n'
                    'UUID Bank: $uuidBank\n'
                    'UUID Deadline: $uuidDeadline\n'
                    'UUID Plan: $uuidPlan\n'
                    'Currency: $currency\n'
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
