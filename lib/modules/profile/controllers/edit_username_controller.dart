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
    if (_profile.profileDetails.user != null) {
      var user = _profile.profileDetails.user!;
      setUsername = user.uname;
    }
  }

  Future<void> _checkUsername(String uname) async {
    if (uname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      _isUnameAvailable.value = StringValues.none;
      update();
      return;
    }

    if (uname == _profile.profileDetails.user!.uname) {
      _isUnameAvailable.value = StringValues.none;
      update();
      return;
    }

    AppUtils.printLog("Check Username Request");

    try {
      final response = await _apiProvider.checkUsername(_auth.token, uname);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog(decodedData);
        _isUnameAvailable.value = StringValues.success;
        update();
        AppUtils.printLog("Check Username Success");
      } else {
        AppUtils.printLog(decodedData);
        _isUnameAvailable.value = StringValues.error;
        update();
        AppUtils.printLog("Check Username Error");
      }
    } on SocketException {
      AppUtils.printLog("Check Username Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog("Check Username Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog("Check Username Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog("Check Username Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
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

    AppUtils.printLog("Update Username Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.changeUsername(_auth.token, uname);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _profile.fetchProfileDetails(fetchPost: false);
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Update Username Success");
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Update Username Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Username Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Username Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Username Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Username Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> updateUsername() async {
    AppUtils.closeFocus();
    if (_username.value.isEmpty) {
      return;
    }
    if (_username.value == _profile.profileDetails.user!.uname.trim()) {
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
