import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/strings.dart';

const appThemeModes = {
  StringValues.system,
  StringValues.light,
  StringValues.dark,
};

class AppThemeController extends GetxController {
  final themeData = GetStorage();

  final _themeMode = Rx(appThemeModes.first);

  String get themeMode => _themeMode.value;

  @override
  void onInit() {
    themeData.writeIfNull(StringValues.themeMode, appThemeModes.first);
    getThemeMode();
    super.onInit();
  }

  void setThemeMode(value) {
    _themeMode(value);
    themeData.write(StringValues.themeMode, value);
    update();
  }

  void getThemeMode() {
    String themeMode = themeData.read(StringValues.themeMode);
    _themeMode(themeMode);
    update();
  }
}
