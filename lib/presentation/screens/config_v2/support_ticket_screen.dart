import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/helpers/send_ticket.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/support_ticket/dropdown_support.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/support_ticket/input_support.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/support_ticket/text_area_support.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/support_ticket/tittle_support.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SupportTicketScreen extends StatelessWidget {
  const SupportTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Ticket de soporte",
      children: _BodySupport(),
    );
  }
}

class _BodySupport extends StatelessWidget {
  const _BodySupport();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleSupport(),
        _FormSupport(),
      ],
    );
  }
}

class _FormSupport extends HookConsumerWidget {
  const _FormSupport();
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String title =
        "Completa los siguiente datos para poder ayudarte lo más pronto posible";
    //categorias: login, inversiones, pagos
    final categoryController = useTextEditingController();
    final emailController = useTextEditingController();
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final textExtendedController = useTextEditingController();
    // final imageController = useTextEditingController();

    final ValueNotifier<bool> categoryError = useState(false);
    final ValueNotifier<bool> emailError = useState(false);
    final ValueNotifier<bool> firstNameError = useState(false);
    final ValueNotifier<bool> lastNameError = useState(false);
    final ValueNotifier<bool> textExtendedError = useState(false);
    // final ValueNotifier<bool> imageError = useState(false);
    void sendTicket() {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (categoryError.value) return;
        if (emailError.value) return;
        if (firstNameError.value) return;
        if (lastNameError.value) return;
        if (textExtendedError.value) return;
        // if (imageError.value) return;
        context.loaderOverlay.show();
        final DtoSupportForm data = DtoSupportForm(
          category: categoryController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          message: textExtendedController.text,
          imageBase64: "",
        );
        sendTicketSupport(context, data, ref);
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            const TextPoppins(
              text: title,
              fontSize: 14,
              lines: 2,
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder<bool>(
              valueListenable: categoryError,
              builder: (context, isError, child) {
                return SelectableSupportDropdownItem(
                  isError: isError,
                  onError: () => categoryError.value = false,
                  itemSelectedValue: categoryController.text,
                  options: const [
                    "Login",
                    "Inversiones",
                    "Pagos",
                  ],
                  selectController: categoryController,
                  hintText: "Elige una categoría",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Selecione una categoría",
                        message:
                            "Por favor, completa el seleciona el tipo de categoría.",
                        snackType: SnackType.warning,
                      );
                      categoryError.value = true;
                      return null;
                    }

                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder<bool>(
              valueListenable: emailError,
              builder: (context, isError, child) {
                return InputTextSupport(
                  isError: isError,
                  onError: () => emailError.value = false,
                  controller: emailController,
                  hintText: "Ingresa tu correo electrónico",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Nombre",
                      context: context,
                      boolNotifier: emailError,
                    );
                    return null;
                  },
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: firstNameError,
              builder: (context, isError, child) {
                return InputTextSupport(
                  isError: isError,
                  onError: () => firstNameError.value = false,
                  controller: firstNameController,
                  hintText: "Ingresa tus nombre",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Nombre",
                      context: context,
                      boolNotifier: firstNameError,
                    );
                    return null;
                  },
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: lastNameError,
              builder: (context, isError, child) {
                return InputTextSupport(
                  isError: isError,
                  onError: () => lastNameError.value = false,
                  controller: lastNameController,
                  hintText: "Ingresa tus apellidos",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Apellido",
                      context: context,
                      boolNotifier: lastNameError,
                    );
                    return null;
                  },
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: textExtendedError,
              builder: (context, isError, child) {
                return InputTextAreaSupport(
                  isError: isError,
                  onError: () => textExtendedError.value = false,
                  controller: textExtendedController,
                  hintText:
                      "Cuéntanos el problema que estas presentando en la app",
                  validator: (value) {
                    validateString(
                      value: value,
                      field: "Problema",
                      context: context,
                      boolNotifier: textExtendedError,
                    );
                    return null;
                  },
                );
              },
            ),
            ButtonInvestment(
              text: "Enviar mi reporte",
              onPressed: () => sendTicket(),
            ),
          ],
        ),
      ),
    );
  }
}



// class SupportTicketScreen extends StatefulHookConsumerWidget {
//   const SupportTicketScreen({Key? key}) : super(key: key);

//   @override
//   _SupportTicketScreenState createState() => _SupportTicketScreenState();
// }

// class _SupportTicketScreenState extends ConsumerState<SupportTicketScreen> {
//   late WebViewController _controller;
//   bool _isLoading = true;
//   final String supportURL = 'https://finniu.com/support_ticket/';

//   @override
//   void initState() {
//     super.initState();
//     _initializeWebView();
//   }

//   void _initializeWebView() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             setState(() {
//               _isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               _isLoading = false;
//             });
//             _adjustWebViewScale();
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(supportURL));
//   }

//   void _adjustWebViewScale() {
//     _controller.runJavaScript('''
//       document.body.style.width = "100%";
//       document.body.style.height = "100%";
//       document.body.style.margin = "0";
//       document.body.style.padding = "0";
//       document.documentElement.style.width = "100%";
//       document.documentElement.style.height = "100%";
//       document.documentElement.style.margin = "0";
//       document.documentElement.style.padding = "0";

//       var meta = document.createElement('meta');
//       meta.name = "viewport";
//       meta.content = "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no";
//       document.getElementsByTagName('head')[0].appendChild(meta);
//     ''');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebViewScaffoldConfig(
//       title: 'Ticket de soporte',
//       child: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     Color backgroundColor = isDarkMode ? const Color(0xff191919) : const Color(0xffFFFFFF);

//     return Stack(
//       children: [
//         WebViewWidget(controller: _controller),
//         if (_isLoading)
//           Container(
//             color: backgroundColor,
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }
// }
