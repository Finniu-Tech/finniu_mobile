import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/select_invest_v4.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/fund_row_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepOneV4 extends StatelessWidget {
  const StepOneV4({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepScaffold(
      children: StepOneBody(),
    );
  }
}

class StepOneBody extends StatelessWidget {
  const StepOneBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductContainerStyles;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height < 700
            ? 650
            : MediaQuery.of(context).size.height - 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FundRowStep(
              icon: args.imageProduct,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextPoppins(
                text: args.titleText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                lines: 2,
                align: TextAlign.start,
                textDark: titleDark,
                textLight: titleLight,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text: "Completa los siguientes datos",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            FormStepOne(
              formKey: formKey,
            ),
          ],
        ),
      ),
    );
  }
}

class FormStepOne extends HookConsumerWidget {
  const FormStepOne({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeController = useTextEditingController();
    final originController = useTextEditingController();
    final ValueNotifier<bool> timeError = useState(false);
    final ValueNotifier<bool> originError = useState(false);

    const List<String> optionsTime = ["6", "12", "24"];
    const List<String> optionsOrigin = [
      "Salario",
      "Ahorros",
      'Venta Bienes',
      'Inversiones',
      'Herencia',
      'Préstamos',
      'Otros'
    ];
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: timeError,
            builder: (context, isError, child) {
              return SelecDropdownInvest(
                isError: isError,
                onError: () => timeError.value = false,
                itemSelectedValue: timeController.text,
                title: "  Plazo  ",
                hintText: "Seleccione su plazo de inversión",
                selectController: timeController,
                options: optionsTime,
                validator: (p0) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: originError,
            builder: (context, isError, child) {
              return SelecDropdownInvest(
                isError: isError,
                onError: () => originError.value = false,
                itemSelectedValue: originController.text,
                title: "  Origen de procedencia  ",
                hintText: "Seleccione origen",
                selectController: originController,
                options: optionsOrigin,
                validator: (p0) {
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
