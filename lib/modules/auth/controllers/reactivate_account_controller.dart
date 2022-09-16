import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

    AppUtility.printLog("Send Reactivate Account OTP Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendReactivateAccountOtp(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Send Reactivate Account OTP Success");
        AppUtility.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Send Reactivate Account OTP Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Reactivate Account OTP Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Reactivate Account OTP Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Reactivate Account OTP Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Reactivate Account OTP Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
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

    AppUtility.printLog("Reactivate Account Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.reactivateAccount(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _clearTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Reactivate Account Success");
        RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Reactivate Account Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Reactivate Account Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Reactivate Account Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Reactivate Account Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Reactivate Account Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
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
