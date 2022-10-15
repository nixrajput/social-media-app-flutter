import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/utils/utility.dart';

class SocketApiProvider {
  // A static private instance to access _socketApi from inside class only
  static final SocketApiProvider _socketApi = SocketApiProvider._internal();

  // An internal private constructor to access it for only once for static instance of class.
  SocketApiProvider._internal();

  // Factory constructor to return same static instance everytime you create any object.
  factory SocketApiProvider() {
    return _socketApi;
  }

  // All the private and public variables
  static WebSocket? _socket;
  final _socketEventStream = StreamController<dynamic>();

  Stream<dynamic> get socketEventStream =>
      _socketEventStream.stream.asBroadcastStream();
  WebSocket? get socket => _socket;
  bool get isConnected => _socket?.readyState == WebSocket.open;
  bool get isDisconnected => _socket?.readyState == WebSocket.closed;
  bool get isConnecting => _socket?.readyState == WebSocket.connecting;
  bool get isClosing => _socket?.readyState == WebSocket.closing;
  bool get isNotConnected => _socket?.readyState != WebSocket.open;

  // All socket related functions.
  static Future<void> init(String token) async {
    if (token.isEmpty) {
      AppUtility.printLog("Socket token is empty");
      return;
    }

    if (_socket != null && _socket!.readyState == WebSocket.open) {
      AppUtility.printLog("Socket is already connected");
      return;
    }

    try {
      _socket =
          await WebSocket.connect('${AppSecrets.awsWebSocketUrl}?token=$token');
      AppUtility.printLog("Socket connected");
      _socket!.listen(_socketEventHandler, onError: (error) {
        AppUtility.printLog("Socket error: $error");
      }, onDone: () {
        AppUtility.printLog("Socket done");
      }, cancelOnError: true);
    } catch (e) {
      AppUtility.printLog("Socket connection error: $e");
    }

    AppUtility.printLog("Socket init done");
  }

  static void _socketEventHandler(dynamic event) {
    AppUtility.printLog("Socket event");
    _socketApi._socketEventStream.add(event);
  }

  void close() {
    _socket?.close();
  }

  void send(String message) {
    _socket?.add(message);
  }

  void sendJson(Map<String, dynamic> json) {
    _socket?.add(jsonEncode(json));
  }

  void dispose() {
    _socketEventStream.close();
    _socket?.close();
  }
}
