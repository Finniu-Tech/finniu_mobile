import 'dart:async';

import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  Timer? _heightCheckTimer;

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
                print('Error al abrir WhatsApp: $e');
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) async {
            if (mounted) {
              if (url.toLowerCase().endsWith('.jpg') ||
                  url.toLowerCase().endsWith('.jpeg') ||
                  url.toLowerCase().endsWith('.png') ||
                  url.toLowerCase().endsWith('.gif')) {
                await _controller.runJavaScript('''
              // Estilos específicos para imágenes
              document.body.style.margin = '0';
              document.body.style.padding = '0';
              document.body.style.display = 'flex';
              document.body.style.alignItems = 'center';
              document.body.style.justifyContent = 'center';
              document.body.style.minHeight = '100vh';
              document.body.style.backgroundColor = '#ffffff';

              var img = document.querySelector('img');
              if (img) {
                img.style.maxWidth = '100%';
                img.style.maxHeight = '90vh';
                img.style.objectFit = 'contain';
                img.style.margin = 'auto';
                img.style.display = 'block';
              }
            ''');
              } else {
                _updateContentHeight();

                // Iniciar verificación periódica de altura
                _heightCheckTimer?.cancel();
                _heightCheckTimer = Timer.periodic(
                  const Duration(milliseconds: 500),
                  (timer) {
                    if (!_isLoading) {
                      _updateContentHeight();
                    }
                    // Mantener la verificación por más tiempo
                    if (timer.tick > 60) {
                      // 30 segundos
                      timer.cancel();
                    }
                  },
                );

                await _controller.runJavaScript('''
            // Función para ajustar el viewport
            function setViewportContent() {
              var viewport = document.querySelector('meta[name=viewport]');
              if (!viewport) {
                viewport = document.createElement('meta');
                viewport.name = 'viewport';
                document.head.appendChild(viewport);
              }
              viewport.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0';
            }
            setViewportContent();

            // Función para calcular altura real
            function getRealHeight() {
              const body = document.body;
              const html = document.documentElement;
              
              return Math.max(
                body.scrollHeight,
                body.offsetHeight,
                html.clientHeight,
                html.scrollHeight,
                html.offsetHeight
              );
            }

            // Ajustar contenedor principal
            function adjustMainContainer() {
              const mainContent = document.querySelector('main') || document.getElementById('root') || document.body;
              mainContent.style.width = '100%';
              mainContent.style.height = 'auto';
              mainContent.style.minHeight = '100vh';
              mainContent.style.overflow = 'visible';
            }

            // Ajustar estilos globales
            function setGlobalStyles() {
              document.body.style.margin = '0';
              document.body.style.padding = '0';
              document.body.style.width = '100%';
              document.body.style.height = 'auto';
              document.body.style.overflow = 'visible';
              document.documentElement.style.overflow = 'visible';
              document.body.style.webkitTextSizeAdjust = '100%';
            }

            // Observar cambios en el DOM
            const resizeObserver = new ResizeObserver(() => {
              window.flutter_inappwebview?.callHandler('updateHeight', getRealHeight());
            });

            resizeObserver.observe(document.body);

            // Ajustar todos los elementos fixed/sticky
            function adjustFixedElements() {
              const elements = document.querySelectorAll('*');
              elements.forEach(el => {
                const style = window.getComputedStyle(el);
                if (style.position === 'fixed' || style.position === 'sticky') {
                  el.style.position = 'absolute';
                }
              });
            }

            setGlobalStyles();
            adjustMainContainer();
            adjustFixedElements();

            // Observar cambios en el DOM
            const observer = new MutationObserver(() => {
              adjustFixedElements();
              window.flutter_inappwebview?.callHandler('updateHeight', getRealHeight());
            });

            observer.observe(document.body, {
              childList: true,
              subtree: true,
              attributes: true
            });
          ''');
              }
            }

            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..enableZoom(true) // Habilitar zoom
      ..setBackgroundColor(Colors.transparent)
      ..setUserAgent(_isImageUrl(widget.url)
          ? 'Mozilla/5.0 (compatible)'
          : 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15')
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _updateContentHeight() async {
    try {
      final String heightStr = await _controller.runJavaScriptReturningResult('''
      Math.max(
        document.documentElement.scrollHeight,
        document.body.scrollHeight,
        document.documentElement.offsetHeight,
        document.documentElement.clientHeight
      ) + 100;  // Añadimos un padding extra
    ''') as String;

      final double contentHeight = double.parse(heightStr);
      if (mounted && contentHeight > 0) {
        // Verificamos que el widget esté montado
        setState(() {
          _webViewHeight = contentHeight;
        });
      }
    } catch (e) {
      print('Error al actualizar altura: $e');
    }
  }

  bool _isImageUrl(String url) {
    final lowercaseUrl = url.toLowerCase();
    return lowercaseUrl.endsWith('.jpg') ||
        lowercaseUrl.endsWith('.jpeg') ||
        lowercaseUrl.endsWith('.png') ||
        lowercaseUrl.endsWith('.gif');
  }

  @override
  Widget build(BuildContext context) {
    if (_isImageUrl(widget.url)) {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
            ),
            if (_isLoading)
              Container(
                color: Colors.white,
                child: const Center(
                  child: CircularLoader(
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.white,
          child: Stack(
            children: [
              WebViewWidget(
                controller: _controller,
              ),
              if (_isLoading)
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularLoader(
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _heightCheckTimer?.cancel();
    super.dispose();
  }
}
