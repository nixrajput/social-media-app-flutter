import 'auth_session.dart';

sealed class LoginResult {
  const LoginResult();
}

class LoginSuccess extends LoginResult {
  const LoginSuccess(this.session);
  final AuthSession session;
}

class LoginTwoFactor extends LoginResult {
  const LoginTwoFactor(this.challengeToken);
  final String challengeToken;
}
