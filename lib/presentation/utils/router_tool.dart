import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final AppRouteObserver<Route<dynamic>> routeObserver = AppRouteObserver<Route<dynamic>>();

BuildContext get currentContext => navigatorKey.currentContext!;

OverlayState? get currentOverlay => navigatorKey.currentState?.overlay;

class AppRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  final List<String> _routeNames = <String>[];

  String get currentRouteName => _routeNames.isNotEmpty ? _routeNames.last : '/';

  String get previousRouteName => _routeNames.length > 1 ? _routeNames[_routeNames.length - 2] : '/';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (route.settings.name != null) {
      _routeNames.add(route.settings.name!);
    }

    // info('[ROUTE] didPush:$_routeNames');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    if (route.settings.name != null) {
      _routeNames.removeLast();
    }

    // info('[ROUTE] didPop:$_routeNames');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);

    if (_routeNames.length > 2) {
      _routeNames.removeRange(1, _routeNames.length - 1);
    }

    // info('[ROUTE] didRemove:$_routeNames');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute?.settings.name != null) {
      _routeNames.removeLast();
      _routeNames.add(newRoute!.settings.name!);
    }

    // info('[ROUTE] didReplace:$_routeNames');
  }
}
