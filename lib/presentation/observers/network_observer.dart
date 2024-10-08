import 'package:finniu/presentation/screens/catalog/widgets/snackbar/network_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionAwareNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _checkInternetConnection(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _checkInternetConnection(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _checkInternetConnection(previousRoute);
    }
  }

  void _checkInternetConnection(Route<dynamic> route) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected && route.navigator?.context != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showNetworkWarning(context: route.navigator!.context);
      });
    }
  }
}
