import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class EditUsernameController extends GetxController {
  static EditUsernameController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _isUnameAvailable = ''.obs;
  final _username = ''.obs;

  bool get isLoading => _isLoading.value;

  String get isUnameAvailable => _isUnameAvailable.value;

  String get username => _username.value;

  set setUsername(String username) {
    _username.value = username;
    update();
  }

  @override
  void onInit() {
    ever(_username, checkUsername);
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_profile.profileDetails!.user != null) {
      var user = _profile.profileDetails!.user!;
      setUsername = user.uname;
    }
  }

  Future<void> _checkUsername(String uname) async {
    if (uname.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      _isUnameAvailable.value = StringValues.none;
      update();
      return;
    }

    if (uname == _profile.profileDetails!.user!.uname) {
      _isUnameAvailable.value = StringValues.none;
      update();
      return;
    }

    try {
      final response = await _apiProvider.checkUsername(_auth.token, uname);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.printLog(decodedData);
        _isUnameAvailable.value = StringValues.success;
        update();
      } else {
        final decodedData = response.data;
        AppUtility.log(decodedData['message'], tag: 'error');
        _isUnameAvailable.value = StringValues.error;
        update();
      }
    } catch (exc) {
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _updateUname(String uname) async {
    if (uname.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      return;
    }

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.changeUsername(_auth.token, uname);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _profile.fetchProfileDetails(fetchPost: false);
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
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
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> updateUsername() async {
    AppUtility.closeFocus();
    if (_username.value.isEmpty) {
      return;
    }
    if (_username.value == _profile.profileDetails!.user!.uname.trim()) {
      return;
    }
    if (_isUnameAvailable.value == StringValues.error) {
      return;
    }
    await _updateUname(
      _username.value.trim(),
    );
  }

  Future<void> checkUsername(String username) async {
    await _checkUsername(username.trim());
  }
}
