import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:social_media_app/utils/utility.dart';

class NetworkController {
  NetworkController._internal();

  var isConnected = false;
  var isInitialized = false;

  static final NetworkController _instance = NetworkController._internal();

  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  final _connectivity = Connectivity();
  StreamSubscription<dynamic>? _streamSubscription;

  static NetworkController get instance => _instance;

  Stream<bool> get connectionStatus =>
      _connectionStatusController.stream.asBroadcastStream();

  close() {
    _streamSubscription?.cancel();
    _connectionStatusController.close();
    isInitialized = false;
  }

  Future<void> init() async {
    AppUtility.log('NetworkController Initializing');

    if (isInitialized) {
      AppUtility.log('NetworkController Already Initialized');
      return;
    }

    _checkForInternetConnectivity();
    AppUtility.log('NetworkController Initialized');
  }

  void _checkForInternetConnectivity() {
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isConnected = true;
        _connectionStatusController.add(true);
        AppUtility.log('Internet Connection Available');
      } else if (result == ConnectivityResult.wifi) {
        isConnected = true;
        _connectionStatusController.add(true);
        AppUtility.log('Internet Connection Available');
      } else {
        isConnected = false;
        _connectionStatusController.add(false);
        AppUtility.log('No Internet Connection');
      }
    });
  }
}
