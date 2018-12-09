import 'package:angular/angular.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:bank_vault/src/services/cell_application_service.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';

const List<Map<String, String>> _sizes = [
  { 'id': 'SMALL', 'name': 'Малый (1 л)'},
  { 'id': 'MEDIUM', 'name': 'Средний (2 л)'},
  { 'id': 'BIG', 'name': 'Большой (4 л)'},
];

@Component(
    selector: 'cell-application-component',
    templateUrl: 'cell_application_component.html',
    directives: [coreDirectives, formDirectives, MaterialYesNoButtonsComponent]
)
class CellApplicationComponent {
  String size;
  num leaseDays;
  String errorMessage = "";

  final ModalFormsService _modalFormsService;
  final CellApplicationService _applicationService;

  CellApplicationComponent(this._modalFormsService, this._applicationService);

  List<Map<String, String>> get sizes => _sizes;

  Future<void> apply() async {
    final int appId = await _applicationService.createApplication();
    print("Application created! ID: $appId");
    final bool isCellFound = await _applicationService
        .requestCell(appId, size, leaseDays);
    if (!isCellFound) {
      errorMessage = "Нет свободных ячеек данного размера";
    } else {
      _modalFormsService.applicationFormHidden = true;
    }
  }

  void cancel() {
    _modalFormsService.applicationFormHidden = true;
  }

  bool canApply() => size != null && leaseDays is int && leaseDays > 0;
}