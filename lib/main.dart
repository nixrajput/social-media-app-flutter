import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:social_media_app/apis/models/entities/poll_option.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/app_services/firebase_service.dart';
import 'package:social_media_app/app_services/network_controller.dart';
import 'package:social_media_app/app_services/route_service.dart';
import 'package:social_media_app/app_services/theme_controller.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/translations/app_translations.dart';
import 'package:social_media_app/utils/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initPreAppServices();
  final networkService = NetworkController.instance;
  await networkService.init();

  runApplication();

  await initializeFirebaseService();
  await _initPostAppServices();
}

void runApplication() {
  AppUtility.log('Initializing App');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  AppUtility.log('App Initialized');
}

Future<void> _initPostAppServices() async {
  final networkService = NetworkController.instance;
  if (networkService.isConnected == true) {
    await validateSessionAndGetData();
    await AppUpdateController.find.init();
  }
}

Future<void> _initPreAppServices() async {
  AppUtility.log('Initializing PreApp Services');
  await GetStorage.init();
  await Hive.initFlutter();

  AppUtility.log('Registering Hive Adapters');

  Hive.registerAdapter(AuthResponseAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(PollOptionAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(MediaFileAdapter());
  Hive.registerAdapter(PostMediaFileAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(PostResponseAdapter());
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(FollowerAdapter());
  Hive.registerAdapter(CommentAdapter());

  AppUtility.log('Hive Adapters Registered');

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<String>('themeMode');
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Post>('trendingPosts');
  await Hive.openBox<User>('recommendedUsers');
  await Hive.openBox<ChatMessage>('lastMessages');
  await Hive.openBox<NotificationModel>('notifications');
  await Hive.openBox<Post>('profilePosts');
  await Hive.openBox<Follower>('followers');
  await Hive.openBox<Follower>('followings');

  AppUtility.log('Hive Boxes Opened');

  AppUtility.log('Initializing Get Services');

  Get.put(AppThemeController(), permanent: true);
  Get.put(AuthService(), permanent: true);
  Get.put(ProfileController(), permanent: true);
  Get.put(FollowRequestController(), permanent: true);
  Get.put(NotificationController(), permanent: true);
  Get.put(ChatController(), permanent: true);
  Get.put(AppUpdateController(), permanent: true);
  Get.put(PostController(), permanent: true);

  AppUtility.log('Get Services Initialized');

  AppUtility.log('Checking Token');

  var authService = AuthService.find;

  await authService.getToken().then((token) async {
    if (token.isNotEmpty) {
      var isValid = await authService.validateLocalAuthToken();

      if (isValid == false) {
        await authService.deleteAllLocalDataAndCache();
        RouteService.set(RouteStatus.notLoggedIn);
      }

      var hasData = await ProfileController.find.loadProfileDetails();
      if (hasData) {
        await PostController.find.loadLocalPosts();
        await ChatController.find.loadLocalMessages();
        await NotificationController.find.loadLocalNotification();
        RouteService.set(RouteStatus.loggedIn);
        AppUtility.log("User is logged in");
      } else {
        RouteService.set(RouteStatus.error);
        await StorageService.remove('profileData');
      }
    } else {
      RouteService.set(RouteStatus.notLoggedIn);
      AppUtility.log("User is not logged in", tag: 'error');
    }
  });

  AppUtility.log('Token Checked');

  AppUtility.log('PreApp Services Initialized');
}

Future<void> validateSessionAndGetData() async {
  AppUtility.log('Validating Session and Getting Data');
  var authService = AuthService.find;

  var networkService = NetworkController.instance;

  if (networkService.isConnected == false) {
    RouteManagement.goToNetworkErrorView();
    return;
  }

  var serverHealth = await authService.checkServerHealth();
  AppUtility.log("ServerHealth: $serverHealth");

  if (serverHealth == null) {
    RouteService.set(RouteStatus.error);
  } else {
    if (serverHealth.toLowerCase() == "offline") {
      RouteManagement.goToServerOfflineView();
      return;
    }

    if (serverHealth.toLowerCase() == "maintenance") {
      RouteManagement.goToServerMaintenanceView();
      return;
    }
  }

  var token = authService.token;

  if (token.isEmpty) {
    RouteManagement.goToWelcomeView();
    return;
  }

  var tokenValid = await authService.validateToken(token);

  if (tokenValid == null) {
    RouteManagement.gotToErrorView();
    return;
  }

  if (tokenValid == false) {
    await authService.deleteAllLocalDataAndCache();
    RouteManagement.goToWelcomeView();
    return;
  }

  if (tokenValid == true) {
    await PostController.find.getData();
  }

  AppUtility.log('Session Validated and Data Fetched');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: (ctx, child) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: logic.getLightThemeData(),
          darkTheme: logic.getDarkThemeData(),
          getPages: AppPages.pages,
          initialRoute: _handleAppInitialRoute(),
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'IN'),
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

  ThemeMode _handleAppTheme(String mode) {
    if (mode == kDarkMode) {
      return ThemeMode.dark;
    }
    if (mode == kLightMode) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
