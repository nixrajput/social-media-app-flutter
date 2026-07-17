abstract final class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.rippl.dev/api/v1',
  );
}

abstract final class OAuthConfig {
  // Google web client ID used as the ID-token audience the backend verifies.
  // Empty in dev/tests; supplied per build. iOS also reads its client ID from
  // the native config (Info.plist / GoogleService-Info.plist).
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
}
