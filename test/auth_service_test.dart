import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final dir = await Directory.systemTemp.createTemp('get_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => dir.path,
        );
    await GetStorage.init();
  });

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('moves a plaintext session into secure storage', () async {
    await StorageService.write('loginData', {'token': 'abc', 'expiresAt': 9});

    final data = await AuthService().readLoginDataFromLocalStorage();

    expect(data, {'token': 'abc', 'expiresAt': 9});
    expect(await StorageService.hasData('loginData'), isFalse);
    expect(
      await const FlutterSecureStorage().read(key: 'loginData'),
      '{"token":"abc","expiresAt":9}',
    );
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
