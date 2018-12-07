class PaymentSystemApi {
  static const String _root = "http://localhost:8080/api/external/";

  static String getInvoiceUrl(int appId) => _root + "pay/invoice/$appId";

  static String payUrl(sum, paymentMethod) => _root + "pay?sum=$sum&method=$paymentMethod";

  static const Map<String, String> headers = {'Content-Type': 'application/json'};
}