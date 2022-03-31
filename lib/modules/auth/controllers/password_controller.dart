import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

class PasswordController extends GetxController {
  static PasswordController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void _clearResetPasswordTextControllers() {
    otpTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }

  Future<void> _sendForgotPasswordOTP(String email) async {
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': email,
    };

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendPasswordResetEmail(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _clearResetPasswordTextControllers();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.otpSendSuccessful,
          StringValues.success,
        );
        RouteManagement.goToResetPasswordView();
      } else {
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      await AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      AppUtils.printLog(err);
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _resetPassword(
    String otp,
    String newPassword,
    String confPassword,
  ) async {
    if (otp.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    if (newPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
    if (confPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'otp': otp,
      'newPassword': newPassword,
      'confirmPassword': confPassword,
    };

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.resetPassword(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _clearResetPasswordTextControllers();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.passwordChangeSuccessful,
          StringValues.success,
        );
        RouteManagement.goToLoginView();
      } else {
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      await AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      AppUtils.printLog(err);
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> sendResetPasswordOTP() async {
    AppUtils.closeFocus();
    await _sendForgotPasswordOTP(emailTextController.text.trim());
  }

  Future<void> resetPassword() async {
    AppUtils.closeFocus();
    await _resetPassword(
      otpTextController.text.trim(),
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
