class ServerApi {
  static const String _root = "http://localhost:8080/api/";

  static const String loginUrl = _root + "login";

  static const String registerUrl = _root + "register";

  static const String isRegisteredUrl = _root + "isRegistered";

  static const Map<String, String> headers = {'Content-Type': 'application/json'};
}