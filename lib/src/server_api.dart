class ServerApi {
  static const String _root = "http://localhost:8080/api/";

  static const String loginUrl = _root + "login";

  static const Map<String, String> headers = {'Content-Type': 'application/json'};
}