import 'dart:async';

import 'package:dialog/dialogs/alert.dart';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';
import 'package:bank_vault/src/services/user_service.dart';
import 'package:bank_vault/src/services/web_time_service.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';
import 'package:bank_vault/src/cell_table_component.dart';
import 'package:bank_vault/src/cell_application_component.dart';
import 'package:bank_vault/src/payment_component.dart';
import 'package:bank_vault/src/enums/cell_application_status.dart';
import 'package:bank_vault/src/precious_manipulation_component.dart';

@Component(
  selector: 'client-component',
  styleUrls: ['client_component.css'],
  templateUrl: 'client_component.html',
  directives: [
    CellTableComponent,
    CellApplicationComponent,
    PaymentComponent,
    PreciousManipulationComponent
  ]
)
class ClientComponent implements OnInit, CanActivate {
  String clockText = "";

  @ViewChild("cellsTable")
  CellTableComponent cellsTable;

  @ViewChild("paymentForm")
  PaymentComponent paymentForm;

  @ViewChild("putForm")
  PreciousManipulationComponent preciousManipComponent;

  final LocalUserStorage _localUserStorage;
  final UserService _userService;
  final WebTimeService _timeService;
  final ModalFormsService _modalFormsService;

  final _clockFormatter = DateFormat("dd.MM.yyyy H:mm:ss");

  ClientComponent(this._localUserStorage, this._userService, this._timeService,
      this._modalFormsService);

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

  bool get applicationFormHidden => _modalFormsService.applicationFormHidden;

  void displayApplicationForm() {
    _modalFormsService.applicationFormHidden = false;
  }

  bool canPay() => cellsTable.selectedCell
      ?.statusId == CellApplicationStatus.APPROVED ?? false;

  bool get paymentFormHidden => _modalFormsService.paymentFormHidden;

  void startPayment() {
    paymentForm.initiatePayment();
    _modalFormsService.paymentFormHidden = false;
  }

  bool canPut() => (cellsTable.selectedCell
      ?.statusId == CellApplicationStatus.PAID ?? false) &&
      (cellsTable.selectedCell?.precious?.isEmpty ?? false);

  bool get putFormHidden =>  _modalFormsService.putFormHidden;

  void putPrecious() {
    _modalFormsService.putFormHidden = false;
  }

  bool canGet() => cellsTable.selectedCell?.precious?.isNotEmpty ?? false;

  Future<void> getPrecious() async {
    final precious = await preciousManipComponent.get();
    alert("Ценность ${precious.name} извлечена!");
  }
}