import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';
import 'package:bank_vault/src/services/user_service.dart';

import 'package:bank_vault/src/routing/route_paths.dart';

@Component(
  selector: 'login-component',
  styleUrls: ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: [routerDirectives, formDirectives]
)
class LoginComponent implements OnActivate {
  String message = "";
  String username = "";
  String password = "";

  final Router _router;
  final UserService _userService;
  final LocalUserStorage _localUserStorage;

  LoginComponent(this._router, this._userService, this._localUserStorage);

  Future<NavigationResult> login() async {
    if (await _userService.login(username, password)) {
      return _router.navigate(RoutePaths.home.toUrl());
    } else {
      message = "Неверный логин или пароль";
      return _router.navigate(_router.current.toUrl());
    }
  }

  Future<NavigationResult> register() async {
    _localUserStorage.setCredentials(username, password);
    return _router.navigate(RoutePaths.register.toUrl());
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    if (_userService.isUserLoggedIn()) {
      _router.navigate(RoutePaths.home.toUrl());
    }
  }
}