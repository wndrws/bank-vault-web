import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_fab.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_spinner/material_spinner.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:bank_vault/src/data/invoice.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';
import 'package:bank_vault/src/services/payment_service.dart';
import 'package:bank_vault/src/api/server_api.dart';
import 'package:dialog/dialogs/alert.dart';

const List<Map<String, String>> _paymentMethods = [
  { 'id': 'CARD', 'name': 'Банковская карта'},
  { 'id': 'CASH', 'name': 'Наличные'},
];


@Component(
    selector: 'payment-component',
    templateUrl: 'payment_component.html',
    directives: [
      coreDirectives,
      formDirectives,
      MaterialYesNoButtonsComponent,
      MaterialSpinnerComponent,
      MaterialFabComponent,
      MaterialIconComponent,
    ]
)
class PaymentComponent {
  @Input()
  int applicationId;

  @Input()
  String cellId;

  Invoice invoice;
  String paymentMethod;
  int sum, change;
  String errorMessage = "";
  bool finished = false;

  final ModalFormsService _modalFormsService;
  final PaymentService _paymentService;

  PaymentComponent(this._modalFormsService, this._paymentService);

  List<Map<String, String>> get paymentMethods => _paymentMethods;

  Future<void> initiatePayment() async {
    try {
      invoice = await _paymentService.getInvoiceForApplication(applicationId);
    } on InvoiceIssueException {
      errorMessage = "Не удалось получить счет на оплату!";
    } on UnexpectedException catch (e) {
      errorMessage = e.message;
    }
  }

  Future<void> pay() async {
    try {
      change = await _paymentService.payForCell(invoice, sum, paymentMethod);
      invoice.isPaid = true;
      final bool accepted = await _paymentService.acceptPayment(invoice);
      if (!accepted) {
        alert("Ошибка обработки платежа на стороне Банковского Хранилища."
            "Пожалуйста, обратитесь в службу поддержки.");
        closeForm();
      } else {
        finished = true;
      }
    } on NotEnoughMoneyException {
      errorMessage = "Недостаточно средств для оплаты счета!";
    } on UnexpectedException catch (e) {
      errorMessage = e.message;
    }
  }

  void closeForm() {
    _modalFormsService.paymentFormHidden = true;
    _reset();
  }

  void _reset() {
    paymentMethod = null;
    sum = null;
    invoice = null;
    errorMessage = "";
    finished = false;
  }

  bool canSubmitPayment() => paymentMethod != null && sum is int && sum > 0;
}