import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class UserController extends GetxController {
  static UserController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(http.Client());

  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();
  final countryCodeTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final aboutTextController = TextEditingController();

  final unameTextController = TextEditingController();

  final oldPasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  @override
  void onInit() {
    initializeProfileDetails();
    super.onInit();
  }

  Future<void> initializeProfileDetails() async {
    if (_auth.userData.user != null) {
      if (kDebugMode) {
        print('initializing fields');
      }
      var user = _auth.userData.user!;
      fNameTextController.text = user.fname;
      lNameTextController.text = user.lname;
      unameTextController.text = user.uname;
      aboutTextController.text = user.about ?? '';
    }
  }

  Future<void> _uploadProfilePicture(avatar) async {
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.uploadProfilePicture(avatar, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.getProfileDetails();
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _changePassword(
    String oldPassword,
    String newPassword,
    String confPassword,
  ) async {
    if (oldPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterOldPassword,
        StringValues.warning,
      );
      return;
    }
    if (newPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterNewPassword,
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
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confPassword,
    };

    _isLoading.value = true;
    await AppOverlay.showLoadingIndicator();
    update();

    try {
      final response = await _apiProvider.changePassword(body, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.logout();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
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
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _followUnfollowUser(String userId) async {
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.followUnfollowUser(userId, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.getProfileDetails();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> uploadProfilePicture(avatar) async {
    AppUtils.closeFocus();
    await _uploadProfilePicture(avatar);
  }

  Future<void> followUnfollowUser(String userId) async {
    AppUtils.closeFocus();
    await _followUnfollowUser(userId);
  }

  Future<void> changePassword() async {
    AppUtils.closeFocus();
    await _changePassword(
      oldPasswordTextController.text.trim(),
      newPasswordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
