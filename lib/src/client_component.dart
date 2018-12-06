import 'dart:async';
import 'package:intl/intl.dart';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/routing/route_paths.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';
import 'package:bank_vault/src/services/user_service.dart';
import 'package:bank_vault/src/services/web_time_service.dart';
import 'package:bank_vault/src/cell_table_component.dart';

@Component(
  selector: 'client-component',
  styleUrls: ['client_component.css'],
  templateUrl: 'client_component.html',
  directives: [CellTableComponent]
)
class ClientComponent implements OnInit, CanActivate {
  String clockText = "";

  final LocalUserStorage _localUserStorage;
  final Router _router;
  final UserService _userService;
  final WebTimeService _timeService;

  final _clockFormatter = DateFormat("dd.MM.yyyy H:mm:ss");

  ClientComponent(this._localUserStorage,  this._router, this._userService,
      this._timeService);

  @override
  void ngOnInit() {
    print("current user id = ${_localUserStorage.currentUserId}");
    _schedulePeriodicClockUpdate();
  }

  void logout() => _userService.logout();

  @override
  Future<bool> canActivate(RouterState current, RouterState next) async {
    return _userService.isUserLoggedIn();
  }

  void _schedulePeriodicClockUpdate() {
    Timer.periodic(Duration(seconds: 1), (_) async {
      try {
        final DateTime dt = await _timeService.getCurrentLocalDateTime();
        clockText = _clockFormatter.format(dt);
      } on Exception catch (e) {
        print("Failed to fetch time! Reason: ${e}");
      }
    });
  }
}