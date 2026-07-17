import 'dart:async';
import 'package:dio/dio.dart';

class _Event {
  _Event(this.name, this.props, this.ts);
  final String name;
  final Map<String, dynamic>? props;
  final String ts;
  Map<String, dynamic> toJson(String sessionId) => {
    'name': name,
    'props': ?props,
    'ts': ts,
    'sessionId': sessionId,
  };
}

class TelemetryClient {
  TelemetryClient(this._dio, {required this.sessionId});
  final Dio _dio;
  final String sessionId;
  final List<_Event> _buffer = [];

  void track(String name, [Map<String, dynamic>? props]) {
    _buffer.add(_Event(name, props, DateTime.now().toUtc().toIso8601String()));
    if (_buffer.length >= 50) unawaited(flush());
  }

  Future<void> flush() async {
    if (_buffer.isEmpty) return;
    final batch = _buffer.take(100).toList();
    try {
      await _dio.post<dynamic>(
        '/telemetry/events',
        data: {'events': batch.map((e) => e.toJson(sessionId)).toList()},
      );
      _buffer.removeRange(0, batch.length);
    } on DioException {
      // keep events buffered for the next flush attempt
    }
  }

  Future<void> reportCrash({
    required String platform,
    required String appVersion,
    required Object error,
    required StackTrace stack,
    String? deviceModel,
    String? osVersion,
  }) async {
    try {
      await _dio.post<dynamic>(
        '/telemetry/crashes',
        data: {
          'platform': platform,
          'appVersion': appVersion,
          'error': error.toString(),
          'stackTrace': stack.toString(),
          'deviceModel': ?deviceModel,
          'osVersion': ?osVersion,
          'ts': DateTime.now().toUtc().toIso8601String(),
        },
      );
    } on DioException {
      // swallow: telemetry must never crash the app
    }
  }
}
