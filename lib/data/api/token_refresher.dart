import 'dart:async';
import 'package:dio/dio.dart';
import 'token_store.dart';

class TokenRefresher {
  TokenRefresher(this._dio, this._store);
  final Dio _dio;
  final TokenStore _store;
  Future<String?>? _inFlight;

  // Single-flight: concurrent callers share one refresh network call.
  Future<String?> refresh() {
    return _inFlight ??= _run().whenComplete(() => _inFlight = null);
  }

  Future<String?> _run() async {
    final refresh = await _store.readRefresh();
    if (refresh == null) return null;
    try {
      final res = await _dio.post<dynamic>(
        '/auth/token/refresh',
        data: {'refreshToken': refresh},
        options: Options(extra: {'skip_auth': true}),
      );
      final tokens = (res.data as Map)['tokens'] as Map;
      final access = tokens['accessToken'] as String;
      await _store.writeTokens(
        access: access,
        refresh: tokens['refreshToken'] as String,
      );
      return access;
    } on DioException {
      await _store.clear();
      return null;
    }
  }
}
