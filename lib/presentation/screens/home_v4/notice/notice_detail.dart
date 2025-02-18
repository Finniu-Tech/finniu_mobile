import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoticeDetail extends StatelessWidget {
  const NoticeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)?.settings.arguments as String;
    final String url = args.isNotEmpty ? args : "https://finniu.tawk.help/";

    return Scaffold(
      appBar: const AppBarNoticesDetail(
        title: "Noticias",
      ),
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
          },
          onNavigationRequest: (NavigationRequest request) {
            // Manejar URLs de WhatsApp
            if (request.url.startsWith('whatsapp://') ||
                request.url.startsWith('https://wa.me/') ||
                request.url.startsWith('https://api.whatsapp.com/')) {
              try {
                launchUrl(
                  Uri.parse(request.url),
                  mode: LaunchMode.externalApplication,
                );
                return NavigationDecision.prevent;
              } catch (e) {
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
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
}
