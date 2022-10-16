import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/apis/services/notification_service.dart';
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
    default:
      return 1;
  }
}

@pragma('vm:entry-point')
Future<void> initializeFirebaseService() async {
  await Firebase.initializeApp();

  var messaging = FirebaseMessaging.instance;

  var settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    AppUtility.printLog('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    AppUtility.printLog('User granted provisional permission');
  } else {
    AppUtility.printLog('User declined or has not accepted permission');
    return;
  }

  var fcmToken = await AppUtility.readFcmTokenFromLocalStorage();
  AppUtility.printLog('fcmToken: $fcmToken');
  var authServices = AuthService.find;

  if (fcmToken.isEmpty) {
    await messaging.deleteToken();
    var token = await messaging.getToken();
    AppUtility.printLog('fcmToken: $token');
    await AppUtility.saveFcmTokenToLocalStorage(token!);
  }

  messaging.onTokenRefresh.listen((newToken) async {
    AppUtility.printLog('fcmToken refreshed: $newToken');
    await AppUtility.saveFcmTokenToLocalStorage(newToken);
    if (authServices.token.isNotEmpty) {
      await authServices.saveFcmToken(newToken);
    }
  });

  var notificationService = NotificationService();

  if (!notificationService.isInitialized) {
    await notificationService.initialize();
  }

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AppUtility.printLog('Got a message whilst in the foreground!');
    AppUtility.printLog('Message data: ${message.data}');

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
      AppUtility.printLog(
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
    AppUtility.printLog(
        'Message also contained a notification: ${message.notification}');
  }
}
