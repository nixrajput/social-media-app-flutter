import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class EditProfessionController extends GetxController {
  static EditProfessionController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _profession = ''.obs;
  final FocusScopeNode focusNode = FocusScopeNode();
  final _isLoading = false.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  String get profession => _profession.value;

  /// Setters
  set setProfession(String profession) => _profession.value = profession;

  void onProfessionChanged(value) {
    setProfession = value;
    update();
  }

  @override
  void onInit() {
    initializeFields();
    super.onInit();
  }

  void initializeFields() async {
    if (_profile.profileDetails!.user != null &&
        _profile.profileDetails!.user!.profession != null) {
      var user = _profile.profileDetails!.user!;
      if (StaticData.occupationList.contains(user.profession!.toLowerCase())) {
        onProfessionChanged(user.profession);
      } else {
        onProfessionChanged(StaticData.occupationList.first);
      }
    }
  }

  Future<void> _updateProfession(String profession) async {
    if (profession.isEmpty ||
        profession.toLowerCase() == StringValues.profession.toLowerCase()) {
      AppUtility.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }

    final body = {'profession': profession};

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
          decodedData['message'],
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

  Future<void> updateProfession() async {
    AppUtility.closeFocus();
    if (_profession.value == _profile.profileDetails!.user!.profession) {
      return;
    }
    await _updateProfession(_profession.value.trim());
  }
}
