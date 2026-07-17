import 'package:dio/dio.dart';
import 'token_refresher.dart';
import 'token_store.dart';

// Plain Interceptor (not QueuedInterceptor): retrying via _dio.fetch inside a
// QueuedInterceptor's onError deadlocks on its own queue. Concurrent-401 dedup
// is handled by TokenRefresher's single-flight, so queuing is unnecessary.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._store, this._refresher, this._dio);
  final TokenStore _store;
  final TokenRefresher _refresher;
  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['skip_auth'] != true) {
      final access = await _store.readAccess();
      if (access != null) options.headers['Authorization'] = 'Bearer $access';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['auth_retried'] == true;
    final skipAuth = err.requestOptions.extra['skip_auth'] == true;
    if (!is401 || alreadyRetried || skipAuth) return handler.next(err);

    final newAccess = await _refresher.refresh();
    if (newAccess == null) return handler.next(err);

    final options = err.requestOptions
      ..extra['auth_retried'] = true
      ..headers['Authorization'] = 'Bearer $newAccess';
    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
