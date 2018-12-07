import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';

class CellApplicationService {
  static const int NO_APPLICATION = -1;

  final LocalUserStorage _userStorage;

  final Client _http;

  CellApplicationService(this._userStorage, this._http);

  Future<int> createApplication() async {
    final Response response = await _http.post(ServerApi
        .applyUrl(_userStorage.currentUserId), headers: ServerApi.headers);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return int.parse(response.body);
      default:
        print("Failed to apply for cell! Error ${response.statusCode} : " +
            response.reasonPhrase);
        return NO_APPLICATION;
    }
  }

  Future<bool> requestCell(int appId, String size, int leaseDays) async {
    final Response response = await _http.post(ServerApi
        .requestCellUrl(appId), headers: ServerApi.headers,
        body: json.encode({ 'size': size, 'leaseDays': leaseDays }));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        print("Failed request cell! Error ${response.statusCode} : " +
            response.reasonPhrase);
        return false;
    }
  }
}