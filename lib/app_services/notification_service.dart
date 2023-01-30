import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/utils/utility.dart';

class NotificationService {
  final _androidInitSettings =
      const AndroidInitializationSettings('@mipmap/launcher_icon');

  bool _initialized = false;
  final _iosInitSettings = const DarwinInitializationSettings();
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    AppUtility.log('Initializing Notification Service');
    if (!_initialized) {
      final initializationSettings = InitializationSettings(
        iOS: _iosInitSettings,
        android: _androidInitSettings,
      );
      await _notificationPlugin.initialize(initializationSettings);
      _initialized = true;
    }
    AppUtility.log('Notification Service Initialized');
  }

  /// Show Heads Up Notification
  Future<void> showNotification({
    String? title,
    required String body,
    int? id,
    String? channelId,
    String? channelName,
    String? largeIcon,
    String? groupKey,
  }) async {
    ByteArrayAndroidBitmap? androidBitmap;
    if (largeIcon != null) {
      var bodyBytes = await _getImageBytes(largeIcon);
      androidBitmap = ByteArrayAndroidBitmap.fromBase64String(bodyBytes);
    }
    var androidNot = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      groupKey: groupKey,
      priority: Priority.max,
      importance: Importance.max,
      enableLights: true,
      largeIcon: androidBitmap != null ? androidBitmap : null,
    );

    var iosNot = const DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.active,
    );

    final platformNot = NotificationDetails(
      android: androidNot,
      iOS: iosNot,
    );

    await _notificationPlugin.show(
      id ?? 0,
      title,
      body,
      platformNot,
      payload: 'Default_Sound',
    );
  }

  /// Show Big Picture Notification
  Future<void> showBigPictureNotification({
    String? title,
    String? body,
    required String bigPictureUrl,
    int? id,
    String? groupKey,
    String? channelId,
    String? channelName,
    String? largeIconUrl,
  }) async {
    final largeIconByteString =
        largeIconUrl != null ? await _getImageBytes(largeIconUrl) : null;
    final bigPictureByteString = await _getImageBytes(bigPictureUrl);

    final largeIcon = largeIconByteString != null
        ? ByteArrayAndroidBitmap.fromBase64String(largeIconByteString)
        : null;

    final bigPictureStyleInformation = BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(bigPictureByteString),
      largeIcon: largeIcon,
      contentTitle: title ?? '',
      htmlFormatContentTitle: true,
      summaryText: body ?? '',
      htmlFormatSummaryText: true,
    );

    final androidNotificationDetails = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      groupKey: groupKey,
      priority: Priority.max,
      importance: Importance.max,
      enableLights: true,
      styleInformation: bigPictureStyleInformation,
    );

    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationPlugin.show(
      id ?? 0,
      null,
      null,
      notificationDetails,
    );
  }

  /// Show Big Picture Notification
  Future<void> showBigPictureNotificationWithNoSound({
    String? title,
    String? body,
    required String bigPictureUrl,
    int? id,
    String? groupKey,
    String? channelId,
    String? channelName,
    String? largeIconUrl,
    bool? enableVibration,
  }) async {
    final largeIconByteString =
        largeIconUrl != null ? await _getImageBytes(largeIconUrl) : null;
    final bigPictureByteString = await _getImageBytes(bigPictureUrl);

    final largeIcon = largeIconByteString != null
        ? ByteArrayAndroidBitmap.fromBase64String(largeIconByteString)
        : null;

    final bigPictureStyleInformation = BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(bigPictureByteString),
      largeIcon: largeIcon,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    final androidNotificationDetails = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      groupKey: groupKey,
      playSound: false,
      enableVibration: enableVibration ?? true,
      styleInformation: bigPictureStyleInformation,
    );

    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationPlugin.show(
      id ?? 0,
      null,
      null,
      notificationDetails,
    );
  }

  /// Show Notification With No Sound
  Future<void> showNotificationWithNoSound({
    String? title,
    required String body,
    int? id,
    String? channelId,
    String? channelName,
    String? largeIcon,
    String? groupKey,
    bool? enableVibration,
  }) async {
    ByteArrayAndroidBitmap? androidBitmap;

    if (largeIcon != null) {
      var bodyBytes = await _getImageBytes(largeIcon);
      androidBitmap = ByteArrayAndroidBitmap.fromBase64String(bodyBytes);
    }

    var androidNot = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      groupKey: groupKey,
      playSound: false,
      enableVibration: enableVibration ?? true,
      largeIcon: androidBitmap != null ? androidBitmap : null,
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iosNot = const DarwinNotificationDetails(
      presentSound: false,
    );

    final platformNot = NotificationDetails(
      android: androidNot,
      iOS: iosNot,
    );

    await _notificationPlugin.show(
      id ?? 0,
      title,
      body,
      platformNot,
    );
  }

  /// Show Messaging Notification
  Future<void> showMessagingNotification(String imageUrl) async {
    var imgByteString = await _getImageBytes(imageUrl);

    final me = Person(
      name: 'Me',
      key: '1',
      uri: 'tel:1234567890',
      icon: ByteArrayAndroidIcon.fromBase64String(imgByteString),
    );

    final coworker = Person(
      name: 'Coworker',
      key: '2',
      uri: 'tel:8302364750',
      icon: ByteArrayAndroidIcon.fromBase64String(imgByteString),
    );

    // download the icon that would be use for the lunch bot person
    // final String largeIconPath =
    //     await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');

    // this person object will use an icon that was downloaded
    final lunchBot = Person(
      name: 'Lunch bot',
      key: 'bot',
      bot: true,
      icon: ByteArrayAndroidIcon.fromBase64String(imgByteString),
      // icon: FlutterBitmapAssetAndroidIcon('images/avatar.png'),
    );

    final chef = Person(
      name: 'Master Chef',
      key: '3',
      uri: 'tel:111222333444',
      // icon: ByteArrayAndroidIcon.fromBase64String(
      //     await _base64encodedImage('https://placekitten.com/48/48')),
      icon: ByteArrayAndroidIcon.fromBase64String(imgByteString),
    );

    final messages = <Message>[
      Message('Hi', DateTime.now(), null),
      Message("What's up?", DateTime.now().add(const Duration(minutes: 5)),
          coworker),
      Message('What kind of food would you prefer?',
          DateTime.now().add(const Duration(minutes: 10)), lunchBot),
      Message('You do not have time eat! Keep working!',
          DateTime.now().add(const Duration(minutes: 11)), chef),
    ];

    final messagingStyle = MessagingStyleInformation(
      me,
      groupConversation: false,
      conversationTitle: 'Group Chat',
      htmlFormatContent: true,
      htmlFormatTitle: true,
      messages: messages,
    );

    final androidNotificationDetails = AndroidNotificationDetails(
      'Chats',
      'Chats',
      channelDescription: 'Notification channel for chats.',
      category: AndroidNotificationCategory.message,
      styleInformation: messagingStyle,
    );

    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationPlugin.show(
      2,
      'message title',
      'message body',
      notificationDetails,
    );

    // wait 10 seconds and add another message to simulate another response
    await Future<void>.delayed(const Duration(seconds: 10), () async {
      messages.add(Message("I'm so sorry!!! But I really like thai food ...",
          DateTime.now().add(const Duration(minutes: 11)), null));

      await _notificationPlugin.show(
        2,
        'message title',
        'message body',
        notificationDetails,
      );
    });
  }

  /// Cancel Notification With ID
  Future<void> cancelNotification(int id) async {
    await _notificationPlugin.cancel(id);
  }

  /// Cancel Notification With ID and Tag
  Future<void> cancelNotificationWithTag(int id, String tag) async {
    await _notificationPlugin.cancel(id, tag: tag);
  }

  /// Cancel All Notification
  Future<void> cancelAllNotification() async {
    await _notificationPlugin.cancelAll();
  }

  Future<String> _getImageBytes(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    return base64Encode(response.bodyBytes);
  }
}
