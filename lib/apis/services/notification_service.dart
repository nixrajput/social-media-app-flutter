import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();
  final _androidInitSettings =
      const AndroidInitializationSettings('@mipmap/launcher_icon');
  final _iosInitSettings = const DarwinInitializationSettings();

  String _fcmToken = '';
  bool _initialized = false;

  bool get isInitialized => _initialized;
  String get fcmToken => _fcmToken;

  set setFcmToken(String value) => _fcmToken = value;

  Future<void> initialize() async {
    if (!_initialized) {
      final initializationSettings = InitializationSettings(
        iOS: _iosInitSettings,
        android: _androidInitSettings,
      );
      await _notificationPlugin.initialize(initializationSettings);
      _initialized = true;
    }
  }

  void showNotification({
    String? title,
    required String body,
    int? id,
    String? channelId,
    String? channelName,
    bool? priority,
    String? largeIcon,
  }) async {
    var androidNot = AndroidNotificationDetails(
      channelId ?? 'General Notifications',
      channelName ?? 'General Notifications',
      priority: priority == true ? Priority.high : Priority.defaultPriority,
      importance:
          priority == true ? Importance.max : Importance.defaultImportance,
    );
    var iosNot = DarwinNotificationDetails(
      interruptionLevel: priority == true
          ? InterruptionLevel.active
          : InterruptionLevel.passive,
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
