import 'package:hive/hive.dart';
import 'package:social_media_app/utils/utility.dart';

class HiveService {
  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    var length = openBox.length;
    if (length != 0) {
      AppUtility.printLog('box [$boxName] exists');
    } else {
      AppUtility.printLog('box [$boxName] does not exists');
    }
    return length != 0;
  }

  Future<void> addBox<T>(
    String boxName,
    T items,
  ) async {
    AppUtility.printLog('adding box: $boxName');
    final openBox = await Hive.openBox(boxName);
    await openBox.put('data', items);
  }

  Future<void> clearBox<T>(String boxName) async {
    AppUtility.printLog('deleting box: $boxName');
    await Hive.deleteBoxFromDisk(boxName);
  }

  Future<String> getBox(String boxName) async {
    AppUtility.printLog('reading box: $boxName');
    final openBox = await Hive.openBox(boxName);
    return openBox.get('data');
  }
}
