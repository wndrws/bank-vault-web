import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/data/leasing_info.dart';
import 'package:bank_vault/src/enums/cell_application_status.dart';

class ManagerService {
  final Client _http;

  ManagerService(this._http);

  Future<List<LeasingInfo>> getApplications() async {
    final Response response = await _http.get(ServerApi.applicationsInfoUrl);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return _extractData(json.decode(response.body));
      default:
        throw UnexpectedException(response.statusCode);
    }
  }

  List<LeasingInfo> _extractData(List<dynamic> appsJsonArray) =>
      appsJsonArray.map((json) => LeasingInfo.fromJson(json))
          .where((app) => app.status == CellApplicationStatus.CELL_CHOSEN)
          .toList();

  Future<void> approveApplication(final int appId) async {
    final Response response = await _http.patch(ServerApi.approveApplicationUrl(appId));
    if (response.statusCode != HttpStatus.ok) {
      throw UnexpectedException(response.statusCode);
    }
  }

  Future<void> declineApplication(final int appId) async {
    final Response response = await _http.patch(ServerApi.declineApplicationUrl(appId));
    if (response.statusCode != HttpStatus.ok) {
      throw UnexpectedException(response.statusCode);
    }
  }
}