import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/user_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class RecommendedUsersController extends GetxController {
  static RecommendedUsersController get find => Get.find();

  final _auth = AuthService.find;
  final _profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());
  final _hiveService = HiveService();

  final _recommendedUsersData = const UserListResponse().obs;
  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final List<User> _recommendedUsersList = [];

  final searchTextController = TextEditingController();

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  UserListResponse? get recommendedUsersData => _recommendedUsersData.value;

  List<User> get recommendedUsersList => _recommendedUsersList;

  /// Setters
  set setRecommendedUsersData(UserListResponse value) =>
      _recommendedUsersData.value = value;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  _getData() async {
    _isLoading.value = true;
    update();
    var isExists = await _hiveService.isExists(boxName: 'recommendedUsers');

    if (isExists) {
      var data = await _hiveService.getBox('recommendedUsers');
      var cachedData = jsonDecode(data);
      setRecommendedUsersData = UserListResponse.fromJson(cachedData);
      _recommendedUsersList.clear();
      _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
    }
    _isLoading.value = false;
    update();
    await _getUsers();
  }

  Future<void> _getUsers() async {
    AppUtility.printLog("Get Recommended Users Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getRecommendedUsers(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.clear();
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        await _hiveService.addBox('recommendedUsers', jsonEncode(decodedData));
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Recommended Users Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Recommended Users Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Recommended Users Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getRecommendedUsers(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Recommended Users Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Recommended Users Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _searchUsers(String searchText) async {
    if (searchText.isEmpty) {
      await _getUsers();
      return;
    }

    AppUtility.printLog("Search Users Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.searchUser(_auth.token, searchText);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.clear();
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Search Users Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Search Users Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Users Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Users Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Users Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Users Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleFollowUser(User user) {
    if (user.isPrivate) {
      if (user.followingStatus == "notFollowing") {
        user.followingStatus = "requested";
        update();
        return;
      }
      if (user.followingStatus == "requested") {
        user.followingStatus = "notFollowing";
        update();
        return;
      }
      if (user.followingStatus == "following") {
        user.followingStatus = "notFollowing";
        update();
        return;
      }
    } else {
      if (user.followingStatus == "notFollowing") {
        user.followingStatus = "following";
        update();
        _profile.fetchProfileDetails(fetchPost: false);
        return;
      } else {
        user.followingStatus = "notFollowing";
        update();
        _profile.fetchProfileDetails(fetchPost: false);
        return;
      }
    }
  }

  Future<void> _followUnfollowUser(User user) async {
    AppUtility.printLog("Follow/Unfollow User Request");
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.followUnfollowUser(_auth.token, user.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _profile.fetchProfileDetails(fetchPost: false);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
        AppUtility.printLog("Follow/Unfollow User Success");
      } else {
        _toggleFollowUser(user);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Follow/Unfollow User Error");
      }
    } on SocketException {
      _toggleFollowUser(user);
      AppUtility.printLog("Follow/Unfollow User Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(user);
      AppUtility.printLog("Follow/Unfollow User Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(user);
      AppUtility.printLog("Follow/Unfollow User Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtility.printLog("Follow/Unfollow User Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _cancelFollowRequest(User user) async {
    AppUtility.printLog("Cancel Follow Request");
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.cancelFollowRequest(_auth.token, user.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        AppUtility.printLog("Cancel FollowRequest Success");
      } else {
        _toggleFollowUser(user);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Cancel FollowRequest Error");
      }
    } on SocketException {
      _toggleFollowUser(user);
      AppUtility.printLog("Cancel FollowRequest Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(user);
      AppUtility.printLog("Cancel FollowRequest Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(user);
      AppUtility.printLog("Cancel FollowRequest Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtility.printLog("Cancel FollowRequest Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getUsers() async => await _getUsers();

  Future<void> searchUsers(String searchText) async =>
      await _searchUsers(searchText);

  Future<void> loadMore() async =>
      await _loadMore(page: _recommendedUsersData.value.currentPage! + 1);

  Future<void> followUnfollowUser(User user) async =>
      await _followUnfollowUser(user);

  Future<void> cancelFollowRequest(User user) async =>
      await _cancelFollowRequest(user);
}
