import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();

  final _auth = AuthService.find;
  final _profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();
  final _showPassword = true.obs;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  void _clearLoginTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _login(String email, String password) async {
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': email,
      'password': password,
    };

    AppUtils.printLog("User Login Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.login(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      AppUtils.printLog(decodedData);

      if (response.statusCode == 200) {
        _auth.setLoginData = AuthResponse.fromJson(decodedData);

        var token = _auth.loginData.token!;
        var expiresAt = _auth.loginData.expiresAt!;

        await AppUtils.saveLoginDataToLocalStorage(token, expiresAt);

        _auth.setToken = token;
        _auth.setExpiresAt = expiresAt;
        _auth.autoLogout();
        await _profile.fetchProfileDetails().then((_) async {
          await _auth.saveLoginInfo();

          _clearLoginTextControllers();

          AppUtils.closeDialog();
          _isLoading.value = false;
          RouteManagement.goToHomeView();
          update();
          AppUtils.showSnackBar(
            StringValues.loginSuccessful,
            StringValues.success,
          );
        }).catchError((_) {
          AppUtils.closeDialog();
          _isLoading.value = false;
          update();
          AppUtils.showSnackBar(
            StringValues.errorOccurred,
            StringValues.error,
          );
          return;
        });
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> login() async {
    AppUtils.closeFocus();
    await _login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }
}
