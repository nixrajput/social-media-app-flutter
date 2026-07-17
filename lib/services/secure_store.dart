import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/api/token_store.dart';

part 'secure_store.g.dart';

class SecureStore implements TokenStore {
  const SecureStore([this._storage = const FlutterSecureStorage()]);
  final FlutterSecureStorage _storage;

  static const _kAccess = 'access';
  static const _kRefresh = 'refresh';
  static const _kDeviceId = 'device_id';

  @override
  Future<String?> readAccess() => _storage.read(key: _kAccess);

  @override
  Future<String?> readRefresh() => _storage.read(key: _kRefresh);

  @override
  Future<void> writeTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  Future<String?> readDeviceId() => _storage.read(key: _kDeviceId);
  Future<void> writeDeviceId(String id) =>
      _storage.write(key: _kDeviceId, value: id);

  @override
  Future<void> clear() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }
}

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => const SecureStore();
