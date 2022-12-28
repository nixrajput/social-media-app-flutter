import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class PasswordController extends GetxController {
  static PasswordController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _showPassword = true.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  void _clearResetPasswordTextControllers() {
    otpTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _sendForgotPasswordOTP(String email) async {
    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {'email': email};

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.forgotPassword(body);

      if (response.isSuccessful) {
        _clearResetPasswordTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          StringValues.otpSendSuccessful,
          StringValues.success,
        );
        RouteManagement.goToResetPasswordView();
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _resetPassword(
    String otp,
    String newPassword,
    String confPassword,
  ) async {
    if (otp.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    if (newPassword.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
    if (confPassword.isEmpty) {
      AppUtility.showSnackBar(
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

    AppUtility.printLog("Password Reset Request...");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.resetPassword(body);

      if (response.isSuccessful) {
        _clearResetPasswordTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          StringValues.passwordChangeSuccessful,
          StringValues.success,
        );
        RouteManagement.goToLoginView();
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> sendResetPasswordOTP() async {
    AppUtility.closeFocus();
    await _sendForgotPasswordOTP(emailTextController.text.trim());
  }

  Future<void> resetPassword() async {
    AppUtility.closeFocus();
    await _resetPassword(
      otpTextController.text.trim(),
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
