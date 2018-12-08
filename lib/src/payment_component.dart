import 'package:angular/angular.dart';
import 'package:angular_components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:bank_vault/src/data/invoice.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';
import 'package:bank_vault/src/services/payment_service.dart';
import 'package:dialog/dialogs/alert.dart';

const List<Map<String, String>> _paymentMethods = [
  { 'id': 'CARD', 'name': 'Банковская карта'},
  { 'id': 'CASH', 'name': 'Наличные'},
];


@Component(
    selector: 'payment-component',
    styleUrls: ['payment_component.css'],
    templateUrl: 'payment_component.html',
    directives: [coreDirectives, formDirectives, MaterialYesNoButtonsComponent]
)
class PaymentComponent {
  Invoice invoice;
  int applicationId;
  String cellId;
  String paymentMethod;
  int sum;
  String errorMessage = "";

  final ModalFormsService _modalFormsService;
  final PaymentService _paymentService;

  PaymentComponent(this._modalFormsService, this._paymentService);

  List<Map<String, String>> get paymentMethods => _paymentMethods;

  Future<void> initiatePayment() async {
    invoice = await _paymentService.getInvoiceForApplication(applicationId);
  }

  Future<void> pay() async {
    final int change = await _paymentService.payForCell(invoice, sum, paymentMethod);
    if (change == sum) {
      errorMessage = "Оплата не прошла. Средства возвращены.";
    } else {
      alert("Оплата прошла успешно, сдача: $change руб.");
      invoice.isPaid = true;
      final bool accepted = await _paymentService.acceptPayment(invoice);
      if (!accepted) {
        alert("Ошибка обработки платежа на стороне Банковского Хранилища."
            "Пожалуйста, обратитесь в службу поддержки.");
      }
      _modalFormsService.paymentFormHidden = true;
    }
  }

  void cancel() {
    _modalFormsService.paymentFormHidden = true;
  }

  bool canSubmitPayment() => paymentMethod != null && sum is int && sum > 0;
}