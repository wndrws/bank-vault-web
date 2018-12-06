import 'package:angular/angular.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:bank_vault/src/services/modal_forms_service.dart';

const List<Map<String, String>> _sizes = [
  { 'id': 'SMALL',  'name': 'Малый (1 л)'   },
  { 'id': 'MEDIUM', 'name': 'Средний (2 л)' },
  { 'id': 'BIG',    'name': 'Большой (4 л)' },
];

@Component(
    selector: 'cell-application-component',
    styleUrls: ['cell_application_component.css'],
    templateUrl: 'cell_application_component.html',
    directives: [coreDirectives, formDirectives, MaterialYesNoButtonsComponent]
)
class CellApplicationComponent {
  String size;
  num leaseDays;
  String errorMessage = "";

  final ModalFormsService _modalFormsService;

  CellApplicationComponent(this._modalFormsService);

  List<Map<String, String>> get sizes => _sizes;

  void apply() {

  }

  void cancel() {
    _modalFormsService.applicationFormHidden = true;
  }

  bool canApply() => size != null && leaseDays is int && leaseDays > 0;
}