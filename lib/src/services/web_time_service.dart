import 'dart:io';
import 'dart:convert';

import 'package:bank_vault/src/api/web_time_api.dart';
import 'package:http/http.dart';

class WebTimeService {
  static final Map<String, String> _queryParams = {
    'key': WebTimeApi.key,
    'format': 'json',
    'fields': 'timestamp',
    'by': 'zone',
    'zone': 'Atlantic/Reykjavik' // UTC and no daylight savings
  };

  final Client _http;

  WebTimeService(this._http);

  Future<DateTime> getCurrentLocalDateTime() async {
    final Response response = await _http.get(Uri
        .http(WebTimeApi.authority, WebTimeApi.getTimeEndpoint, _queryParams));
    if (response.statusCode == HttpStatus.ok) {
      return _extractDateTimeUTC(json.decode(response.body)).toLocal();
    } else {
      throw Exception("Web Time server responsed with ${response.statusCode}: "
          + response.reasonPhrase);
    }
  }

  DateTime _extractDateTimeUTC(final dynamic json) {
    final String apiStatus = json["status"];
    if (apiStatus == "OK") {
      final int epochMillis = json["timestamp"] * 1000;
      return DateTime.fromMillisecondsSinceEpoch(epochMillis, isUtc: true);
    } else {
      throw json["message"];
    }
  }
}