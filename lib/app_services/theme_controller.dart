import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/strings.dart';

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
    super.onInit();
    getThemeMode();
  }

  void setThemeMode(AppThemeModes mode) {
    _themeMode.value = mode;
    themeData.write(StringValues.themeMode, mode.toString().split('.').last);
    update();
  }

  void getThemeMode() {
    final themeMode = themeData.read(StringValues.themeMode);
    switch (themeMode) {
      case 'system':
        _themeMode.value = AppThemeModes.system;
        update();
        break;
      case 'light':
        _themeMode.value = AppThemeModes.light;
        update();
        break;
      case 'dark':
        _themeMode.value = AppThemeModes.dark;
        update();
        break;
      default:
        _themeMode.value = AppThemeModes.system;
        update();
        break;
    }
  }
}
