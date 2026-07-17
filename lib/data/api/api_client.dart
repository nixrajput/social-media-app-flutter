import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/config/env.dart';
import 'auth_interceptor.dart';
import 'request_id_interceptor.dart';
import 'retry_interceptor.dart';
import 'token_refresher.dart';
import 'token_store.dart';

part 'api_client.g.dart';

@riverpod
Dio dio(Ref ref, TokenStore store) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  final refresher = TokenRefresher(dio, store);
  dio.interceptors.addAll([
    RequestIdInterceptor(),
    AuthInterceptor(store, refresher, dio),
    RetryInterceptor(dio),
  ]);
  return dio;
}
