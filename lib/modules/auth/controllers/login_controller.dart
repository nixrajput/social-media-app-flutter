import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/utils.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();

  final _auth = AuthController.find;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void _clearLoginTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();
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

    _isLoading.value = true;
    await AppOverlay.showLoadingIndicator();
    update();

    try {
      final response = await http.post(
        Uri.parse(AppUrls.baseUrl + AppUrls.loginEndpoint),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _auth.setLoginData = LoginResponse.fromJson(data);

        var _token = _auth.loginData.token!;
        var _expiresAt = _auth.loginData.expiresAt!;

        await AppUtils.saveLoginDataToLocalStorage(
          _token,
          _expiresAt,
        );

        _auth.setToken = _token;
        _auth.setExpiresAt = _expiresAt;
        _auth.autoLogout();
        _clearLoginTextControllers();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.loginSuccessful,
          StringValues.success,
        );
      } else {
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      await AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
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
