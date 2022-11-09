import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class EditGenderController extends GetxController {
  static EditGenderController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _gender = ''.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String get gender => _gender.value;

  set setGender(String gender) {
    _gender.value = gender;
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
      setGender = user.gender ?? '';
    }
  }

  Future<void> _updateGender(String gender) async {
    if (gender.isEmpty) {
      return;
    }

    final body = {'gender': gender};

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

  Future<void> updateGender() async {
    AppUtility.closeFocus();
    if (_gender.value.isEmpty) {
      return;
    }
    if (_gender.value == _profile.profileDetails!.user!.gender) {
      return;
    }
    await _updateGender(_gender.value.trim());
  }
}
