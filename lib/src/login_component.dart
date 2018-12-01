import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:bank_vault/src/routing/route_paths.dart';

@Component(
  selector: 'login-component',
  styleUrls: ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: [routerDirectives, formDirectives]
)
class LoginComponent {
  String message = "";

  String username = "";

  String password = "";

  final Router _router;

  LoginComponent(this._router);

  Future<NavigationResult> login() {
    if (username.isNotEmpty && password.isNotEmpty) {
      return _router.navigate(RoutePaths.home.toUrl());
    } else {
      message = "Fail";
      return _router.navigate(_router.current.toUrl());
    }
  }
}