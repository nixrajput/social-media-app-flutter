import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/follower_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class FollowersListController extends GetxController {
  static FollowersListController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _followersList = FollowerListResponse().obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  FollowerListResponse? get followersList => _followersList.value;

  set setFollowersListData(FollowerListResponse value) {
    _followersList.value = value;
  }

  Future<void> _getFollowersList() async {
    var userId = Get.arguments;

    if (userId == null) {
      return;
    }

    AppUtils.printLog("Get Followers List Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowers(_auth.token, userId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowersListData = FollowerListResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getFollowersList() async {
    await _getFollowersList();
  }

  @override
  void onInit() async {
    super.onInit();
    await _getFollowersList();
  }
}
