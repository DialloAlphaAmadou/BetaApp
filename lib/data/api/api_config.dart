class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'http://localhost:8080/api';

  static const Duration connectTimeout = Duration(seconds: 10);

  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };




}