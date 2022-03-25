import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/models/login_model.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/modules/auth/helpers/helper_func.dart';
import 'package:social_media_app/routes/route_management.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find();

  final _token = ''.obs;
  final _isLoading = false.obs;
  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final Rx<String> _expiresAt = ''.obs;
  final Rx<UserModel> _userModel = UserModel().obs;

  bool get isLoading => _isLoading.value;

  set setLoginModel(LoginModel model) {
    _loginModel.value = model;
  }

  LoginModel get loginModel => _loginModel.value;

  set setUserModel(UserModel model) {
    _userModel.value = model;
  }

  UserModel get userModel => _userModel.value;

  set setToken(String value) {
    _token.value = value;
  }

  String get token => _token.value;

  set setExpiresAt(String value) {
    _expiresAt.value = value;
  }

  String get expiresAt => _expiresAt.value;

  Stream<String> get tokenStream => _validateToken();

  @override
  onReady() {
    ever(_token, _autoLogin);
    _token.bindStream(tokenStream);
    super.onReady();
  }

  Stream<String> _validateToken() async* {
    var _token = '';
    final decodedData = await HelperFunction.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt.value = decodedData[StringValues.expiresAt];
      _token = decodedData[StringValues.token];
    }
    autoLogout();
    yield _token;
  }

  void _autoLogin(String _token) async {
    if (_token.isNotEmpty) {
      await _getProfileDetails();
      RouteManagement.goToHomeView();
    } else {
      RouteManagement.goToLoginView();
    }
  }

  Future<void> _logout() async {
    RouteManagement.goToLoginView();
    setToken = '';
    setExpiresAt = '';
    setLoginModel = LoginModel();
    setUserModel = UserModel();
    await HelperFunction.clearLoginDataFromLocalStorage();
    AppUtils.showSnackBar(
      StringValues.logoutSuccessful,
      StringValues.success,
    );
    update();
  }

  void autoLogout() async {
    if (_expiresAt.isNotEmpty) {
      var _currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (int.parse(_expiresAt.value) < _currentTimestamp) {
        await _logout();
      }
    }
    if (_userModel.value.user != null &&
        _token.value == _userModel.value.user!.token) {
      await _logout();
      AppUtils.showSnackBar(
        'Token is expired or invalid',
        StringValues.error,
      );
    }
  }

  Future<void> _getProfileDetails() async {
    _isLoading.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse(AppUrls.baseUrl + AppUrls.profileDetailsEndpoint),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer ${_token.value}',
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _userModel.value = UserModel.fromJson(data);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> logout() async => await _logout();

  Future<void> getProfileDetails() async => await _getProfileDetails();
}
