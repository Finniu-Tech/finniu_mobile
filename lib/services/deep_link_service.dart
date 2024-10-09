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
  static const platform = MethodChannel('com.finniu.finniuapp/deeplink');

  DeepLinkHandler(this._ref);

  Future<void> initialize() async {
    print('DeepLinkHandler: initialize');
    _appLinks = _ref.read(appLinksProvider);

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

    // Set up method channel handler for iOS
    platform.setMethodCallHandler((call) async {
      if (call.method == 'handleDeepLink') {
        final String? link = call.arguments;
        if (link != null) {
          handleDeepLink(Uri.parse(link));
        }
      }
    });
  }

  void handleDeepLink(Uri uri) {
    // Ejemplo: Navigator.of(context).pushNamed(uri.path);
    //test for ios - the first part is the schema , the seconds the host and the path.
    //finniuapp://finniu.com/ver-detalle/123

    //test for android
    //adb shell am start -W -a android.intent.action.VIEW -d "finniuapp://finniu.com/ver-detalle/123"

    print('Deep link handled: $uri');
    print('Scheme: ${uri.scheme}');
    print('Host: ${uri.host}');
    print('Path: ${uri.path}');
    print('Query parameters: ${uri.queryParameters}');
    // Implement your navigation logic here
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
