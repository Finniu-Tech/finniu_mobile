import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_links/app_links.dart';

final appLinksProvider = Provider<AppLinks>((ref) => AppLinks());
final deepLinkRouteProvider = StateProvider<String?>((ref) => null);
// final navigatorKeyProvider = Provider((ref) => GlobalKey<NavigatorState>());

final deepLinkHandlerProvider = Provider((ref) {
  final navigatorKey = ref.watch(globalNavigatorKeyProvider);
  return DeepLinkHandler(ref, navigatorKey);
});

class DeepLinkHandler {
  final Ref _ref;
  late AppLinks _appLinks;
  final GlobalKey<NavigatorState> navigatorKey;
  static const MethodChannel _channel = MethodChannel('com.finniu/deeplink');
  final _pendingNavigation = <String>[];

  DeepLinkHandler(this._ref, this.navigatorKey);

  Future<void> initialize() async {
    print('DeepLinkHandler: initialize');
    _appLinks = _ref.read(appLinksProvider);

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'handleDeepLink') {
        final String url = call.arguments;
        handleDeepLink(Uri.parse(url));
      }
    });

    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        handleDeepLink(initialLink);
      }
    } catch (e) {
      print('Error getting initial app link: $e');
    }

    _appLinks.uriLinkStream.listen((uri) {
      handleDeepLink(uri);
    });
  }

  void handleDeepLink(Uri uri) {
    final isAuthenticated = checkAuthentication();

    if (!isAuthenticated) {
      // Guardar la ruta del deep link
      _ref.read(deepLinkRouteProvider.notifier).state = uri.path;
      _scheduleNavigation('/v2/login_email');
    } else {
      print('is authenticated');
      _scheduleNavigation(uri.path);
    }
  }

  void _scheduleNavigation(String route) {
    if (navigatorKey.currentState == null) {
      _pendingNavigation.add(route);
    } else {
      _performNavigation(route);
    }
  }

  void _performNavigation(String route) {
    navigatorKey.currentState?.pushReplacementNamed(route);
  }

  void processPendingNavigations() {
    while (_pendingNavigation.isNotEmpty) {
      final route = _pendingNavigation.removeAt(0);
      _performNavigation(route);
    }
  }

  void processDeepLink(String path) {
    if (navigatorKey.currentState == null) {
      return;
    }

    try {
      navigatorKey.currentState!.pushReplacementNamed(path);
    } catch (e) {
      print('Error navigating to $path: $e');
      // Fallback a una ruta por defecto si la navegación falla
      navigatorKey.currentState!.pushReplacementNamed('/v2/home');
    }
  }

  bool checkAuthentication() {
    final token = _ref.watch(authTokenProvider);
    if (token == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkSavedDeepLink() async {
    final savedRoute = _ref.read(deepLinkRouteProvider);
    if (savedRoute != null) {
      final isAuthenticated = checkAuthentication();
      if (isAuthenticated) {
        processDeepLink(savedRoute);
        // clean the route when is processed
        _ref.read(deepLinkRouteProvider.notifier).state = null;
        return true;
      } else {
        _performNavigation('/v2/login_email');
        return false;
      }
    } else {
      print('No saved deep link route found');
      return false;
    }
  }
}
