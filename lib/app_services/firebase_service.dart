import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/app_services/notification_service.dart';
import 'package:social_media_app/utils/utility.dart';

@pragma('vm:entry-point')
Future<void> initializeFirebaseService() async {
  AppUtility.log('Initializing Firebase Service');

  await Firebase.initializeApp();

  var messaging = FirebaseMessaging.instance;

  await messaging.setAutoInitEnabled(true);

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

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  FirebaseMessaging.onMessage.listen(onMessage);

  // var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  // if (initialMessage != null) {
  //   _handleMessage(initialMessage);
  // }
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  AppUtility.log('Firebase Service Initialized');

  // if (!notificationService.isInitialized) {
  //   await notificationService.initialize();
  // }
  //
  // var authService = AuthService.find;
  //
  // if (_networkService.isConnected == true) {
  //   await authService.getToken().then((token) async {
  //     if (token.isEmpty) {
  //       return;
  //     }
  //
  //     var isValid = await authService.validateLocalAuthToken();
  //
  //     if (isValid == false) {
  //       return;
  //     }
  //
  //     var tokenValid = await authService.validateToken(token);
  //     if (tokenValid == null) {
  //       return;
  //     } else {
  //       if (tokenValid == false) {
  //         notificationService.showNotification(
  //           title: 'Invalid Token',
  //           body: 'Token is invalid. Please login again.',
  //           priority: setNotificationPriority('General Notifications'),
  //           isImportant: setNotificationImportance('General Notifications'),
  //           id: setNotificationId('General Notifications'),
  //           channelId: 'General Notifications',
  //           channelName: 'General notifications',
  //         );
  //         return;
  //       }
  //     }
  //   });
  //
  //   if (authService.isLoggedIn) {
  //     var fcmToken = await authService.readFcmTokenFromLocalStorage();
  //     AppUtility.log('fcmToken: $fcmToken');
  //
  //     if (fcmToken.isEmpty) {
  //       await messaging.deleteToken();
  //       var token = await messaging.getToken();
  //       AppUtility.log('fcmToken: $token');
  //       await authService.saveFcmTokenToLocalStorage(token!);
  //       if (authService.token.isNotEmpty) {
  //         await authService.saveFcmToken(token);
  //       }
  //     }
  //
  //     messaging.onTokenRefresh.listen((newToken) async {
  //       AppUtility.log('fcmToken refreshed: $newToken');
  //       await authService.saveFcmTokenToLocalStorage(newToken);
  //       if (authService.token.isNotEmpty) {
  //         await authService.saveFcmToken(newToken);
  //       }
  //     });
  //   } else {
  //     await StorageService.remove("fcmToken");
  //     await messaging.deleteToken();
  //   }
  // }
}

// @pragma('vm:entry-point')
// void _handleMessage(RemoteMessage message) {
//   if (message.data['type'] == 'Chats') {
//     RouteManagement.goToChatDetailsView(
//       User(
//         id: isMe ? item.receiverId! : item.senderId!,
//         fname: isMe ? item.receiver!.fname : item.sender!.fname,
//         lname: isMe ? item.receiver!.lname : item.sender!.lname,
//         email: isMe ? item.receiver!.email : item.sender!.email,
//         uname: isMe ? item.receiver!.uname : item.sender!.uname,
//         avatar: isMe ? item.receiver!.avatar : item.sender!.avatar,
//         isPrivate: isMe ? item.receiver!.isPrivate : item.sender!.isPrivate,
//         followingStatus: isMe
//             ? item.receiver!.followingStatus
//             : item.sender!.followingStatus,
//         accountStatus:
//             isMe ? item.receiver!.accountStatus : item.sender!.accountStatus,
//         isVerified: isMe ? item.receiver!.isVerified : item.sender!.isVerified,
//         createdAt: isMe ? item.receiver!.createdAt : item.sender!.createdAt,
//         updatedAt: isMe ? item.receiver!.updatedAt : item.sender!.updatedAt,
//       ),
//     );
//     Navigator.pushNamed(
//       context,
//       '/chat',
//       arguments: ChatArguments(message),
//     );
//   }
// }

@pragma('vm:entry-point')
bool setNotificationPlaySound(String type) {
  switch (type) {
    case 'Chats':
      return true;
    case 'General Notifications':
      return true;
    case 'Comments':
      return false;
    case 'Follow Requests':
      return false;
    case 'Followers':
      return false;
    case 'Likes':
      return false;
    default:
      return false;
  }
}

@pragma('vm:entry-point')
void showNotificationByCategory(
    String type, String title, String body, String? imageUrl) async {
  final notificationService = NotificationService();

  if (!notificationService.isInitialized) {
    await notificationService.initialize();
  }

  switch (type) {
    case 'Chats':
      await notificationService.showNotification(
        title: title,
        body: body,
        largeIcon: imageUrl,
        channelId: 'Chats',
        channelName: 'Chats',
        id: 2,
      );
      break;
    case 'Followers':
      await notificationService.showNotificationWithNoSound(
        title: title,
        body: body,
        largeIcon: imageUrl,
        channelId: 'Followers',
        channelName: 'Followers',
        id: 3,
        enableVibration: false,
      );
      break;
    case 'Likes':
      await notificationService.showBigPictureNotificationWithNoSound(
        title: title,
        body: body,
        bigPictureUrl: imageUrl ?? '',
        channelId: 'Likes',
        channelName: 'Likes',
        id: 4,
        enableVibration: false,
      );
      break;
    case 'Comments':
      await notificationService.showBigPictureNotification(
        title: title,
        body: body,
        bigPictureUrl: imageUrl ?? '',
        channelId: 'Comments',
        channelName: 'Comments',
        id: 5,
      );
      break;
    case 'Follow Requests':
      await notificationService.showNotificationWithNoSound(
        title: title,
        body: body,
        largeIcon: imageUrl,
        channelId: 'Follow Requests',
        channelName: 'Follow Requests',
        id: 6,
        enableVibration: true,
      );
      break;
    default:
      await notificationService.showNotification(
        title: title,
        body: body,
        largeIcon: imageUrl,
        channelId: 'General Notifications',
        channelName: 'General Notifications',
        id: 1,
      );
      break;
  }
}

@pragma('vm:entry-point')
Future<void> onMessage(RemoteMessage message) async {
  AppUtility.log('Got a message whilst in the foreground!');
  AppUtility.log('Message data: ${message.data}');

  if (message.data.isNotEmpty) {
    var messageData = message.data;

    var title = messageData['title'] ?? '';
    var body = messageData['body'] ?? '';
    var imageUrl = messageData['image'] ?? '';
    var type = messageData['type'];

    showNotificationByCategory(type, title, body, imageUrl);
  }

  if (message.notification != null) {
    AppUtility.log(
        'Message also contained a notification: ${message.notification}');
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Handling a background message");
  debugPrint('Message data: ${message.data}');

  if (message.data.isNotEmpty) {
    var messageData = message.data;

    var title = messageData['title'] ?? '';
    var body = messageData['body'] ?? '';
    var imageUrl = messageData['image'] ?? '';
    var type = messageData['type'];

    showNotificationByCategory(type, title, body, imageUrl);
  }

  if (message.notification != null) {
    AppUtility.log(
        'Message also contained a notification: ${message.notification}');
  }
}
