import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/validators.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

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
    if (_profile.profileDetails!.user != null) {
      var user = _profile.profileDetails!.user!;
      setWebsite = user.website ?? '';
    }
  }

  Future<void> _updateWebsite(String website) async {
    if (website.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterWebsiteUrl,
        StringValues.warning,
      );
      return;
    }

    final body = {'website': website};

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

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
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> updateWebsite() async {
    AppUtility.closeFocus();
    if (_website.value.isEmpty) {
      return;
    }
    if (_website.value == _profile.profileDetails!.user!.website?.trim()) {
      return;
    }
    if (!Validators.isValidUrl(_website.value)) {
      AppUtility.showSnackBar(
        StringValues.enterValidUrl,
        StringValues.warning,
      );
      return;
    }

    await _updateWebsite(_website.value.trim());
  }
}
