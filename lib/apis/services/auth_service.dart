import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  StreamSubscription<dynamic>? _streamSubscription;

  String _token = '';
  String _expiresAt = '';
  LoginResponse _loginData = LoginResponse();

  String get token => _token;

  String get expiresAt => _expiresAt;

  LoginResponse get loginData => _loginData;

  set setLoginData(LoginResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(String value) => _expiresAt = value;

  Future<String> getToken() async {
    var token = '';
    final decodedData = await AppUtils.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setToken = decodedData[StringValues.token];
      token = decodedData[StringValues.token];
    }
    return token;
  }

  Future<void> _logout() async {
    RouteManagement.goToLoginView();
    setToken = '';
    setExpiresAt = '';
    await AppUtils.clearLoginDataFromLocalStorage();
    AppUtils.showSnackBar(
      StringValues.logoutSuccessful,
      StringValues.success,
    );
  }

  void autoLogout() async {
    if (_expiresAt.isNotEmpty) {
      var currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (int.parse(_expiresAt) < currentTimestamp) {
        setToken = '';
        setExpiresAt = '';
        await AppUtils.clearLoginDataFromLocalStorage();
      }
    }
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        AppUtils.closeDialog();
      } else {
        AppUtils.showNoInternetDialog();
      }
    });
  }

  Future<void> logout() async => await _logout();

  @override
  void onInit() {
    _checkForInternetConnectivity();
    super.onInit();
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
