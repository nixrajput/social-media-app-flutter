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

class DOBController extends GetxController {
  static DOBController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final dobTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_profile.profileDetails.user != null) {
      var user = _profile.profileDetails.user!;
      dobTextController.text = user.dob ?? '';
    }
  }

  Future<void> _updateDOB(String dob) async {
    if (dob.isEmpty) {
      return;
    }

    final body = {
      'dob': dob,
    };

    AppUtils.printLog("Update DOB Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

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

  Future<void> updateDOB() async {
    AppUtils.closeFocus();
    if (dobTextController.text.trim() == _profile.profileDetails.user!.dob) {
      return;
    }
    await _updateDOB(dobTextController.text.trim());
  }
}
