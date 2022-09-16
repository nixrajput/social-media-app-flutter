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

class AccountVerificationController extends GetxController {
  static AccountVerificationController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void _clearTextControllers() {
    emailTextController.clear();
    otpTextController.clear();
  }

  Future<void> _sendVerifyAccountOtp(String email) async {
    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': email,
    };

    AppUtility.printLog("Send Verify Account OTP Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendVerifyAccountOtp(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Send Verify Account OTP Success");
        AppUtility.showSnackBar(
          StringValues.otpSendSuccessful,
          StringValues.success,
        );
        RouteManagement.goToBack();
        RouteManagement.goToVerifyAccountView();
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Send Verify Account OTP Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Verify Account OTP Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Verify Account OTP Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Verify Account OTP Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Verify Account OTP Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _verifyAccount(String otp) async {
    if (otp.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': emailTextController.text.trim(),
      'otp': otp,
    };

    AppUtility.printLog("Verify Account Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyAccount(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _clearTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Verify Account Success");
        RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtility.showSnackBar(
          StringValues.verifyAccountSuccessful,
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Verify Account Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Account Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Account Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Account Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Account Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> sendVerifyAccountOtp() async {
    AppUtility.closeFocus();
    await _sendVerifyAccountOtp(emailTextController.text.trim());
  }

  Future<void> verifyAccount() async {
    AppUtility.closeFocus();
    await _verifyAccount(otpTextController.text.trim());
  }
}
