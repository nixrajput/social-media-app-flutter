import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  final _isLoading = false.obs;
  final _showPassword = true.obs;
  final _showConfirmPassword = true.obs;

  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  bool get showConfirmPassword => _showConfirmPassword.value;

  void _clearRegisterTextControllers() {
    fNameTextController.clear();
    lNameTextController.clear();
    emailTextController.clear();
    unameTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  void toggleViewConfirmPassword() {
    _showConfirmPassword(!_showConfirmPassword.value);
    update();
  }

  Future<void> _register(
    String fName,
    String lName,
    String email,
    String uname,
    String password,
    String confPassword,
  ) async {
    if (fName.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }
    if (lName.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterLastName,
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
    if (uname.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterUsername,
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
    if (confPassword.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'fname': fName,
      'lname': lName,
      'email': email,
      'uname': uname,
      'password': password,
      'confirmPassword': confPassword,
    };

    AppUtility.printLog("User Registration Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.register(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        _clearRegisterTextControllers();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("User Registration Success");
        AppUtility.showSnackBar(
          StringValues.registrationSuccessful,
          StringValues.success,
        );
        RouteManagement.goToBack();
        RouteManagement.goToSendVerifyAccountOtpView();
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("User Registration Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("User Registration Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("User Registration Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("User Registration Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("User Registration Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> register() async {
    AppUtility.closeFocus();
    await _register(
      fNameTextController.text.trim(),
      lNameTextController.text.trim(),
      emailTextController.text.trim(),
      unameTextController.text.trim(),
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
