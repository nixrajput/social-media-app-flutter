import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class GenderController extends GetxController {
  static GenderController get find => Get.find();

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
    if (_profile.profileDetails.user != null) {
      var user = _profile.profileDetails.user!;
      setGender = user.gender ?? '';
    }
  }

  Future<void> _updateGender(String gender) async {
    if (gender.isEmpty) {
      return;
    }

    final body = {
      'gender': gender,
    };

    AppUtils.printLog("Update Gender Request...");
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

  Future<void> updateGender() async {
    AppUtils.closeFocus();
    if (_gender.value.isEmpty) {
      return;
    }
    if (_gender.value == _profile.profileDetails.user!.gender) {
      return;
    }
    await _updateGender(_gender.value.trim());
  }
}
