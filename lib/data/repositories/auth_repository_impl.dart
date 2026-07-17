import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/errors/api_error.dart';
import '../../domain/models/auth_session.dart';
import '../../domain/models/auth_tokens.dart';
import '../../domain/models/login_result.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../services/secure_store.dart';
import '../api/api_client.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio, this._store);
  final Dio _dio;
  final SecureStore _store;

  Never _throw(DioException e) {
    throw ApiError.fromResponse(e.response?.statusCode ?? 0, e.response?.data);
  }

  Future<AuthSession> _persist(Map<String, dynamic> data) async {
    final session = AuthSession(
      user: User.fromJson(data['user'] as Map<String, dynamic>),
      tokens: AuthTokens.fromJson(data['tokens'] as Map<String, dynamic>),
      deviceId: data['deviceId'] as String,
    );
    await _store.writeTokens(
      access: session.tokens.accessToken,
      refresh: session.tokens.refreshToken,
    );
    await _store.writeDeviceId(session.deviceId);
    return session;
  }

  @override
  Future<void> sendRegisterOtp(String email) async {
    try {
      await _dio.post<dynamic>(
        '/auth/register/send-otp',
        data: {'email': email},
        options: Options(extra: {'skip_auth': true}),
      );
    } on DioException catch (e) {
      _throw(e);
    }
  }

  @override
  Future<AuthSession> register({
    required String email,
    required String otp,
    required String username,
    required String password,
    required String deviceName,
    required String platform,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/auth/register',
        data: {
          'email': email,
          'otp': otp,
          'username': username,
          'password': password,
          'deviceName': deviceName,
          'platform': platform,
        },
        options: Options(extra: {'skip_auth': true}),
      );
      return _persist(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      _throw(e);
    }
  }

  @override
  Future<LoginResult> login({
    required String email,
    required String password,
    required String deviceName,
    required String platform,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
          'deviceName': deviceName,
          'platform': platform,
        },
        options: Options(extra: {'skip_auth': true}),
      );
      final data = res.data as Map<String, dynamic>;
      if (data['twoFactorRequired'] == true) {
        return LoginTwoFactor(data['challengeToken'] as String);
      }
      return LoginSuccess(await _persist(data));
    } on DioException catch (e) {
      _throw(e);
    }
  }

  @override
  Future<AuthSession> verify2fa({
    required String challengeToken,
    required String totp,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/auth/login/2fa',
        data: {'challengeToken': challengeToken, 'totp': totp},
        options: Options(extra: {'skip_auth': true}),
      );
      return _persist(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      _throw(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post<dynamic>('/auth/logout');
    } on DioException catch (_) {
      // best-effort; clear locally regardless
    }
    await _store.clear();
  }

  @override
  Future<void> sendResetOtp(String email) async {
    try {
      await _dio.post<dynamic>(
        '/auth/password/send-reset-otp',
        data: {'email': email},
        options: Options(extra: {'skip_auth': true}),
      );
    } on DioException catch (e) {
      _throw(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _dio.post<dynamic>(
        '/auth/password/reset',
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
        options: Options(extra: {'skip_auth': true}),
      );
    } on DioException catch (e) {
      _throw(e);
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final store = ref.watch(tokenStoreProvider) as SecureStore;
  final dio = ref.watch(dioProvider(store));
  return AuthRepositoryImpl(dio, store);
}
