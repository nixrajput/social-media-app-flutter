import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rippl/data/repositories/auth_repository_impl.dart';
import 'package:rippl/domain/models/login_result.dart';
import 'package:rippl/services/secure_store.dart';

class _Store extends Mock implements SecureStore {}

const _loginData = {
  'email': 'n@e.com',
  'password': 'x',
  'deviceName': 'Pixel',
  'platform': 'android',
};

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late _Store store;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://x/api/v1'));
    adapter = DioAdapter(dio: dio);
    store = _Store();
    when(
      () => store.writeTokens(
        access: any(named: 'access'),
        refresh: any(named: 'refresh'),
      ),
    ).thenAnswer((_) async {});
    when(() => store.writeDeviceId(any())).thenAnswer((_) async {});
    when(() => store.clear()).thenAnswer((_) async {});
  });

  test('login returns LoginSuccess and persists tokens + deviceId', () async {
    adapter.onPost(
      '/auth/login',
      (server) => server.reply(200, {
        'user': {
          'id': 'u1',
          'username': 'nik',
          'email': 'n@e.com',
          'displayName': null,
          'avatarUrl': null,
          'isPrivate': false,
          'createdAt': '2026-01-01T00:00:00.000Z',
        },
        'tokens': {
          'accessToken': 'A',
          'accessExpiresAt': '2026-01-01T00:00:00.000Z',
          'refreshToken': 'R',
          'refreshExpiresAt': '2026-02-01T00:00:00.000Z',
        },
        'deviceId': 'd1',
      }),
      data: _loginData,
    );
    final repo = AuthRepositoryImpl(dio, store);
    final result = await repo.login(
      email: 'n@e.com',
      password: 'x',
      deviceName: 'Pixel',
      platform: 'android',
    );
    expect(result, isA<LoginSuccess>());
    verify(() => store.writeDeviceId('d1')).called(1);
  });

  test(
    'oauthLogin returns OAuthResult and persists tokens + deviceId',
    () async {
      adapter.onPost(
        '/auth/oauth/google',
        (server) => server.reply(200, {
          'user': {
            'id': 'u1',
            'username': 'nik',
            'email': 'n@e.com',
            'displayName': null,
            'avatarUrl': null,
            'isPrivate': false,
            'createdAt': '2026-01-01T00:00:00.000Z',
          },
          'tokens': {
            'accessToken': 'A',
            'accessExpiresAt': '2026-01-01T00:00:00.000Z',
            'refreshToken': 'R',
            'refreshExpiresAt': '2026-02-01T00:00:00.000Z',
          },
          'deviceId': 'd1',
          'needsProfile': true,
        }),
        data: {'idToken': 'tok', 'deviceName': 'Pixel', 'platform': 'android'},
      );
      final repo = AuthRepositoryImpl(dio, store);
      final result = await repo.oauthLogin(
        provider: 'google',
        idToken: 'tok',
        deviceName: 'Pixel',
        platform: 'android',
      );
      expect(result.needsProfile, true);
      verify(() => store.writeDeviceId('d1')).called(1);
    },
  );

  test('login returns LoginTwoFactor when the server asks for 2fa', () async {
    adapter.onPost(
      '/auth/login',
      (server) => server.reply(200, {
        'twoFactorRequired': true,
        'challengeToken': 'chal',
      }),
      data: _loginData,
    );
    final repo = AuthRepositoryImpl(dio, store);
    final result = await repo.login(
      email: 'n@e.com',
      password: 'x',
      deviceName: 'Pixel',
      platform: 'android',
    );
    expect(result, isA<LoginTwoFactor>());
    expect((result as LoginTwoFactor).challengeToken, 'chal');
  });
}
