import 'package:hive/hive.dart';
import 'package:social_media_app/utils/utility.dart';

abstract class HiveService {
  static Future<Box<E>> _openBox<E>(String boxName) async {
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
    final box = await _openBox<E>(boxName);
    await box.add(item);
  }

  static Future<void> addAll<E>(String boxName, List<E> items) async {
    final box = await _openBox<E>(boxName);
    await box.addAll(items);
  }

  static Future<void> putAt<E>(String boxName, int index, E item) async {
    final box = await _openBox<E>(boxName);
    await box.putAt(index, item);
  }

  static Future<void> put<E>(String boxName, dynamic key, E item) async {
    final box = await _openBox<E>(boxName);
    await box.put(key, item);
  }

  static Future<E?> get<E>(String boxName, dynamic key) async {
    final box = await _openBox<E>(boxName);
    return box.get(key);
  }

  static Future<E?> find<E>(String boxName, dynamic key) async {
    final box = await _openBox<E>(boxName);

    return box.get(key);
  }

  static Future<Map<dynamic, E>> getBox<E>(String boxName) async {
    final box = await _openBox<E>(boxName);
    return box.toMap();
  }

  static Future<List<E>> getAll<E>(String boxName) async {
    AppUtility.log('Getting all from box: $boxName');
    final box = await _openBox<E>(boxName);
    AppUtility.log('Got all from box: $boxName');
    return box.values.toList();
  }

  static Future<void> delete<E>(String boxName, dynamic key) async {
    AppUtility.log('Deleting key: $key from box: $boxName');
    final box = await _openBox<E>(boxName);
    var values = box.values.toList();
    if (values.isEmpty) return;
    await box.delete(key);
    AppUtility.log('Deleted key: $key from box: $boxName');
  }

  static Future<void> deleteAt<E>(String boxName, int index) async {
    AppUtility.log('Deleting at index: $index from box: $boxName');
    final box = await _openBox<E>(boxName);
    var values = box.values.toList();
    if (values.length > index) {
      await box.deleteAt(index);
      AppUtility.log('Deleted at index: $index from box: $boxName');
    }
  }

  static Future<void> closeBox(String boxName) async {
    AppUtility.log('Closing Box: $boxName');
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
      AppUtility.log('Box Closed: $boxName');
    }
  }

  static Future<void> deleteBox<E>(String boxName) async {
    AppUtility.log('Deleting Box: $boxName');
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box<E>(boxName).deleteFromDisk();
      AppUtility.log('Box Deleted: $boxName');
    }
  }

  static Future<void> deleteAllBoxes() async {
    AppUtility.log('Deleting All Boxes');
    await Hive.deleteFromDisk();
    AppUtility.log('All Boxes Deleted');
  }
}
