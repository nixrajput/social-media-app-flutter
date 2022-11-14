import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/app_services/notification_service.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/utils/utility.dart';

@pragma('vm:entry-point')
int setNotificationId(String type) {
  switch (type) {
    case 'Chats':
      return 2;
    case 'Followers':
      return 3;
    case 'Likes':
      return 4;
    case 'Comments':
      return 5;
    case 'Follow Requests':
      return 6;
    case 'General Notifications':
      return 7;
    default:
      return 1;
  }
}

@pragma('vm:entry-point')
Future<void> initializeFirebaseService() async {
  await Firebase.initializeApp();
  Get.put(AuthService(), permanent: true);

  var messaging = FirebaseMessaging.instance;

  var settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    AppUtility.log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    AppUtility.log('User granted provisional permission');
  } else {
    AppUtility.log('User declined or has not accepted permission',
        tag: 'warning');
    return;
  }

  var notificationService = NotificationService();

  if (!notificationService.isInitialized) {
    await notificationService.initialize();
  }

  var authService = AuthService.find;

  await authService.getToken().then((token) async {
    authService.autoLogout();

    if (token.isEmpty) {
      return;
    }

    var tokenValid = await authService.validateToken(token);
    if (!tokenValid) {
      notificationService.showNotification(
        title: 'Invalid Token',
        body: 'Token is invalid. Please login again.',
        priority: true,
        id: setNotificationId('General Notifications'),
        channelId: 'General Notifications',
        channelName: 'General notifications',
      );
      return;
    }
  });

  if (authService.isLogin) {
    var fcmToken = await authService.readFcmTokenFromLocalStorage();
    AppUtility.log('fcmToken: $fcmToken');

    if (fcmToken.isEmpty) {
      await messaging.deleteToken();
      var token = await messaging.getToken();
      AppUtility.log('fcmToken: $token');
      await authService.saveFcmTokenToLocalStorage(token!);
    }

    messaging.onTokenRefresh.listen((newToken) async {
      AppUtility.log('fcmToken refreshed: $newToken');
      await authService.saveFcmTokenToLocalStorage(newToken);
      if (authService.token.isNotEmpty) {
        await authService.saveFcmToken(newToken);
      }
    });
  } else {
    await StorageService.remove("fcmToken");
    await messaging.deleteToken();
  }

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AppUtility.log('Got a message whilst in the foreground!');
    AppUtility.log('Message data: ${message.data}');

    if (message.data.isNotEmpty) {
      var messageData = message.data;

      var title = messageData['title'];
      var body = messageData['body'];
      var imageUrl = messageData['image'];
      var type = messageData['type'];

      notificationService.showNotification(
        title: title ?? '',
        body: body ?? '',
        priority: true,
        id: setNotificationId(type),
        largeIcon: imageUrl,
        channelId: type ?? 'General Notifications',
        channelName: type ?? 'General notifications',
      );
    }

    if (message.notification != null) {
      AppUtility.log(
          'Message also contained a notification: ${message.notification}');
    }
  });
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Handling a background message");
  debugPrint('Message data: ${message.data}');

  var notificationService = NotificationService();

  if (!notificationService.isInitialized) {
    await notificationService.initialize();
  }

  if (message.data.isNotEmpty) {
    var messageData = message.data;

    var title = messageData['title'];
    var body = messageData['body'];
    var imageUrl = messageData['image'];
    var type = messageData['type'];

    notificationService.showNotification(
      title: title ?? '',
      body: body ?? '',
      priority: true,
      id: setNotificationId(type),
      largeIcon: imageUrl,
      channelId: type ?? 'General Notifications',
      channelName: type ?? 'General notifications',
    );
  }

  if (message.notification != null) {
    AppUtility.log(
        'Message also contained a notification: ${message.notification}');
  }
}
