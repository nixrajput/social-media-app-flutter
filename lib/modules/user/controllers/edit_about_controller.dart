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

class AboutController extends GetxController {
  static AboutController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(http.Client());

  final aboutTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_auth.profileData.user != null) {
      var user = _auth.profileData.user!;
      aboutTextController.text = user.about ?? '';
    }
  }

  Future<void> _updateAbout(String about) async {
    final body = {'about': about};

    await AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.updateProfileDetails(body, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.getProfileDetails();
        await AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          StringValues.updateProfileSuccessful,
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

  Future<void> updateAbout() async {
    AppUtils.closeFocus();
    await _updateAbout(aboutTextController.text.trim());
  }
}
