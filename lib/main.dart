import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/app_pages.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initServices();
    runApp(const MyApp());
  } catch (err) {
    AppUtils.printLog(err);
  }
}

Future<void> initServices() async {
  await GetStorage.init();
  Get
    ..put(AppThemeController(), permanent: true)
    ..put(AuthController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance!.window.platformBrightness ==
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
    }

    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: () => NxOverlayWidget(
          child: GetMaterialApp(
            title: StringValues.appName,
            debugShowCheckedModeBanner: false,
            themeMode: logic.themeMode == StringValues.system
                ? ThemeMode.system
                : logic.themeMode == StringValues.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            getPages: AppPages.pages,
            initialRoute: AppRoutes.splash,
          ),
        ),
      ),
    );
  }
}
