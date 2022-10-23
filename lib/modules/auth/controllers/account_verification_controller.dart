import 'dart:async';

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

    final body = {'email': email};

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendVerifyAccountOtp(body);

      if (response.isSuccessful) {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        RouteManagement.goToBack();
        RouteManagement.goToVerifyAccountView();
        AppUtility.showSnackBar(
          StringValues.otpSendSuccessful,
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

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyAccount(body);

      if (response.isSuccessful) {
        _clearTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtility.showSnackBar(
          StringValues.verifyAccountSuccessful,
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

  Future<void> sendVerifyAccountOtp() async {
    AppUtility.closeFocus();
    await _sendVerifyAccountOtp(emailTextController.text.trim());
  }

  Future<void> verifyAccount() async {
    AppUtility.closeFocus();
    await _verifyAccount(otpTextController.text.trim());
  }
}
