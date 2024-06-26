import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class NavigationService {
  static final Logger _log = Logger('Navigation Service');

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> push(
    String routeName, {
    Object? arguments,
  }) {
    _log.warning('Route: $routeName | Arguments: $arguments');
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacement(
    String routeName, {
    Object? arguments,
  }) {
    _log.warning('Route: $routeName | Arguments: $arguments');
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    _log.warning('Route: $routeName | Arguments: $arguments');
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static void pop() {
    return navigatorKey.currentState!.pop();
  }
}
