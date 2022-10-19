import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();

  final _auth = AuthService.find;
  final _profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final emailUnameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();
  final _showPassword = true.obs;
  final _accountStatus = ''.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String get accountStatus => _accountStatus.value;

  bool get showPassword => _showPassword.value;

  void _clearLoginTextControllers() {
    emailUnameTextController.clear();
    passwordTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _login(String email, String password) async {
    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'emailUname': email,
      'password': password,
    };

    AppUtility.printLog("User Login Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.login(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("User Login Success");
        _auth.setLoginData = AuthResponse.fromJson(decodedData);

        var token = _auth.loginData.token!;
        var expiresAt = _auth.loginData.expiresAt!;

        await AppUtility.saveLoginDataToLocalStorage(token, expiresAt);

        _auth.setToken = token;
        _auth.setExpiresAt = expiresAt;
        _auth.autoLogout();
        await _profile.fetchProfileDetails().then((_) async {
          var fcmToken = await AppUtility.readFcmTokenFromLocalStorage();

          if (_auth.deviceId != null && _auth.deviceId! != 0) {
            await _auth.saveDeviceIdToServer(_auth.deviceId.toString());
          }

          if (fcmToken.isNotEmpty) {
            AppUtility.printLog('fcmToken: $fcmToken');
            await _auth.saveFcmToken(fcmToken);
          } else {
            var messaging = FirebaseMessaging.instance;
            var token = await messaging.getToken();
            AppUtility.printLog('fcmToken: $token');
            await AppUtility.saveFcmTokenToLocalStorage(token!);
            await _auth.saveFcmToken(token);
          }

          await _auth.saveLoginInfo();
          await LoginDeviceInfoController.find.getLoginDeviceInfo();
          _clearLoginTextControllers();

          AppUtility.closeDialog();
          _isLoading.value = false;
          RouteManagement.goToHomeView();
          update();
          AppUtility.showSnackBar(
            StringValues.loginSuccessful,
            StringValues.success,
          );
        }).catchError((_) {
          AppUtility.closeDialog();
          _isLoading.value = false;
          update();
          AppUtility.showSnackBar(
            StringValues.errorOccurred,
            StringValues.error,
          );
          return;
        });
      } else {
        AppUtility.printLog("User Login Error");
        AppUtility.printLog(decodedData);

        _isLoading.value = false;
        update();
        AppUtility.closeDialog();

        if (decodedData['accountStatus'] != null) {
          _accountStatus.value = decodedData['accountStatus'];
          switch (_accountStatus.value) {
            case 'unverified':
              RouteManagement.goToSendVerifyAccountOtpView();
              AppUtility.showSnackBar(
                decodedData[StringValues.message],
                StringValues.error,
              );
              break;
            case 'deactivated':
              RouteManagement.goToReactivateAccountView();
              AppUtility.showSnackBar(
                decodedData[StringValues.message],
                StringValues.error,
              );
              break;
            case 'blocked':
              AppUtility.showSnackBar(
                decodedData[StringValues.message],
                StringValues.error,
              );
              break;
            default:
              AppUtility.printLog("Invalid Account Status");
              break;
          }
        } else {
          AppUtility.showSnackBar(
            decodedData[StringValues.message],
            StringValues.error,
          );
        }
      }
    } on SocketException {
      AppUtility.printLog("User Login Error");
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog("User Login Error");
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog("User Login Error");
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog("User Login Error");
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> login() async {
    AppUtility.closeFocus();
    await _login(
      emailUnameTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }
}
