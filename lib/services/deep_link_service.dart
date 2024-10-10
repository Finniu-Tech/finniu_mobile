import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appLinksProvider = Provider<AppLinks>((ref) => AppLinks());
final deepLinkHandlerProvider = Provider((ref) => DeepLinkHandler(ref));

class DeepLinkHandler {
  final Ref _ref;
  StreamSubscription<Uri>? _linkSubscription;
  late AppLinks _appLinks;
  static const platform = MethodChannel('com.finniu/deeplink');
  late String _deepLinkScheme;

  DeepLinkHandler(this._ref);

  Future<void> initialize() async {
    print('DeepLinkHandler: initialize');
    _appLinks = _ref.read(appLinksProvider);

    // Get the deep link scheme for the current flavor
    _deepLinkScheme = await getDeepLinkScheme();
    print('Current deep link scheme: $_deepLinkScheme');

    // Handle initial link
    try {
      final initialLink = await _appLinks.getInitialLink();
      print('Initial deep link: $initialLink');
      if (initialLink != null) {
        handleDeepLink(initialLink);
      }
    } catch (e) {
      print('Error getting initial app link: $e');
    }

    // Listen to app link changes when the app is in the foreground or background
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      print('onAppLink: $uri');
      if (uri != null) {
        handleDeepLink(uri);
      }
    });

    // Set up method channel handler
    platform.setMethodCallHandler((call) async {
      if (call.method == 'handleDeepLink') {
        final String? link = call.arguments;
        if (link != null) {
          handleDeepLink(Uri.parse(link));
        }
      }
    });
  }

  Future<String> getDeepLinkScheme() async {
    try {
      final String result = await platform.invokeMethod('getDeepLinkScheme');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get deep link scheme: '${e.message}'.");
      return 'finniuapp'; // Default to production scheme
    }
  }

  void handleDeepLink(Uri uri) {
    if (isValidDeepLink(uri)) {
      print('Deep link handled: $uri');
      print('Scheme: ${uri.scheme}');
      print('Host: ${uri.host}');
      print('Path: ${uri.path}');
      print('Query parameters: ${uri.queryParameters}');
      // Implement your navigation logic here
      // For example:
      // if (uri.path.startsWith('/ver-detalle')) {
      //   final id = uri.pathSegments.last;
      //   // Navigate to detail page with id
      // }
    } else {
      print('Invalid deep link: $uri');
    }
  }

  bool isValidDeepLink(Uri uri) {
    return uri.scheme == _deepLinkScheme || uri.scheme == 'https';
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
