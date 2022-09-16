import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ChangeEmailController extends GetxController {
  static ChangeEmailController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _otpSent = false.obs;
  final emailTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get otpSent => _otpSent.value;

  Future<void> _sendChangeEmailOtp(String email) async {
    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    if (profile.profileDetails.user!.email == email) {
      AppUtility.showSnackBar(
        StringValues.enterDifferentEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {'email': email};

    AppUtility.printLog("Send Change Email OTP Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendChangeEmailOtp(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Send Change Email OTP Success");
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
        AppUtility.printLog("Send Change Email OTP Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Email OTP Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Email OTP Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Email OTP Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Email OTP Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _changeEmail(String otp, String email) async {
    if (otp.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }
    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'otp': otp,
      'email': email,
    };

    AppUtility.printLog("Change Email Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.changeEmail(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Change Email Success");
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Change Email Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Email Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Email Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Email Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Email Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> changeEmail() async {
    AppUtility.closeFocus();
    await _changeEmail(
      otpTextController.text.trim(),
      emailTextController.text.trim(),
    );
  }

  Future<void> sendChangeEmailOtp() async {
    AppUtility.closeFocus();
    await _sendChangeEmailOtp(emailTextController.text.trim());
  }
}
