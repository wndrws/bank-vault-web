import 'dart:html';

class LocalUserStorage {
  static const String CURRENT_USER_ID_KEY = "bank_vault_currentUserId";

  static const int NO_USER_ID = -1;

  final Storage _localStorage = window.localStorage;

  int _currentUserId = NO_USER_ID;
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
    _currentUserId = NO_USER_ID;
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