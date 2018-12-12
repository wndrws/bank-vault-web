import 'package:angular_router/angular_router.dart';

const String commonPrefix = "spa/";

class RoutePaths {
  static final login = RoutePath(path: commonPrefix + 'login');
  static final register = RoutePath(path: commonPrefix + 'register');
  static final home = RoutePath(path: commonPrefix + 'home');
  static final manager = RoutePath(path: commonPrefix + 'manager');
}