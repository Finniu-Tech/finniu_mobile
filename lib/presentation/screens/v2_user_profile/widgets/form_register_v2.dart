import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormRegister extends HookConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(),
          ButtonInvestment(
            text: "Crear mi cuenta",
            onPressed: () => {
              if (formKey.currentState!.validate())
                {
                  // Process data.
                  print(""),
                },
            },
          ),
        ],
      ),
    );
  }
}
