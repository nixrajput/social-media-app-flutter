import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/utils/utility.dart';

class SocketApiProvider {
  /// Factory constructor to return same static instance everytime you
  /// create any object.
  factory SocketApiProvider() {
    return _socketApi;
  }

  /// An internal private constructor to access it for only once for static
  /// instance of class.
  SocketApiProvider._internal();

  /// All the private and public variables
  static WebSocket? _socket;

  /// A static private instance to access _socketApi from inside class only
  static final SocketApiProvider _socketApi = SocketApiProvider._internal();

  var _isDisposed = false;
  StreamController<dynamic>? _socketEventStream;

  Stream<dynamic>? get socketEventStream =>
      _socketEventStream?.stream.asBroadcastStream();

  WebSocket? get socket => _socket;

  bool get isConnected => _socket?.readyState == WebSocket.open;

  bool get isDisconnected => _socket?.readyState == WebSocket.closed;

  bool get isConnecting => _socket?.readyState == WebSocket.connecting;

  bool get isClosing => _socket?.readyState == WebSocket.closing;

  bool get isNotConnected => _socket?.readyState != WebSocket.open;

  bool get isDisposed => _isDisposed;

  // All socket related functions.
  Future<void> init() async {
    final _authService = AuthService.find;
    AppUtility.log("Socket initializing...");

    if (_socket != null && isConnected) {
      AppUtility.log("Socket already connected.");
      return;
    }

    if (_authService.token.isEmpty) {
      AppUtility.log("Socket token is empty");
      return;
    }

    try {
      _socket = await WebSocket.connect(
          '${AppUrls.webSocketUrl}?token=${_authService.token}');

      if (_socket != null && isConnected) {
        AppUtility.log("Socket connection established");
        _socketEventStream = StreamController<dynamic>.broadcast();
      }

      _socket!.listen(
        _socketEventHandler,
        onError: (error) {
          _socket?.close();
          _socketEventStream?.close();
          _socketEventStream = null;
          _socket = null;
          AppUtility.log("Socket error: $error", tag: 'error');
          reconnect(_authService.token);
        },
        onDone: () {
          _socket?.close();
          _socketEventStream?.close();
          _socketEventStream = null;
          _socket = null;
          AppUtility.log("Socket done");
          reconnect(_authService.token);
        },
      );
    } catch (e) {
      AppUtility.log("Socket connection error: $e", tag: 'error');
    }

    AppUtility.log("Socket initialized");
  }

  void dispose() {
    AppUtility.log("Socket disposing...");
    _socket?.close();
    _socketEventStream?.close();
    _socketEventStream = null;
    _socket = null;
    _isDisposed = true;
    AppUtility.log("Socket disposed");
  }

  void reconnect(String token) {
    if (isDisposed) {
      AppUtility.log("Socket is disposed");
      return;
    }

    AppUtility.log("Socket reconnecting...");
    init();
  }

  void send(String message) {
    _socket?.add(message);
  }

  void sendJson(Map<String, dynamic> json) {
    _socket?.add(jsonEncode(json));
  }

  void _socketEventHandler(dynamic event) {
    AppUtility.log("Socket event received");
    _socketApi._socketEventStream?.add(event);
  }
}
