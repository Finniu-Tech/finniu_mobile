import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/support_ticket/tittle_support.dart';
import 'package:flutter/widgets.dart';

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
      ],
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
