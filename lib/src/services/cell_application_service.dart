import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';

class CellApplicationService {
  final LocalUserStorage _userStorage;

  final Client _http;

  CellApplicationService(this._userStorage, this._http);

  Future<int> createApplication() async {
    final Response response = await _http.post(ServerApi
        .applyUrl(_userStorage.currentUserId), headers: ServerApi.headers);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return int.parse(response.body);
      case ServerApi.UNPROCESSABLE_ENTITY_STATUS:
        throw InvalidUserException();
      default:
        print("Failed to apply for cell! Error ${response.statusCode}");
        throw UnexpectedException(response.statusCode);
    }
  }

  Future<bool> requestCell(int appId, String size, int leaseDays) async {
    final Response response = await _http.post(ServerApi
        .requestCellUrl(appId), headers: ServerApi.headers,
        body: json.encode({ 'size': size, 'leaseDays': leaseDays }));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.body == 'true';
      default:
        print("Failed to request cell! Error ${response.statusCode}");
        throw UnexpectedException(response.statusCode);
    }
  }
}

class InvalidUserException implements Exception {}