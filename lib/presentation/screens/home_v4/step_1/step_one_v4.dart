import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/input_invest_v4.dart';
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
      useDefaultLoading: true,
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;

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
    final amountController = useTextEditingController();
    final couponController = useTextEditingController();
    final ValueNotifier<bool> timeError = useState(false);
    final ValueNotifier<bool> originError = useState(false);
    final ValueNotifier<bool> amountError = useState(false);
    final ValueNotifier<bool> couponError = useState(false);

    const List<String> optionsTime = ["6 meses", "12 meses", "24 meses"];
    const List<String> optionsOrigin = [
      "Salario",
      "Ahorros",
      'Venta Bienes',
      'Inversiones',
      'Herencia',
      'Préstamos',
      'Otros',
    ];

    const buttonBack = 0xffA2E6FA;
    const buttonText = 0xff0D3A5C;
    const buttonBorder = 0xff0D3A5C;

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 25),
          ValueListenableBuilder<bool>(
            valueListenable: amountError,
            builder: (context, isError, child) {
              return InputTextFileInvest(
                title: "  Monto  ",
                isNumeric: true,
                controller: amountController,
                isError: isError,
                onError: () => amountError.value = false,
                hintText: "Ingrese su monto de inversión",
                validator: (p0) {
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 25),
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
          const SizedBox(height: 25),
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
          const SizedBox(height: 25),
          Stack(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: couponError,
                builder: (context, isError, child) {
                  return InputTextFileInvest(
                    title: "  Si es que tienes un cupón  ",
                    isNumeric: true,
                    controller: couponController,
                    isError: isError,
                    onError: () => couponError.value = false,
                    hintText: "Ingresa tu cupón",
                    validator: (p0) {
                      return null;
                    },
                  );
                },
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(buttonBorder),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        color: const Color(buttonBack),
                      ),
                      child: const TextPoppins(
                        text: "Aplicarlo",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textDark: buttonText,
                        textLight: buttonText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
