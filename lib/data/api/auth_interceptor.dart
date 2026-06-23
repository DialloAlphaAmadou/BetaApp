import 'package:dio/dio.dart';
import 'package:first_app/data/local/auth_storage.dart';
import 'package:first_app/dto/auth_dto.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Dio refreshDio;
  final AuthStorage storage;
  final Future<void> Function() onLogout;
  
  Future<bool>? _refreshFuture;

  AuthInterceptor({
    required this.dio,
    required this.refreshDio,
    required this.storage,
    required this.onLogout
  });

  @override
  Future<void> onRequest( RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await storage.getAccessToken();
    if (accessToken != null) options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<void> onError( DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode != 401) return handler.next(error);
    final request = error.requestOptions;
    final data = error.response?.data;

    //Anti boucle
    if (request.extra['retried'] == true) return handler.next(error);
    request.extra['retried'] = true;

    final refreshToken = await storage.getRefreshToken();
    final message = data is Map<String, dynamic> ? data['message'] : data?.toString();

    if (refreshToken == null || message == "999"){
      //await storage.clearSessionAsync();
      await onLogout();
      return handler.next(error);
    }

    final refreshFuture = _refreshFuture ??= _refreshToken(refreshToken);

    try {

      final success = await refreshFuture;

      //final success = await _refreshToken(refreshToken);
      if (!success) {
        //await storage.clearSessionAsync();
        await onLogout();
        return handler.next(error);
      }

      final newToken = await storage.getAccessToken();
      if (newToken == null) {
        //await storage.clearSessionAsync();
        await onLogout();
        return handler.next(error);
      }
      request.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(request);
      handler.resolve(response);

    } catch (_) {
      //await storage.clearSessionAsync();
      await onLogout();
      handler.next(error);

    } finally {
      if (identical(_refreshFuture, refreshFuture)) {
        _refreshFuture = null;
      }
    }
  }

  /*Future<void> _logout() async {
    await storage.clearSessionAsync();
    await onLogout();
  }*/

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final response = await refreshDio.post('/auth/refresh-session', data: {'RefreshToken': refreshToken});
      final session = SessionResponse.fromJson(response.data);
      await storage.saveTokensAsync(session);
      return true;

    } catch (_) {
      await storage.clearSessionAsync();
      return false;
    }
  }

}





/*
  Future<void> _logout(String refreshToken) async {
    try {
      await dio.post('/auth/logout', data:  {'RefreshToken': refreshToken});
    } finally {
      await storage.clearSessionAsync();
    }
  }
  */


    /*
  final refreshDio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    headers: ApiConfig.headers
  ));*/