import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/apis/models/responses/profile_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final _token = ''.obs;
  final _isLoading = false.obs;
  final _loginData = LoginResponse().obs;
  final _expiresAt = ''.obs;
  final _profileData = ProfileResponse().obs;

  bool get isLoading => _isLoading.value;

  set setLoginData(LoginResponse value) {
    _loginData.value = value;
  }

  LoginResponse get loginData => _loginData.value;

  set setProfileData(ProfileResponse value) {
    _profileData.value = value;
  }

  ProfileResponse get profileData => _profileData.value;

  set setToken(String value) {
    _token.value = value;
  }

  String get token => _token.value;

  set setExpiresAt(String value) {
    _expiresAt.value = value;
  }

  String get expiresAt => _expiresAt.value;

  Stream<String> get tokenStream => _validateToken();

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

  void _autoLogin(String? _token) async {
    if (_token != null && _token.isNotEmpty) {
      AppUtils.printLog("Fetching Profile Details Request...");
      try {
        final response = await _apiProvider.getProfileDetails(_token);

        final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

        if (response.statusCode == 200) {
          setProfileData = ProfileResponse.fromJson(decodedData);
          update();
          RouteManagement.goToHomeView();
        } else {
          RouteManagement.goToErrorView();
          AppUtils.showSnackBar(
            decodedData[StringValues.message],
            StringValues.error,
          );
        }
      } on SocketException {
        AppUtils.printLog(StringValues.internetConnError);
        RouteManagement.goToErrorView();
        AppUtils.showSnackBar(
            StringValues.internetConnError, StringValues.error);
      } on TimeoutException {
        AppUtils.printLog(StringValues.connTimedOut);
        AppUtils.printLog(StringValues.connTimedOut);
        RouteManagement.goToErrorView();
        AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
      } on FormatException catch (e) {
        AppUtils.printLog(StringValues.formatExcError);
        AppUtils.printLog(e);
        RouteManagement.goToErrorView();
        AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
      } catch (exc) {
        AppUtils.printLog(StringValues.errorOccurred);
        AppUtils.printLog(exc);
        RouteManagement.goToErrorView();
        AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
      }
    } else {
      RouteManagement.goToLoginView();
    }
  }

  Future<void> _logout() async {
    RouteManagement.goToLoginView();
    setToken = '';
    setExpiresAt = '';
    setLoginData = LoginResponse();
    setProfileData = ProfileResponse();
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
    if (_profileData.value.user != null) {
      if (_profileData.value.user!.token == _token.value) {
        await _logout();
        AppUtils.showSnackBar(
          StringValues.tokenError,
          StringValues.error,
        );
      }
    }
  }

  Future<void> _getProfileDetails() async {
    _isLoading.value = true;
    update();
    AppUtils.printLog("Fetching Profile Details Request...");
    try {
      final response = await _apiProvider.getProfileDetails(_token.value);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setProfileData = ProfileResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleFollowUser(String userId) {
    if (_profileData.value.user!.following.contains(userId)) {
      _profileData.value.user!.following.remove(userId);
    } else {
      _profileData.value.user!.following.add(userId);
    }
    update();
  }

  Future<void> _followUnfollowUser(String userId) async {
    AppUtils.printLog("Follow/Unfollow User Request...");
    _toggleFollowUser(userId);

    try {
      final response =
          await _apiProvider.followUnfollowUser(userId, _token.value);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        _toggleFollowUser(userId);
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> followUnfollowUser(String userId) async {
    await _followUnfollowUser(userId);
  }

  Future<void> logout() async => await _logout();

  Future<void> getProfileDetails() async => await _getProfileDetails();

  @override
  onReady() {
    ever(_token, _autoLogin);
    _token.bindStream(tokenStream);
    super.onReady();
  }
}
