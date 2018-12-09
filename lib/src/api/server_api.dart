class ServerApi {
  static const String _root = "http://localhost:8080/api/";

  static const String loginUrl = _root + "login";

  static const String registerUrl = _root + "register";

  static const String isRegisteredUrl = _root + "isRegistered";

  static String cellsByClientUrl(int id) => _root + "info/cellsByClient/$id";

  static String applyUrl(int clientId) => _root + "apply/client/$clientId";

  static String requestCellUrl(int appId) => _root + "apply/cell/$appId";

  static const String acceptPaymentUrl = _root + "apply/payment";

  static String putPreciousUrl(int appId) => _root + "manipulate/put/$appId";

  static String getPreciousUrl(int appId) => _root + "manipulate/get/$appId";

  static const Map<String, String> headers = {'Content-Type': 'application/json'};

  static const int UNPROCESSABLE_ENTITY_STATUS = 422;
}

class UnexpectedException implements Exception {}