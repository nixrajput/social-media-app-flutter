import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

enum AppThemeModes {
  system,
  light,
  dark,
}

class AppThemeController extends GetxController {
  static AppThemeController get find => Get.find();
  final themeData = GetStorage();

  final _themeMode = Rx(AppThemeModes.system);

  AppThemeModes get themeMode => _themeMode.value;

  @override
  void onInit() {
    themeData.writeIfNull(StringValues.themeMode, 'system');
    getThemeMode();
    super.onInit();
  }

  void setThemeMode(AppThemeModes value) {
    _themeMode(value);
    if (value == AppThemeModes.light) {
      themeData.write(StringValues.themeMode, 'light');
    } else if (value == AppThemeModes.dark) {
      themeData.write(StringValues.themeMode, 'dark');
    } else {
      themeData.write(StringValues.themeMode, 'system');
    }
    AppUtils.printLog('changed to ${_themeMode.value}');
    update();
  }

  void getThemeMode() async {
    String themeMode = await themeData.read(StringValues.themeMode);
    AppUtils.printLog('saved theme mode = $themeMode');
    if (themeMode == 'light') {
      _themeMode(AppThemeModes.light);
    } else if (themeMode == 'dark') {
      _themeMode(AppThemeModes.dark);
    } else {
      _themeMode(AppThemeModes.system);
    }
    AppUtils.printLog(_themeMode.value);
    update();
  }
}
