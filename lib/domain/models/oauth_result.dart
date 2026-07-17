import 'auth_session.dart';

class OAuthResult {
  const OAuthResult({required this.session, required this.needsProfile});
  final AuthSession session;
  final bool needsProfile;
}
