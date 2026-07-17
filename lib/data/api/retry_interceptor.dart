import 'package:dio/dio.dart';

// Retries idempotent GETs on transient network/5xx errors with backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.maxRetries = 2});
  final Dio _dio;
  final int maxRetries;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final isGet = options.method.toUpperCase() == 'GET';
    final attempt = (options.extra['retry_attempt'] as int?) ?? 0;
    final transient =
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode ?? 0) >= 500;
    if (isGet && transient && attempt < maxRetries) {
      await Future<void>.delayed(Duration(milliseconds: 200 * (1 << attempt)));
      options.extra['retry_attempt'] = attempt + 1;
      try {
        final response = await _dio.fetch<dynamic>(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }
    handler.next(err);
  }
}
