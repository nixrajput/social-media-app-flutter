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
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class NameController extends GetxController {
  static NameController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_profile.profileData.user != null) {
      var user = _profile.profileData.user!;
      fNameTextController.text = user.fname;
      lNameTextController.text = user.lname;
    }
  }

  Future<void> _updateName(
    String fname,
    String lname,
  ) async {
    if (fname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }

    if (lname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterLastName,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'fname': fname,
      'lname': lname,
    };

    AppUtils.printLog("Update Name Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.updateProfileDetails(body, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _profile.fetchProfileDetails();
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          StringValues.updateProfileSuccessful,
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> updateName() async {
    AppUtils.closeFocus();
    if (fNameTextController.text.trim() == _profile.profileData.user!.fname &&
        lNameTextController.text.trim() == _profile.profileData.user!.lname) {
      return;
    }
    await _updateName(
      fNameTextController.text.trim(),
      lNameTextController.text.trim(),
    );
  }
}
