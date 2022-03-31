import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

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

  bool get isLoading => _isLoading.value;

  void _clearRegisterTextControllers() {
    fNameTextController.clear();
    lNameTextController.clear();
    emailTextController.clear();
    unameTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
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
      AppUtils.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }
    if (lName.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterLastName,
        StringValues.warning,
      );
      return;
    }
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (uname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterUsername,
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
    if (confPassword.isEmpty) {
      AppUtils.showSnackBar(
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

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.register(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        _clearRegisterTextControllers();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.registrationSuccessful,
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

  Future<void> register() async {
    AppUtils.closeFocus();
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
