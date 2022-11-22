import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/entities/follower.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/app_services/network_controller.dart';
import 'package:social_media_app/app_services/route_service.dart';
import 'package:social_media_app/app_services/theme_controller.dart';
import 'package:social_media_app/background_service/firebase_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/translations/app_translations.dart';
import 'package:social_media_app/utils/utility.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await _initPreAppServices();
    await checkAuthData();
  } catch (err) {
    AppUtility.log('Error in main: $err', tag: 'error');
    RouteService.set(RouteStatus.error);
  }
  runApp(const MyApp());
  if (NetworkController.find.networkStatus == true) {
    await Get.put(AppUpdateController(), permanent: true).init();
  }
}

Future<void> _initPreAppServices() async {
  await GetStorage.init();
  await Hive.initFlutter();

  AppUtility.log('Registering Hive Adapters');

  Hive.registerAdapter(AuthResponseAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(MediaFileAdapter());
  Hive.registerAdapter(PostMediaFileAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(PostResponseAdapter());
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(FollowerAdapter());
  Hive.registerAdapter(CommentAdapter());

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<Post>('posts');
  await Hive.openBox<Post>('trendingPosts');
  await Hive.openBox<User>('recommendedUsers');
  await Hive.openBox<ChatMessage>('lastMessages');
  await Hive.openBox<ChatMessage>('allMessages');
  await Hive.openBox<NotificationModel>('notifications');
  await Hive.openBox<Post>('profilePosts');
  await Hive.openBox<Follower>('followers');
  await Hive.openBox<Follower>('followings');
  await Hive.openBox<Comment>('comments');

  await initializeFirebaseService();

  Get.put(AppThemeController(), permanent: true);
  Get.put(ProfileController(), permanent: true);
}

Future<void> checkAuthData() async {
  var authService = AuthService.find;

  var network = NetworkController.find;

  if (network.networkStatus == false) {
    RouteService.set(RouteStatus.noNetwork);
    return;
  }

  var serverHealth = await authService.checkServerHealth();
  AppUtility.log("ServerHealth: $serverHealth");

  if (serverHealth == null) {
    RouteService.set(RouteStatus.error);
  } else {
    /// If [serverHealth] is `offline` or `maintenance`,
    /// then return
    if (serverHealth.toLowerCase() == "offline") {
      RouteService.set(RouteStatus.serverOffline);
      return;
    }

    if (serverHealth.toLowerCase() == "maintenance") {
      RouteService.set(RouteStatus.serverMaintenance);
      return;
    }
  }

  /// If [serverHealth] is `online`
  await authService.getToken().then((token) async {
    authService.autoLogout();
    if (token.isNotEmpty) {
      var tokenValid = await authService.validateToken(token);
      if (tokenValid) {
        var hasData = await ProfileController.find.loadProfileDetails();
        if (hasData) {
          RouteService.set(RouteStatus.loggedIn);
        } else {
          RouteService.set(RouteStatus.error);
          await StorageService.remove('profileData');
          return;
        }
      } else {
        RouteService.set(RouteStatus.notLoggedIn);
        await authService.deleteAllLocalDataAndCache();
      }
    }

    if (RouteService.routeStatus == RouteStatus.loggedIn) {
      AppUtility.log("User is logged in");
    }

    if (RouteService.routeStatus == RouteStatus.notLoggedIn) {
      AppUtility.log("User is not logged in", tag: 'error');
    }
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
          initialRoute: _handleAppInitialRoute(),
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
        ),
      ),
    );
  }

  String _handleAppInitialRoute() {
    switch (RouteService.routeStatus) {
      case RouteStatus.init:
      case RouteStatus.notLoggedIn:
        return AppRoutes.welcome;
      case RouteStatus.error:
        return AppRoutes.error;
      case RouteStatus.noNetwork:
        return AppRoutes.noNetwork;
      case RouteStatus.serverOffline:
        return AppRoutes.offline;
      case RouteStatus.serverMaintenance:
        return AppRoutes.maintenance;
      case RouteStatus.loggedIn:
        return AppRoutes.home;
      default:
        return AppRoutes.welcome;
    }
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
