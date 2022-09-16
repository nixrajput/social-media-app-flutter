import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class VerifyPasswordController extends GetxController {
  static VerifyPasswordController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final passwordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _showPassword = true.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _verifyPassword(String password) async {
    if (password.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    var cb = Get.arguments;

    AppUtility.printLog("Verify Password Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyPassword(_auth.token, password);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Verify Password Success");
        RouteManagement.goToBack();
        cb();
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Verify Password Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Password Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Password Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Password Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Verify Password Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> verifyPassword() async {
    AppUtility.closeFocus();
    await _verifyPassword(passwordTextController.text.trim());
  }
}
