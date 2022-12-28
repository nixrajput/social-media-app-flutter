import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ReactivateAccountController extends GetxController {
  static ReactivateAccountController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _otpSent = false.obs;
  final _showPassword = true.obs;

  bool get isLoading => _isLoading.value;

  bool get otpSent => _otpSent.value;

  bool get showPassword => _showPassword.value;

  void _clearTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();
    otpTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _sendReactivateAccountOtp(String email, String password) async {
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
      'email': email,
      'password': password,
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendReactivateAccountOtp(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
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
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> _reactivateAccount(String otp) async {
    if (otp.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': emailTextController.text.trim(),
      'password': passwordTextController.text.trim(),
      'otp': otp,
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.reactivateAccount(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _clearTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
            decodedData[StringValues.message], StringValues.error);
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> sendReactivateAccountOtp() async {
    AppUtility.closeFocus();
    await _sendReactivateAccountOtp(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }

  Future<void> reactivateAccount() async {
    AppUtility.closeFocus();
    await _reactivateAccount(otpTextController.text.trim());
  }
}
