import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/profile_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class ProfileController extends GetxController {
  static ProfileController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  var _isLoading = false;
  ProfileResponse _profileData = const ProfileResponse();

  bool get isLoading => _isLoading;

  ProfileResponse get profileData => _profileData;

  set setProfileData(ProfileResponse value) => _profileData = value;

  Future<bool> _getProfileDetails() async {
    AppUtils.printLog("Fetching Local Profile Details...");

    final decodedData = await AppUtils.readProfileDataFromLocalStorage();
    if (decodedData != null) {
      setProfileData = ProfileResponse.fromJson(decodedData);
      return true;
    } else {
      AppUtils.printLog(StringValues.profileDetailsNotFound);
    }
    return false;
  }

  Future<void> _fetchProfileDetails() async {
    _isLoading = true;
    update();
    AppUtils.printLog("Fetching Profile Details Request...");
    try {
      final response = await _apiProvider.getProfileDetails(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setProfileData = ProfileResponse.fromJson(decodedData);
        await AppUtils.saveProfileDataToLocalStorage(decodedData);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleFollowUser(String userId) {
    if (_profileData.user!.following.contains(userId)) {
      _profileData.user!.following.remove(userId);
    } else {
      _profileData.user!.following.add(userId);
    }
    update();
  }

  Future<void> _followUnfollowUser(String userId) async {
    AppUtils.printLog("Follow/Unfollow User Request...");
    _toggleFollowUser(userId);

    try {
      final response =
          await _apiProvider.followUnfollowUser(userId, _auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        _toggleFollowUser(userId);
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(userId);
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> followUnfollowUser(String userId) async {
    await _followUnfollowUser(userId);
  }

  Future<void> fetchProfileDetails() async => await _fetchProfileDetails();

  Future<bool> getProfileDetails() async => await _getProfileDetails();
}
