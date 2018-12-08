import 'package:angular/angular.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_datepicker/material_datepicker.dart';
import 'package:angular_components/material_datepicker/module.dart';
import 'package:angular_components/model/date/date.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:intl/intl.dart';

import 'package:bank_vault/src/services/user_service.dart';
import 'package:bank_vault/src/routing/route_paths.dart';


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

  String serial = "";
  String firstName = "";
  String lastName = "";
  String patronymic;
  Date birthDate;
  String phone;
  String email;

  final Location _location;
  final Router _router;
  final UserService _userService;

  RegisterComponent(this._location, this._router, this._userService);

  Future<NavigationResult> register() async {
    if(await _userService.register(serial, firstName, lastName, patronymic,
        birthDate?.format(DateFormat("yyyy-MM-dd")) ?? "", email, phone)) {
      return _router.navigate(RoutePaths.home.toUrl());
    }
    return _router.navigate(_router.current.toUrl());
  }

  void cancel() {
    _userService.logout();
    _location.back();
  }

  bool canProceed() {
    return serial.isNotEmpty && firstName.isNotEmpty && lastName.isNotEmpty;
  }
}