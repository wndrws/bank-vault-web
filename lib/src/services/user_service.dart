import 'dart:convert';

import 'package:bank_vault/src/server_api.dart';
import 'package:http/http.dart';

import 'package:bank_vault/src/services/local_user_storage.dart';

class UserService {
  final LocalUserStorage _userStorage;

  final Client _http;

  UserService(this._userStorage, this._http);

  Future<void> register(final String serial, final String firstName,
      final String lastName, [final String patronymic = "",
        final String formattedBirthDate = "", final String email = "",
        final String phone = ""]) async {
    final response = await _http.post(
        ServerApi.registerUrl,
        headers: ServerApi.headers,
        body: json.encode({
          "userCredentials": {
            "login": _userStorage.username,
            "password": _userStorage.password
          },
          "clientInfo": {
            "passportSerial": serial,
            "firstName": firstName,
            "lastName": lastName,
            "patronymic": patronymic,
            "birthday": formattedBirthDate,
            "email": email,
            "phone": phone
          }
        })
    );
    final int userId = int.parse(response.body);
    _userStorage.reset();
    _userStorage.setCurrentUser(userId);
  }

  Future<bool> login(final String user, final String pass) async {
    final response = await _http.post(
        ServerApi.loginUrl,
        headers: ServerApi.headers,
        body: json.encode({"login": user, "password": pass})
    );
    final int userId = int.tryParse(response.body) ?? -1;
    if (userId != -1) {
      _userStorage.setCurrentUser(userId);
      return true;
    }
    return false;
  }

  void logout() {
    _userStorage.reset();
  }
}