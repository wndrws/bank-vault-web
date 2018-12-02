import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/server_api.dart';
import 'package:bank_vault/src/services/user_service.dart';
import 'package:http/http.dart';

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
  final Client _http;
  final UserService _userService;

  LoginComponent(this._router, this._http, this._userService);

  Future<NavigationResult> login() async {
    final int userId = await _loginWithCredentials(username, password);
    if (userId != -1) {
      _userService.currentUserId = userId;
      return _router.navigate(RoutePaths.home.toUrl());
    } else {
      message = "Неверный логин или пароль";
      return _router.navigate(_router.current.toUrl());
    }
  }

  Future<int> _loginWithCredentials(final String user, final String pass) async {
    final response = await _http.post(
        ServerApi.loginUrl,
        headers: ServerApi.headers,
        body: json.encode({"login": user, "password": pass})
    );
    return int.tryParse(response.body) ?? -1;
  }

  Future<NavigationResult> register() async {
    _userService.setCredentials(username, password);
    return _router.navigate(RoutePaths.register.toUrl());
  }
}