import '../models/auth_session.dart';
import '../models/login_result.dart';
import '../models/oauth_result.dart';

abstract interface class AuthRepository {
  Future<void> sendRegisterOtp(String email);
  Future<AuthSession> register({
    required String email,
    required String otp,
    required String username,
    required String password,
    required String deviceName,
    required String platform,
  });
  Future<LoginResult> login({
    required String email,
    required String password,
    required String deviceName,
    required String platform,
  });
  Future<AuthSession> verify2fa({
    required String challengeToken,
    required String totp,
  });
  Future<OAuthResult> oauthLogin({
    required String provider,
    required String idToken,
    required String deviceName,
    required String platform,
  });
  Future<void> updateProfile({required String displayName, String? bio});
  Future<void> logout();
  Future<void> sendResetOtp(String email);
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
