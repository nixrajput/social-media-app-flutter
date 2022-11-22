import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:social_media_app/utils/utility.dart';

class NetworkController extends GetxController {
  static NetworkController get find => Get.find();

  final _networkStatus = false.obs;
  bool get networkStatus => _networkStatus.value;
  set networkStatus(bool value) => _networkStatus.value = value;

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
        networkStatus = false;
        AppUtility.log('No Internet Connection');
      } else {
        networkStatus = true;
        AppUtility.log('Internet Connection Available');
      }
    });
  }
}
