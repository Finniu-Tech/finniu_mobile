import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManualConfirmationBookingWidget extends StatefulHookConsumerWidget {
  @override
  _ManualConfirmationBookingWidgetState createState() => _ManualConfirmationBookingWidgetState();
}

class _ManualConfirmationBookingWidgetState extends ConsumerState<ManualConfirmationBookingWidget> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _adjustWebViewScale();
            _injectCustomCSS();
          },
        ),
      )
      ..loadRequest(Uri.parse('https://calendar.app.google/eYhJKznwEpeGPXg28'));
  }

  void _adjustWebViewScale() {
    _controller.runJavaScript('''
      document.body.style.zoom = "100%";
      document.body.style.width = "100%";
      document.body.style.height = "100%";
      document.body.style.margin = "0";
      document.body.style.padding = "0";
      document.documentElement.style.width = "100%";
      document.documentElement.style.height = "100%";
      document.documentElement.style.margin = "0";
      document.documentElement.style.padding = "0";

      var meta = document.createElement('meta');
      meta.name = "viewport";
      meta.content = "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no";
      document.getElementsByTagName('head')[0].appendChild(meta);
    ''');
  }

  void _injectCustomCSS() {
    _controller.runJavaScript('''
      var style = document.createElement('style');
      style.textContent = `
        .modal-dialog {
          transform: none !important;
          max-width: 100% !important;
          width: 100% !important;
          margin: 0 !important;
        }
        .modal-content {
          border-radius: 0 !important;
        }
      `;
      document.head.appendChild(style);
    ''');
  }

  void _showThanksModal() {
    showThanksInvestmentDialog(
      context,
      textTitle: 'Gracias por \nconfiar en Finniu!',
      textTanks: 'Gracias por tu comprensión!',
      textBody:
          'Recuerda que tu solicitud de Inversión Agro Inmobiliaria sera derivada a un asesor del Proyecto, quien se contactará contigo en las proxima 24h.',
      textButton: 'Ver mi progreso',
      onPressed: () => {
        Navigator.pushNamed(context, '/v2/investment'),
      },
      onClosePressed: () => {
        Navigator.pushNamed(context, '/v2/investment'),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    Color backgroundColor = isDarkMode ? const Color(0xff1C1B1B) : const Color(0xffDFEEFF);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Agendar Reunión Finniu'),
        backgroundColor: backgroundColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: const Text('He terminado de agendar mi reunión'),
              onPressed: _showThanksModal,
            ),
          ),
        ],
      ),
    );
  }
}
