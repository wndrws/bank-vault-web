import 'package:angular/angular.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:bank_vault/src/data/precious.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';
import 'package:bank_vault/src/services/precious_manipulation_service.dart';

@Component(
    selector: 'precious-manipulation-component',
    templateUrl: 'precious_manipulation_component.html',
    directives: [coreDirectives, formDirectives, MaterialYesNoButtonsComponent]
)
class PreciousManipulationComponent {
  @Input()
  int applicationId;

  String name = "";
  num volume = 0.0;
  String errorMessage = "";

  final PreciousManipulationService _manipulationService;
  final ModalFormsService _modalFormsService;

  PreciousManipulationComponent(this._manipulationService, this._modalFormsService);

  bool canPut() => name.isNotEmpty && volume > 0;

  Future<void> put() async {
    try {
      await _manipulationService.putPrecious(
          applicationId, Precious(volume.round(), name));
      _modalFormsService.putFormHidden = true;
    } on PreciousNotFitException {
      errorMessage = "Этот предмет слишком велик для выбранной ячейки";
    }
  }

  Future<Precious> get() async {
    return _manipulationService.getPrecious(applicationId);
  }

  void cancel() {
    errorMessage = "";
    name = "";
    volume = 0.0;
    _modalFormsService.putFormHidden = true;
  }
}