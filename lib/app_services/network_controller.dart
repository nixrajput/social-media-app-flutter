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
    AppUtility.log('NetworkController Initializing');
    _checkForInternetConnectivity();
    super.onInit();
    AppUtility.log('NetworkController Initialized');
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
        AppUtility.log('No Internet Connection');
      } else {
        isConnected = true;
        AppUtility.log('Internet Connection Available');
      }
    });
  }
}
