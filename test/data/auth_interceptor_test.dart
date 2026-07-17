import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/data/api/auth_interceptor.dart';
import 'package:rippl/data/api/token_refresher.dart';
import 'package:rippl/data/api/token_store.dart';

class _FakeStore implements TokenStore {
  _FakeStore(this.access, this.refresh);
  String? access;
  String? refresh;

  @override
  Future<String?> readAccess() async => access;

  @override
  Future<String?> readRefresh() async => refresh;

  @override
  Future<void> writeTokens({
    required String access,
    required String refresh,
  }) async {
    this.access = access;
    this.refresh = refresh;
  }

  @override
  Future<void> clear() async {
    access = null;
    refresh = null;
  }
}

// Deterministic adapter: /me returns 401 the first time, 200 after; the refresh
// endpoint always returns fresh tokens. Avoids http_mock_adapter's response
// replay so the retry actually sees a different response.
class _SeqAdapter implements HttpClientAdapter {
  int meCalls = 0;

  ResponseBody _json(Map<String, dynamic> body, int status) =>
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path.contains('token/refresh')) {
      return _json({
        'tokens': {
          'accessToken': 'newA',
          'accessExpiresAt': '2026-01-01T00:00:00.000Z',
          'refreshToken': 'newR',
          'refreshExpiresAt': '2026-02-01T00:00:00.000Z',
        },
      }, 200);
    }
    meCalls++;
    if (meCalls == 1) {
      return _json({
        'error': {'code': 'UNAUTHORIZED', 'message': 'x', 'requestId': 'r'},
      }, 401);
    }
    return _json({'ok': true}, 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('replays a 401 once after refreshing the token', () async {
    final store = _FakeStore('oldA', 'oldR');
    final dio = Dio(BaseOptions(baseUrl: 'https://x/api/v1'));
    final adapter = _SeqAdapter();
    dio.httpClientAdapter = adapter;
    final refresher = TokenRefresher(dio, store);
    dio.interceptors.add(AuthInterceptor(store, refresher, dio));

    final res = await dio.get<dynamic>('/me');

    expect(res.statusCode, 200);
    expect(adapter.meCalls, 2);
    expect(store.access, 'newA');
  });
}
