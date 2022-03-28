import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/apis/models/responses/user_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find();

  final _apiProvider = ApiProvider(dio.Dio());

  final _token = ''.obs;
  final _isLoading = false.obs;
  final _loginData = LoginResponse().obs;
  final _expiresAt = ''.obs;
  final _userData = UserResponse().obs;

  bool get isLoading => _isLoading.value;

  set setLoginData(LoginResponse value) {
    _loginData.value = value;
  }

  LoginResponse get loginData => _loginData.value;

  set setUserData(UserResponse value) {
    _userData.value = value;
  }

  UserResponse get userData => _userData.value;

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
    final decodedData = await AppUtils.readLoginDataFromLocalStorage();
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
    setLoginData = LoginResponse();
    setUserData = UserResponse();
    await AppUtils.clearLoginDataFromLocalStorage();
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
    if (_userData.value.user != null &&
        _token.value == _userData.value.user!.token) {
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

    await _apiProvider
        .getProfileDetails('application/json', 'Bearer ${_token.value}')
        .then((data) {
      setUserData = data;
      _isLoading.value = false;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _isLoading.value = false;
          update();
          AppUtils.showSnackBar(
            res!.statusMessage.toString(),
            StringValues.error,
          );
          debugPrint("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });
  }

  Future<void> logout() async => await _logout();

  Future<void> getProfileDetails() async => await _getProfileDetails();
}
