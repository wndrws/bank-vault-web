import 'dart:convert';
import 'dart:io';

import 'package:bank_vault/src/api/server_api.dart';
import 'package:bank_vault/src/data/precious.dart';
import 'package:http/http.dart';

class PreciousManipulationService {
  final Client _http;

  PreciousManipulationService(this._http);

  Future<void> putPrecious(final int appId, final Precious precious) async {
    final Response response = await _http.put(
        ServerApi.putPreciousUrl(appId),
        headers: ServerApi.headers,
        body: json.encode(precious.toJson())
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return;
      case ServerApi.UNPROCESSABLE_ENTITY_STATUS:
        throw PreciousNotFitException();
      default:
        print("Failed to put precious! Error ${response.statusCode}");
        throw UnexpectedException();
    }
  }

  Future<Precious> getPrecious(final int appId) async {
    final Response response = await _http.get(ServerApi.getPreciousUrl(appId));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Precious.fromJson(json.decode(response.body));
      default:
        print("Failed to get precious! Error ${response.statusCode}");
        throw UnexpectedException();
    }
  }
}

class PreciousNotFitException implements Exception {}