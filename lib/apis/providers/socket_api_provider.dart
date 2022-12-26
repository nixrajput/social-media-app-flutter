import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/utils/utility.dart';

class SocketApiProvider {
  /// A static private instance to access _socketApi from inside class only
  static final SocketApiProvider _socketApi = SocketApiProvider._internal();

  /// An internal private constructor to access it for only once for static
  /// instance of class.
  SocketApiProvider._internal();

  /// Factory constructor to return same static instance everytime you
  /// create any object.
  factory SocketApiProvider() {
    return _socketApi;
  }

  /// All the private and public variables
  static WebSocket? _socket;
  StreamController<dynamic>? _socketEventStream;

  Stream<dynamic>? get socketEventStream =>
      _socketEventStream?.stream.asBroadcastStream();
  WebSocket? get socket => _socket;
  bool get isConnected => _socket?.readyState == WebSocket.open;
  bool get isDisconnected => _socket?.readyState == WebSocket.closed;
  bool get isConnecting => _socket?.readyState == WebSocket.connecting;
  bool get isClosing => _socket?.readyState == WebSocket.closing;
  bool get isNotConnected => _socket?.readyState != WebSocket.open;

  // All socket related functions.
  Future<void> init(String token) async {
    AppUtility.log("Socket initializing...");

    if (_socket != null && isConnected) {
      AppUtility.log("Socket already connected.");
      return;
    }

    if (token.isEmpty) {
      AppUtility.log("Socket token is empty", tag: 'warning');
      return;
    }

    try {
      _socket = await WebSocket.connect('${AppUrls.webSocketUrl}?token=$token');

      if (_socket != null && isConnected) {
        AppUtility.log("Socket connection established");
        _socketEventStream = StreamController<dynamic>.broadcast();
      }

      _socket!.listen(
        _socketEventHandler,
        onError: (error) {
          AppUtility.log("Socket error: $error", tag: 'error');
          reconnect(token);
        },
        onDone: () {
          AppUtility.log("Socket done");
          reconnect(token);
        },
        cancelOnError: true,
      );
    } catch (e) {
      AppUtility.log("Socket connection error: $e", tag: 'error');
    }

    AppUtility.log("Socket initialized");
  }

  void _socketEventHandler(dynamic event) {
    AppUtility.log("Socket event received");
    _socketApi._socketEventStream?.add(event);
  }

  void close() {
    _socketApi._socketEventStream?.close();
    _socket?.close();
    _socketApi._socketEventStream = null;
    _socket = null;
    AppUtility.log("Socket closed");
  }

  void reconnect(String token) {
    close();
    init(token);
  }

  void send(String message) {
    _socket?.add(message);
  }

  void sendJson(Map<String, dynamic> json) {
    _socket?.add(jsonEncode(json));
  }
}
