import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/services/storage_service.dart';

class _FailingSecureStorage extends TestFlutterSecureStoragePlatform {
  _FailingSecureStorage({this.onlyKey}) : super({});

  final String? onlyKey;

  @override
  Future<void> write({
    required String key,
    required String value,
    required Map<String, String> options,
  }) {
    if (onlyKey == null || key == onlyKey) {
      throw PlatformException(code: 'KeyStoreException');
    }
    return super.write(key: key, value: value, options: options);
  }
}

const _fcmToken = 'dQw4w9WgXcQ:APA91bH_test-token';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory dir;

  // GetStorage keeps one instance per container, bound to its first path, so the
  // tests share one directory and erase it before each test.
  setUpAll(() async {
    dir = await Directory.systemTemp.createTemp('get_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => dir.path,
        );
    await GetStorage.init();
  });

  tearDownAll(() async {
    // GetStorage writes its .bak file without awaiting it. Let it land, or it
    // creates the deleted directory again.
    await GetStorage().save();
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await dir.delete(recursive: true);
  });

  setUp(() async {
    await GetStorage().erase();
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<void> saveLegacySecrets() async {
    await StorageService.write('loginData', {'token': 'abc', 'expiresAt': 9});
    await StorageService.write('fcmToken', base64Encode(_fcmToken.codeUnits));
  }

  Future<String?> readSecure(String key) =>
      const FlutterSecureStorage().read(key: key);

  test('moves a plaintext session into secure storage', () async {
    await StorageService.write('loginData', {'token': 'abc', 'expiresAt': 9});

    final data = await AuthService().readLoginDataFromLocalStorage();

    expect(data, {'token': 'abc', 'expiresAt': 9});
    expect(await StorageService.hasData('loginData'), isFalse);
    expect(await readSecure('loginData'), '{"token":"abc","expiresAt":9}');
  });

  test('moves a session saved as a JSON string before 1.0.1+24', () async {
    await StorageService.write('loginData', '{"token":"abc","expiresAt":9}');

    final data = await AuthService().readLoginDataFromLocalStorage();

    expect(data, {'token': 'abc', 'expiresAt': 9});
    expect(await StorageService.hasData('loginData'), isFalse);
  });

  test('moves a plaintext FCM token into secure storage', () async {
    await saveLegacySecrets();

    expect(await AuthService().readFcmTokenFromLocalStorage(), _fcmToken);
    expect(await StorageService.hasData('fcmToken'), isFalse);
    expect(await readSecure('fcmToken'), _fcmToken);
  });

  test('keeps the plaintext copies when secure writes fail', () async {
    await saveLegacySecrets();
    FlutterSecureStoragePlatform.instance = _FailingSecureStorage();
    final auth = AuthService();

    expect(await auth.getToken(), 'abc');
    expect(auth.isLoggedIn, isTrue);
    expect(await auth.readFcmTokenFromLocalStorage(), _fcmToken);
    expect(await StorageService.hasData('loginData'), isTrue);
    expect(await StorageService.hasData('fcmToken'), isTrue);
  });

  test('moves the session when only the FCM token write fails', () async {
    await saveLegacySecrets();
    FlutterSecureStoragePlatform.instance = _FailingSecureStorage(
      onlyKey: 'fcmToken',
    );
    final auth = AuthService();

    expect(await auth.getToken(), 'abc');
    expect(await StorageService.hasData('loginData'), isFalse);
    expect(await readSecure('loginData'), isNotNull);
    expect(await auth.readFcmTokenFromLocalStorage(), _fcmToken);
    expect(await StorageService.hasData('fcmToken'), isTrue);
  });

  test('saves new sessions only to secure storage', () async {
    await AuthService().saveLoginDataToLocalStorage('xyz', 5);

    expect(await StorageService.hasData('loginData'), isFalse);
    expect(await AuthService().readLoginDataFromLocalStorage(), {
      'token': 'xyz',
      'expiresAt': 5,
    });
  });
}
