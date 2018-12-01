import 'package:angular_router/angular_router.dart';

import 'package:bank_vault/src/routing/route_paths.dart';

import 'package:bank_vault/src/client_component.template.dart' as client_component;
import 'package:bank_vault/src/login_component.template.dart' as login_component;

class Routes {
  static final root = RouteDefinition.redirect(
    path: '',
    redirectTo: RoutePaths.login.toUrl()
  );

  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_component.LoginComponentNgFactory
  );

  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: client_component.ClientComponentNgFactory
  );

  static final all = <RouteDefinition>[root, login, home];
}