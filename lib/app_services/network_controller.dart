import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:social_media_app/utils/utility.dart';

class NetworkController extends GetxController {
  static NetworkController get find => Get.find();

  final _isConnected = false.obs;
  bool get isConnected => _isConnected.value;
  set isConnected(bool value) => _isConnected.value = value;

  StreamSubscription<dynamic>? _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  void _init() async {
    AppUtility.log('NetworkController Initializing');
    _checkForInternetConnectivity();
    super.onInit();
    AppUtility.log('NetworkController Initialized');
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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
