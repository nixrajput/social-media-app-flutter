import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/user_details_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class UserProfileController extends GetxController {
  static UserProfileController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _userProfile = UserDetailsResponse().obs;
  final _isLoading = false.obs;
  final _hasError = false.obs;
  final _error = ''.obs;

  bool get isLoading => _isLoading.value;

  bool get hasError => _hasError.value;

  UserDetailsResponse get userProfile => _userProfile.value;

  String? get error => _error.value;

  set setUserProfileData(UserDetailsResponse value) {
    _userProfile.value = value;
  }

  Future<void> _getUserProfileDetails() async {
    String userId = Get.arguments;

    if (userId.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.userIdNotFound,
        StringValues.error,
      );
      return;
    }

    AppUtils.printLog("Get User Profile Details Request...");
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getUserProfileDetails(userId, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setUserProfileData = UserDetailsResponse.fromJson(decodedData);
        _isLoading.value = false;
        _hasError.value = false;
        update();
      } else {
        _isLoading.value = false;
        _error.value = decodedData[StringValues.message];
        _hasError.value = true;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      _error.value = StringValues.internetConnError;
      _hasError.value = true;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      _error.value = StringValues.connTimedOut;
      _hasError.value = true;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      _error.value = StringValues.errorOccurred;
      _hasError.value = true;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      _error.value = StringValues.unknownErrorOccurred;
      _hasError.value = true;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getUserProfileDetails() async {
    await _getUserProfileDetails();
  }

  @override
  void onInit() async {
    await _getUserProfileDetails();
    super.onInit();
  }
}
