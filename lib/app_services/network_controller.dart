import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:social_media_app/utils/utility.dart';

class NetworkController {
  NetworkController._internal();

  static final NetworkController _instance = NetworkController._internal();

  static NetworkController get instance => _instance;

  var isConnected = false;
  var isInitialized = false;

  StreamSubscription<dynamic>? _streamSubscription;
  final _connectivity = Connectivity();

  close() {
    _streamSubscription?.cancel();
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
        AppUtility.log('Internet Connection Available');
      } else if (result == ConnectivityResult.wifi) {
        isConnected = true;
        AppUtility.log('Internet Connection Available');
      } else {
        isConnected = false;
        AppUtility.log('No Internet Connection');
      }
    });
  }
}
