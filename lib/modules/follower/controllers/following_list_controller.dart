import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/follower.dart';
import 'package:social_media_app/apis/models/responses/follower_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class FollowingListController extends GetxController {
  static FollowingListController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _followingData = const FollowerResponse().obs;
  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;

  final List<Follower> _followingList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  FollowerResponse? get followingData => _followingData.value;

  List<Follower> get followingList => _followingList;

  set setFollowingListData(FollowerResponse value) {
    _followingData.value = value;
  }

  Future<void> _getFollowingList() async {
    var userId = Get.arguments;

    if (userId == null) {
      return;
    }

    AppUtility.printLog("Get Following List Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowings(_auth.token, userId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowingListData = FollowerResponse.fromJson(decodedData);
        _followingList.clear();
        _followingList.addAll(_followingData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Following List Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Following List Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Following List Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Following List Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Following List Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Following List Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    var userId = Get.arguments;

    if (userId == null) {
      return;
    }

    AppUtility.printLog("Get More Following List Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowings(
        _auth.token,
        userId,
        page: page,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowingListData = FollowerResponse.fromJson(decodedData);
        _followingList.addAll(_followingData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Get More Following List Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Get More Following List Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Get More Following List Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Get More Following List Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Get More Following List Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Get More Following List Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getFollowingList() async => await _getFollowingList();

  Future<void> loadMore() async =>
      await _loadMore(page: _followingData.value.currentPage! + 1);

  @override
  void onInit() async {
    await _getFollowingList();
    super.onInit();
  }
}
