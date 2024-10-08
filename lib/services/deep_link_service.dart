import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appLinksProvider = Provider<AppLinks>((ref) => AppLinks());

// deep link handler
final deepLinkHandlerProvider = Provider((ref) => DeepLinkHandler(ref));

class DeepLinkHandler {
  final Ref _ref;
  StreamSubscription<Uri>? _linkSubscription;
  AppLinks? _appLinks;

  DeepLinkHandler(this._ref);

  void initialize() {
    print('DeepLinkHandler: initialize');
    _appLinks = _ref.read(appLinksProvider);

    // Listen to app link changes when the app is in the foreground or background
    _linkSubscription = _appLinks!.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('onAppLink: $uri');
        handleDeepLink(uri);
      }
    });
  }

  void handleDeepLink(Uri uri) {
    print('Deep link handled: $uri');
    // Ejemplo: Navigator.of(context).pushNamed(uri.path);
    //test for android
    //adb shell am start -W -a android.intent.action.VIEW -d "finniuapp://finniu.com/ver-detalle/123"
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
