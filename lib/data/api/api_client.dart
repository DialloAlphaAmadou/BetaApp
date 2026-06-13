import 'package:dio/dio.dart';
import 'package:first_app/data/api/api_config.dart';
import 'package:first_app/data/api/auth_interceptor.dart';
import 'package:first_app/data/local/auth_storage.dart';

class ApiClient {
  late final Dio dio;
  
  ApiClient({ 
    required AuthStorage storage, 
    required Future<void> Function() onLogout 
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: ApiConfig.headers
      ),
    );

    final refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: ApiConfig.headers,
      ),
    );

    dio.interceptors.add(
      AuthInterceptor( dio: dio, refreshDio: refreshDio, storage: storage, onLogout: onLogout ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return dio.post(path,data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return dio.put(path,data: data);
  }

  Future<Response> delete(String path) {
    return dio.delete(path);
  }
}

