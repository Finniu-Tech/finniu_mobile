import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PushToUrlScreen extends StatelessWidget {
  const PushToUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;
    final String url = args?.isNotEmpty ?? false ? args! : "https://finniu.tawk.help/";

    return Scaffold(
      appBar: const AppBarProducts(
        title: "",
      ),
      // Eliminar SingleChildScrollView aquí ya que el WebView maneja su propio scroll
      body: NoticeDetailBody(
        url: url,
      ),
    );
  }
}

class NoticeDetailBody extends StatefulWidget {
  const NoticeDetailBody({
    super.key,
    required this.url,
  });
  final String url;
  @override
  State<NoticeDetailBody> createState() => _NoticeDetailBodyState();
}

class _NoticeDetailBodyState extends State<NoticeDetailBody> {
  late WebViewController _controller;
  bool _isLoading = true;
  double _webViewHeight = 1;

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
          onPageFinished: (String url) async {
            final height = MediaQuery.of(context).size.height + 100;

            setState(() {
              _isLoading = false;
              _webViewHeight = double.parse(height.toString());
            });

            await _controller.runJavaScript('''
              document.body.style.margin = '0';
              document.body.style.padding = '0';
              document.body.style.webkitTouchCallout = 'none';
              document.body.style.webkitUserSelect = 'none';
              document.body.style.userSelect = 'none';
              document.documentElement.style.webkitUserSelect = 'none';
              document.documentElement.style.userSelect = 'none';
              document.documentElement.style.overflow = 'auto';
              document.body.style.overflow = 'auto';
              document.body.style.position = 'relative';
              document.body.style.minHeight = '100vh';
              document.body.style.width = '100%';
            ''');
          },
        ),
      )
      ..enableZoom(true) // Habilitar zoom
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      color: Colors.white,
      child: Stack(
        children: [
          // Usar un SingleChildScrollView aquí para manejar contenido más largo que la pantalla
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: _webViewHeight,
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularLoader(
                width: 50,
                height: 50,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
