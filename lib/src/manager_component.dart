import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/material_spinner/material_spinner.dart';
import 'package:bank_vault/src/data/leasing_info.dart';

import 'package:bank_vault/src/services/manager_service.dart';

@Component(
    selector: 'manager-component',
    styleUrls: ['manager_component.css'],
    templateUrl: 'manager_component.html',
    directives: [coreDirectives, MaterialSpinnerComponent]
)
class ManagerComponent implements OnInit {
  static const Duration _POLLING_INTERVAL = Duration(seconds: 5);

  LeasingInfo selectedInfo;
  List<LeasingInfo> leasingInfo;

  final ManagerService _managerService;

  ManagerComponent(this._managerService);

  @override
  void ngOnInit() {
    _updateList();
    _schedulePeriodicListUpdate();
  }

  void _schedulePeriodicListUpdate() {
    Timer.periodic(_POLLING_INTERVAL, (_) async {
      try {
        _updateList();
      } on Exception catch (e) {
        print("Failed to fetch cell applications! Reason: ${e}");
      }
    });
  }

  Future<void> _updateList() async {
    leasingInfo = await _managerService.getApplications();
    selectedInfo = leasingInfo.firstWhere(
            (info) => info.cellAppId == selectedInfo?.cellAppId ?? "", orElse: () => null);
  }

  void selectApplication(final LeasingInfo info) => selectedInfo = info;
}