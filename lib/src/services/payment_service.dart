import 'dart:convert';
import 'dart:io';

import 'package:bank_vault/src/api/payment_system_api.dart';
import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/data/invoice.dart';
import 'package:http/http.dart';

class PaymentService {
  final Client _http;

  PaymentService(this._http);

  Future<Invoice> getInvoiceForApplication(final int appId) async {
    final Response response = await _http.get(PaymentSystemApi.getInvoiceUrl(appId));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Invoice.fromJson(json.decode(response.body));
      case ServerApi.UNPROCESSABLE_ENTITY_STATUS:
        throw InvoiceIssueException();
      default:
        print("Failed to issue invoice! Error ${response.statusCode}");
        throw UnexpectedException(response.statusCode);
    }
  }

  Future<int> payForCell(final Invoice invoice, final int sum,
      final String paymentMethod) async {
    final Response response = await _http.post(
        PaymentSystemApi.payUrl(sum, paymentMethod),
        headers: PaymentSystemApi.headers,
        body: json.encode(invoice)
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return int.parse(response.body);
      case ServerApi.UNPROCESSABLE_ENTITY_STATUS:
        throw NotEnoughMoneyException();
      default:
        print("Failed to pay for invoice! Error ${response.statusCode}");
        throw UnexpectedException(response.statusCode);
    }
  }

  Future<bool> acceptPayment(final Invoice invoice) async {
    final Response response = await _http.post(
        ServerApi.acceptPaymentUrl,
        headers: PaymentSystemApi.headers,
        body: json.encode(invoice));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      print("Failed to accept payment! Error ${response.statusCode}");
      return false;
    }
  }
}

class InvoiceIssueException implements Exception {}

class NotEnoughMoneyException implements Exception {}