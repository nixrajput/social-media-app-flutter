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
import 'package:social_media_app/helpers/validators.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class EditWebsiteController extends GetxController {
  static EditWebsiteController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _website = ''.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  String get website => _website.value;

  /// Setters
  set setWebsite(String value) => _website.value = value;

  void onChangeWebsite(String url) {
    setWebsite = url;
    update();
  }

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_profile.profileDetails.user != null) {
      var user = _profile.profileDetails.user!;
      setWebsite = user.website ?? '';
    }
  }

  Future<void> _updateWebsite(String website) async {
    if (website.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterWebsiteUrl,
        StringValues.warning,
      );
      return;
    }

    final body = {'website': website};

    AppUtils.printLog("Update Website Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _profile.fetchProfileDetails(fetchPost: false);
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Update Website Success");
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Update Website Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Website Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Website Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Website Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Update Website Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> updateWebsite() async {
    AppUtils.closeFocus();
    if (_website.value.isEmpty) {
      return;
    }
    if (_website.value == _profile.profileDetails.user!.website?.trim()) {
      return;
    }
    if (!Validators.isValidUrl(_website.value)) {
      AppUtils.showSnackBar(
        StringValues.enterValidUrl,
        StringValues.warning,
      );
      return;
    }

    await _updateWebsite(_website.value.trim());
  }
}