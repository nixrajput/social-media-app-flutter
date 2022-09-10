import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

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

    AppUtils.printLog("Send Reactivate Account OTP Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendReactivateAccountOtp(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog("Send Reactivate Account OTP Success");
        AppUtils.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Send Reactivate Account OTP Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Reactivate Account OTP Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Reactivate Account OTP Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Reactivate Account OTP Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Reactivate Account OTP Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _reactivateAccount(String otp) async {
    if (otp.isEmpty) {
      AppUtils.showSnackBar(
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

    AppUtils.printLog("Reactivate Account Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.reactivateAccount(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _clearTextControllers();
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Reactivate Account Success");
        RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Reactivate Account Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Reactivate Account Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Reactivate Account Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Reactivate Account Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Reactivate Account Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> sendReactivateAccountOtp() async {
    AppUtils.closeFocus();
    await _sendReactivateAccountOtp(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }

  Future<void> reactivateAccount() async {
    AppUtils.closeFocus();
    await _reactivateAccount(otpTextController.text.trim());
  }
}
