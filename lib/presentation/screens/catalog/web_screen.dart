import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebInAppScreen extends StatefulHookConsumerWidget {
  final String supportURL;

  const WebInAppScreen({super.key, required this.supportURL});

  @override
  FrequentlyQuestionsScreenState createState() =>
      FrequentlyQuestionsScreenState();
}

class FrequentlyQuestionsScreenState extends ConsumerState<WebInAppScreen> {
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
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.supportURL),
      );
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

  @override
  Widget build(BuildContext context) {
    return ScaffoldConfig(
      title: '',
      children: _buildBody(),
    );
  }

  Widget _buildBody() {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    Color backgroundColor =
        isDarkMode ? const Color(0xff191919) : const Color(0xffFFFFFF);

    return SafeArea(
      child: SizedBox(
        height: 1100,
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: backgroundColor,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: CircularLoader(width: 50, height: 50),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
