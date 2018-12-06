class ServerApi {
  static const String _root = "http://localhost:8080/api/";

  static const String loginUrl = _root + "login";

  static const String registerUrl = _root + "register";

  static const String isRegisteredUrl = _root + "isRegistered";

  static String cellsByClientUrl(int id) => _root + "info/cellsByClient/$id";

  static String applyUrl(int clientId) => _root + "apply/client/$clientId";

  static const Map<String, String> headers = {'Content-Type': 'application/json'};
}