import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class RegisterController extends GetxController {
  static RegisterController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final unameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();
  final FocusScopeNode otpFocusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _showPassword = true.obs;
  final _showConfirmPassword = true.obs;
  final _isOtpSent = false.obs;
  final _isEmailVerified = false.obs;
  final _otp = List.empty(growable: true)..length = 6;

  Timer? resendTimer;
  int resendTimerSec = 0;
  int resendTimerMin = 0;

  bool get isLoading => _isLoading.value;
  bool get showPassword => _showPassword.value;
  bool get showConfirmPassword => _showConfirmPassword.value;
  bool get isOtpSent => _isOtpSent.value;
  bool get isEmailVerified => _isEmailVerified.value;
  String get otp => _otp.join();

  void onOtpChanged(String value, int index) {
    _otp[index] = value;
    update();
  }

  void _clearOtpFields() {
    _otp.clear();
    resetTimer();
    update();
  }

  void startTimer() {
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendTimerSec++;
      update();
      if (resendTimerSec > 59) {
        resendTimerSec = 0;
        resendTimerMin++;
        update();
      }
      if (timer.tick == 120) {
        resendTimerSec = 0;
        resendTimerMin = 0;
        timer.cancel();
        update();
      }
    });
  }

  void resetTimer() {
    resendTimerSec = 0;
    resendTimerMin = 0;
    resendTimer?.cancel();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  void toggleViewConfirmPassword() {
    _showConfirmPassword(!_showConfirmPassword.value);
    update();
  }

  void _clearRegisterTextControllers() {
    fNameTextController.clear();
    lNameTextController.clear();
    emailTextController.clear();
    unameTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
    _otp.clear();
  }

  Future<void> _sendOtpToEmail({required bool isResend}) async {
    if (emailTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {'email': emailTextController.text.trim()};

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendRegisterOtp(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isOtpSent.value = true;
        _isLoading.value = false;
        update();

        if (isResend) {
          resetTimer();
        }

        startTimer();

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _verifyOtpFromEmail() async {
    if (_otp.isEmpty || _otp.length < 6) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': emailTextController.text.trim(),
      'otp': _otp.join(),
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyOtpFromEmail(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _clearOtpFields();
        _isOtpSent.value = false;
        _isEmailVerified.value = true;
        AppUtility.closeDialog();
        _isLoading.value = false;
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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _register() async {
    if (fNameTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }
    if (lNameTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterLastName,
        StringValues.warning,
      );
      return;
    }
    if (emailTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (unameTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      return;
    }
    if (passwordTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
    if (confirmPasswordTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'fname': fNameTextController.text.trim(),
      'lname': lNameTextController.text.trim(),
      'email': emailTextController.text.trim(),
      'uname': unameTextController.text.trim(),
      'password': passwordTextController.text.trim(),
      'confirmPassword': confirmPasswordTextController.text.trim(),
      'isValidated': '${_isEmailVerified.value}',
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.register(body);

      if (response.isSuccessful) {
        _clearRegisterTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          StringValues.registrationSuccessful,
          StringValues.success,
        );
        RouteManagement.goToBack();
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

  Future<void> register() async {
    AppUtility.closeFocus();
    await _register();
  }

  Future<void> sendOtpToEmail() async {
    AppUtility.closeFocus();
    await _sendOtpToEmail(isResend: false);
  }

  Future<void> resendOtpToEmail() async {
    AppUtility.closeFocus();
    await _sendOtpToEmail(isResend: true);
  }

  Future<void> verifyOtpFromEmail() async {
    AppUtility.closeFocus();
    await _verifyOtpFromEmail();
  }
}
