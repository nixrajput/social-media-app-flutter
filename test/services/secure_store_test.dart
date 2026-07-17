import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/services/secure_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  test('writes and reads tokens, clears them', () async {
    const store = SecureStore();
    await store.writeTokens(access: 'a', refresh: 'r');
    expect(await store.readAccess(), 'a');
    expect(await store.readRefresh(), 'r');
    await store.clear();
    expect(await store.readAccess(), isNull);
  });
}
