import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/secret_key.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/apis/services/notification_service.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/background_service/firebase_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';
import 'package:social_media_app/translations/app_translations.dart';
import 'package:social_media_app/utils/utility.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initPreAppServices();
    await checkAuthData();
    runApp(const MyApp());
    await Get.put(AppUpdateController(), permanent: true).init();
  } catch (err) {
    AppUtility.printLog(err);
  }
}

Future<void> initPreAppServices() async {
  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(MediaFileAdapter());
  Hive.registerAdapter(PostMediaFileAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostResponseAdapter());
  Hive.registerAdapter(SecretKeyAdapter());
  Hive.registerAdapter(ServerKeyAdapter());

  Get.put(AuthService(), permanent: true);
  await NotificationService().initialize();
  await initializeFirebaseService();

  Get.put(AppThemeController(), permanent: true);
  Get.put(ProfileController(), permanent: true);
  Get.put(LoginDeviceInfoController(), permanent: true);
}

bool isLogin = false;
String serverHealth = "offline";

Future<void> checkAuthData() async {
  serverHealth = await AuthService.find.checkServerHealth();
  AppUtility.printLog("ServerHealth: $serverHealth");

  /// If [serverHealth] is `offline` or `maintenance`,
  /// then return
  if (serverHealth.toLowerCase() == "offline" ||
      serverHealth.toLowerCase() == "maintenance") {
    return;
  }
  await AuthService.find.getToken().then((token) async {
    AuthService.find.autoLogout();
    if (token.isNotEmpty) {
      var tokenValid = await AuthService.find.validateToken(token);
      if (tokenValid) {
        var hasData = await ProfileController.find.loadProfileDetails();
        if (hasData) {
          isLogin = true;
        } else {
          await AppUtility.clearLoginDataFromLocalStorage();
        }
      } else {
        await AppUtility.clearLoginDataFromLocalStorage();
      }
    }
    isLogin
        ? AppUtility.printLog("User is logged in")
        : AppUtility.printLog("User is not logged in");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
        builder: (_, __) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          getPages: AppPages.pages,
          initialRoute: serverHealth.toLowerCase() == "maintenance"
              ? AppRoutes.maintenance
              : isLogin
                  ? AppRoutes.home
                  : AppRoutes.welcome,
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
        ),
      ),
    );
  }

  ThemeMode _handleAppTheme(AppThemeModes mode) {
    if (mode == AppThemeModes.dark) {
      return ThemeMode.dark;
    }
    if (mode == AppThemeModes.light) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
