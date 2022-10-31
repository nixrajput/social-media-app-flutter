import 'package:hive/hive.dart';
import 'package:social_media_app/utils/utility.dart';

abstract class HiveService {
  static Future<Box<E>> _openBox<E>(String boxName) async {
    // AppUtility.log('opening box [$boxName]');
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<E>(boxName);
    } else {
      return Hive.openBox<E>(boxName);
    }
  }

  static Future<bool> hasLength<E>(String boxName) async {
    final openBox = await _openBox<E>(boxName);
    var length = openBox.length;
    AppUtility.log('box [$boxName] length: $length');
    return length != 0;
  }

  static Future<void> add<E>(String boxName, E item) async {
    AppUtility.log('adding item [$item] to box [$boxName]');
    final box = await _openBox<E>(boxName);
    await box.add(item);
  }

  static Future<void> addAll<E>(String boxName, List<E> items) async {
    AppUtility.log('adding items [$items] to box [$boxName]');
    final box = await _openBox<E>(boxName);
    await box.addAll(items);
  }

  static Future<void> putAt<E>(String boxName, int index, E item) async {
    // AppUtility.log('putting item [$item] at index [$index] to box [$boxName]');
    final box = await _openBox<E>(boxName);
    await box.putAt(index, item);
  }

  static Future<void> put<E>(String boxName, dynamic key, E item) async {
    // AppUtility.log('putting item [$item] at key [$key] to box [$boxName]');
    final box = await _openBox<E>(boxName);
    await box.put(key, item);
  }

  static Future<E?> get<E>(String boxName, dynamic key) async {
    AppUtility.log('getting item at key [$key] from box [$boxName]');
    final box = await _openBox<E>(boxName);
    return box.get(key);
  }

  static Future<Map<String, dynamic>> getBox<E>(String boxName) async {
    AppUtility.log('getting box [$boxName]');
    final box = await _openBox<E>(boxName);
    return box.toMap() as Map<String, dynamic>;
  }

  static Future<List<E>?> getAll<E>(String boxName) async {
    AppUtility.log('getting all items from box [$boxName]');
    final box = await _openBox<E>(boxName);
    return box.values.toList();
  }

  static Future<void> delete<E>(String boxName, dynamic key) async {
    AppUtility.log('deleting item at key [$key] from box [$boxName]');
    final box = await _openBox<E>(boxName);
    var values = box.values.toList();
    if (values.isEmpty) return;
    await box.delete(key);
    AppUtility.log('item with key [$key] deleted from [$boxName]');
  }

  static Future<void> deleteAt<E>(String boxName, int index) async {
    AppUtility.log('deleting item at index [$index] from box [$boxName]');
    final box = await _openBox<E>(boxName);
    var values = box.values.toList();
    if (values.length > index) {
      await box.deleteAt(index);
    }
  }

  static Future<void> closeBox(String boxName) async {
    AppUtility.log('closing box [$boxName]');
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  static Future<void> deleteBox<E>(String boxName) async {
    AppUtility.log('deleting box [$boxName]');
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box<E>(boxName).deleteFromDisk();
      AppUtility.log('box [$boxName] deleted');
    }
  }

  static Future<void> deleteAllBoxes() async {
    AppUtility.log('deleting all boxes');
    await Hive.deleteFromDisk();
  }
}
