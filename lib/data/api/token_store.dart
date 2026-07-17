abstract interface class TokenStore {
  Future<String?> readAccess();
  Future<String?> readRefresh();
  Future<void> writeTokens({required String access, required String refresh});
  Future<void> clear();
}
