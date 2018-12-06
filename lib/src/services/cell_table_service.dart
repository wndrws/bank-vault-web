import 'dart:io';
import 'dart:convert';

import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';
import 'package:http/http.dart';

import 'package:bank_vault/src/data/cell.dart';

class CellTableService {
  final Client _http;
  final LocalUserStorage _localUserStorage;

  CellTableService(this._http, this._localUserStorage);

  Future<List<Cell>> getCells() async {
    final Response response = await _http.get(
        ServerApi.cellsByClientUrl(_localUserStorage.currentUserId));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return _extractData(json.decode(response.body));
      default:
        print("Failed to fetch cells! Error ${response.statusCode} : " +
            response.reasonPhrase);
        return <Cell>[];
    }
  }

  List<Cell> _extractData(List<dynamic> cellsJsonArray) =>
      cellsJsonArray.map((json) => Cell.fromJson(json)).toList();
}