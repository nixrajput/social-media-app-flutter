import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';
import 'package:social_media_app/translations/app_translations.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initServices();
    runApp(const MyApp());
    await AppUpdateController.find.checkAppUpdate(
      showLoading: false,
      showAlert: false,
    );
  } catch (err) {
    AppUtils.printLog(err);
  }
}

bool isLogin = false;

Future<void> initServices() async {
  await GetStorage.init();
  Get
    ..put(AppThemeController(), permanent: true)
    ..put(AuthService(), permanent: true)
    ..put(ProfileController(), permanent: true)
    ..put(LoginDeviceInfoController(), permanent: true)
    ..put(AppUpdateController(), permanent: true);

  await Get.find<AuthService>().getToken().then((value) async {
    Get.find<AuthService>().autoLogout();
    if (value.isNotEmpty) {
      var tokenValid = await Get.find<AuthService>().validateToken(value);

      if (tokenValid) {
        var hasData = await Get.find<ProfileController>().loadProfileDetails();
        if (hasData) {
          isLogin = true;
        }
      }
    }
    isLogin
        ? AppUtils.printLog("User is logged in.")
        : AppUtils.printLog("User is not logged in.");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorValues.lightBgColor,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: ColorValues.lightBgColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
      //AppThemeController.find.setThemeMode(AppThemeModes.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: ColorValues.darkBgColor,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: ColorValues.darkBgColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
      //AppThemeController.find.setThemeMode(AppThemeModes.dark);
    }

    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: (_, __) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          getPages: AppPages.pages,
          initialRoute: isLogin ? AppRoutes.home : AppRoutes.welcome,
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
        ),
      ),
    );
  }

  _handleAppTheme(AppThemeModes mode) {
    if (mode == AppThemeModes.dark) {
      return ThemeMode.dark;
    }
    if (mode == AppThemeModes.light) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
