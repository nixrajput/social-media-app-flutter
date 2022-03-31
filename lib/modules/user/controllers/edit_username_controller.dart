import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/routes/route_management.dart';

class UsernameController extends GetxController {
  static UsernameController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(http.Client());

  final uNameTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_auth.userData.user != null) {
      var user = _auth.userData.user!;
      uNameTextController.text = user.uname;
    }
  }

  Future<void> _checkUsername(String uname) async {
    if (uname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      return;
    }

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.checkUsernameAvailability(uname, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
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

  Future<void> _updateUname(String uname) async {
    if (uname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      return;
    }

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.updateUsername(uname, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.getProfileDetails();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
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

  Future<void> updateUsername() async {
    AppUtils.closeFocus();
    await _updateUname(
      uNameTextController.text.trim(),
    );
  }

  Future<void> checkUsername() async {
    AppUtils.closeFocus();
    await _checkUsername(
      uNameTextController.text.trim(),
    );
  }
}
