import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_datepicker/material_datepicker.dart';
import 'package:angular_components/material_datepicker/module.dart';
import 'package:angular_components/model/date/date.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/server_api.dart';
import 'package:bank_vault/src/services/user_service.dart';
import 'package:http/http.dart';

import 'package:bank_vault/src/routing/route_paths.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'register-component',
    styleUrls: ['register_component.css'],
    templateUrl: 'register_component.html',
    directives: [
      routerDirectives,
      formDirectives,
      materialInputDirectives,
      MaterialDatepickerComponent,
      MaterialSaveCancelButtonsDirective,
      MaterialYesNoButtonsComponent
    ],
  providers: [datepickerBindings]
)
class RegisterComponent {
  DateRange limitToRange = DateRange(Date.today().add(years: -150), Date.today());

  String serial;
  String firstName;
  String lastName;
  String patronymic;
  Date birthDate;
  String phone;
  String email;

  final Location _location;
  final Router _router;
  final Client _http;
  final UserService _userService;

  RegisterComponent(this._location, this._router, this._http, this._userService);

  Future<NavigationResult> register() async {
    final response = await _http.post(
        ServerApi.registerUrl,
        headers: ServerApi.headers,
        body: json.encode({
          "userCredentials": {
            "login": _userService.username,
            "password": _userService.password
          },
          "clientInfo": {
            "passportSerial": serial,
            "firstName": firstName,
            "lastName": lastName,
            "patronymic": patronymic,
            "birthday": birthDate.format(DateFormat("yyyy-MM-dd")),
            "email": email,
            "phone": phone
          }
        })
    );
    _userService.reset();
    _userService.currentUserId = int.parse(response.body);
    return _router.navigate(RoutePaths.home.toUrl());
  }

  void cancel() {
    _userService.reset();
    _location.back();
  }
}