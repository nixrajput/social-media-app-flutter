import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/utils/utility.dart';

abstract class StorageService {
  static final _storage = GetStorage();

  static Future<bool> hasData(String key) async {
    return _storage.hasData(key);
  }

  static dynamic read(String key) {
    return _storage.read(key);
  }

  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  static Future<void> remove(String key) async {
    AppUtility.log('Removing $key from local storage');
    await _storage.remove(key);
  }

  static Future<void> erase() async {
    await _storage.erase();
  }
}
