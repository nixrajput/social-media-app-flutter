import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
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

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.login(body);

      if (response.isSuccessful) {
        _auth.setLoginData = AuthResponse.fromJson(response.data);

        var token = _auth.loginData.token!;
        var expiresAt = _auth.loginData.expiresAt!;

        await _auth.saveLoginDataToLocalStorage(token, expiresAt);

        _auth.setToken = token;
        _auth.setExpiresAt = expiresAt;

        try {
          await _profile.fetchProfileDetails();

          var fcmToken = await _auth.readFcmTokenFromLocalStorage();

          if (fcmToken.isNotEmpty) {
            AppUtility.log('fcmToken: $fcmToken');
            await _auth.saveFcmToken(fcmToken);
          } else {
            AppUtility.log('Generating FCM token');
            var messaging = FirebaseMessaging.instance;
            var token = await messaging.getToken();
            AppUtility.log('fcmToken: $token');
            await _auth.saveFcmTokenToLocalStorage(token!);
            await _auth.saveFcmToken(token);
          }

          await _auth.saveLoginInfo();
          _clearLoginTextControllers();

          _isLoading.value = false;
          update();
          AppUtility.closeDialog();
          RouteManagement.goToHomeView();

          AppUtility.showSnackBar(
            StringValues.loginSuccessful,
            StringValues.success,
          );
        } catch (e) {
          AppUtility.log("Error: $e");
          _isLoading.value = false;
          update();
          AppUtility.closeDialog();
          return;
        }
      } else {
        _isLoading.value = false;
        update();
        AppUtility.closeDialog();

        if (response.data['accountStatus'] != null) {
          _accountStatus.value = response.data['accountStatus'];
          switch (_accountStatus.value) {
            case 'unverified':
              RouteManagement.goToSendVerifyAccountOtpView();
              AppUtility.showSnackBar(
                response.data[StringValues.message],
                StringValues.error,
              );
              break;
            case 'deactivated':
              RouteManagement.goToReactivateAccountView();
              AppUtility.showSnackBar(
                response.data[StringValues.message],
                StringValues.error,
              );
              break;
            case 'blocked':
              AppUtility.showSnackBar(
                response.data[StringValues.message],
                StringValues.error,
              );
              break;
            default:
              AppUtility.log("Invalid Account Status", tag: 'error');
              break;
          }
        } else {
          AppUtility.showSnackBar(
            response.data[StringValues.message],
            StringValues.error,
          );
        }
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
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
