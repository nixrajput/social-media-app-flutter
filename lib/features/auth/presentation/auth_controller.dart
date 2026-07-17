import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/models/auth_state.dart';
import '../../../domain/models/login_result.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../services/secure_store.dart';

part 'auth_controller.g.dart';

const _defaultDeviceName = 'Mobile device';
String get _platform =>
    defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<AuthState> build() async {
    final store = ref.read(tokenStoreProvider);
    final access = await store.readAccess();
    // 'unknown' with a token means "resolve on first authed call"; the router
    // treats it as authenticated for navigation and lets 401s demote it.
    return access == null
        ? const AuthState.unauthenticated()
        : const AuthState.unknown();
  }

  Future<void> register({
    required String email,
    required String otp,
    required String username,
    required String password,
  }) async {
    final session = await _repo.register(
      email: email,
      otp: otp,
      username: username,
      password: password,
      deviceName: _defaultDeviceName,
      platform: _platform,
    );
    state = AsyncData(AuthState.authenticated(session));
  }

  Future<void> login({required String email, required String password}) async {
    final result = await _repo.login(
      email: email,
      password: password,
      deviceName: _defaultDeviceName,
      platform: _platform,
    );
    state = AsyncData(switch (result) {
      LoginSuccess(:final session) => AuthState.authenticated(session),
      LoginTwoFactor(:final challengeToken) => AuthState.twoFactorPending(
        challengeToken,
      ),
    });
  }

  Future<void> submit2fa(String totp) async {
    final current = state.value;
    if (current is! AuthTwoFactorPending) return;
    final session = await _repo.verify2fa(
      challengeToken: current.challengeToken,
      totp: totp,
    );
    state = AsyncData(AuthState.authenticated(session));
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(AuthState.unauthenticated());
  }
}
