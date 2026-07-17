import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rippl/data/api/token_refresher.dart';
import 'package:rippl/data/api/token_store.dart';

class _Store extends Mock implements TokenStore {}

void main() {
  test('single-flight: concurrent refreshes issue one network call', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://x/api/v1'));
    final adapter = DioAdapter(dio: dio);
    var calls = 0;
    adapter.onPost('/auth/token/refresh', (server) {
      calls++;
      server.reply(200, {
        'tokens': {
          'accessToken': 'newA',
          'accessExpiresAt': '2026-01-01T00:00:00.000Z',
          'refreshToken': 'newR',
          'refreshExpiresAt': '2026-02-01T00:00:00.000Z',
        },
      });
    }, data: {'refreshToken': 'oldR'});
    final store = _Store();
    when(() => store.readRefresh()).thenAnswer((_) async => 'oldR');
    when(
      () => store.writeTokens(
        access: any(named: 'access'),
        refresh: any(named: 'refresh'),
      ),
    ).thenAnswer((_) async {});

    final refresher = TokenRefresher(dio, store);
    final results = await Future.wait([
      refresher.refresh(),
      refresher.refresh(),
      refresher.refresh(),
    ]);

    expect(calls, 1);
    expect(results.every((t) => t == 'newA'), isTrue);
  });
}
