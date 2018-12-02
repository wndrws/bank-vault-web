import 'dart:html';

class LocalUserStorage {
  static const String CURRENT_USER_ID_KEY = "bank_vault_currentUserId";

  final Storage _localStorage = window.localStorage;

  int _currentUserId = -1;
  String _username = "";
  String _password = "";

  LocalUserStorage() {
    if (_localStorage.containsKey(CURRENT_USER_ID_KEY)) {
      _currentUserId = int.parse(_localStorage[CURRENT_USER_ID_KEY]);
    }
  }

  int get currentUserId => _currentUserId;
  String get username => _username;
  String get password => _password;

  void reset() {
    _currentUserId = -1;
    _localStorage.remove(CURRENT_USER_ID_KEY);
    _username = "";
    _password = "";
  }

  void setCredentials(final String user, final String pass) {
    _username = user;
    _password = pass;
  }

  void setCurrentUser(final int id) {
    _currentUserId = id;
    _localStorage[CURRENT_USER_ID_KEY] = id.toString();
  }
}