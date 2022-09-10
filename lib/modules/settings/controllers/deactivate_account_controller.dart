import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class DeactivateAccountController extends GetxController {
  static DeactivateAccountController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _showPassword = true.obs;
  final passwordTextController = TextEditingController();
  final FocusScopeNode focusNode = FocusScopeNode();

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _deactivateAccount() async {
    if (passwordTextController.text.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': profile.profileDetails.user!.email,
      "password": passwordTextController.text.trim(),
    };

    AppUtils.printLog("Deactivate Account Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.deactivateAccount(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog("Deactivate Account Success");
        await _auth.logout(showLoading: false);
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToWelcomeView();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Deactivate Account Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Deactivate Account Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Deactivate Account Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Deactivate Account Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Deactivate Account Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> deactivateAccount() async {
    AppUtils.closeFocus();
    await _deactivateAccount();
  }
}
