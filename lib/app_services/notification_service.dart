import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/utils/utility.dart';

class NotificationService {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();
  final _androidInitSettings =
      const AndroidInitializationSettings('@mipmap/launcher_icon');
  final _iosInitSettings = const DarwinInitializationSettings();

  bool _initialized = false;

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

  Future<Uint8List> getImageBytes(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  void showNotification({
    String? title,
    required String body,
    int? id,
    String? channelId,
    String? channelName,
    Priority? priority,
    String? largeIcon,
    String? groupKey,
    Importance? importance,
    InterruptionLevel? interruptionLevel,
    bool? playSound,
    bool? enableVibration,
    bool? enableLights,
  }) async {
    ByteArrayAndroidBitmap? androidBitmap;
    if (largeIcon != null) {
      var bodyBytes = await getImageBytes(largeIcon);
      androidBitmap =
          ByteArrayAndroidBitmap.fromBase64String(base64.encode(bodyBytes));
    }
    var androidNot = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      groupKey: groupKey,
      priority: priority ?? Priority.defaultPriority,
      importance: importance ?? Importance.defaultImportance,
      playSound: playSound ?? false,
      enableVibration: enableVibration ?? false,
      enableLights: enableLights ?? true,
      largeIcon: androidBitmap != null ? androidBitmap : null,
    );
    var iosNot = DarwinNotificationDetails(
      interruptionLevel: interruptionLevel ?? InterruptionLevel.passive,
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
}
