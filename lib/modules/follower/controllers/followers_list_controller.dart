import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/follower.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/follower_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class FollowersListController extends GetxController {
  static FollowersListController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _followersData = const FollowerResponse().obs;
  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _userId = ''.obs;
  final List<Follower> _followersList = [];

  final searchTextController = TextEditingController();

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  FollowerResponse? get followersData => _followersData.value;

  String? get userId => _userId.value;

  List<Follower> get followersList => _followersList;

  /// Setters
  set setFollowersListData(FollowerResponse value) {
    _followersData.value = value;
  }

  @override
  void onInit() async {
    _userId.value = Get.arguments;
    super.onInit();
    await _getFollowersList();
  }

  Future<void> _getFollowersList() async {
    if (_userId.value.isEmpty) {
      AppUtility.log('User id is empty', tag: 'error');
      return;
    }

    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getFollowers(_auth.token, _userId.value);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setFollowersListData = FollowerResponse.fromJson(decodedData);
        _followersList.clear();
        _followersList.addAll(_followersData.value.results!);
        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    if (_userId.value.isEmpty) {
      AppUtility.log('User id is empty', tag: 'error');
      return;
    }

    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowers(
        _auth.token,
        _userId.value,
        page: page,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setFollowersListData = FollowerResponse.fromJson(decodedData);
        _followersList.addAll(_followersData.value.results!);
        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _searchFollowers(String searchText) async {
    if (searchText.isEmpty) {
      await _getFollowersList();
      return;
    }

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.searchFollowers(
        _auth.token,
        _userId.value,
        searchText,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setFollowersListData = FollowerResponse.fromJson(decodedData);
        _followersList.clear();
        _followersList.addAll(_followersData.value.results!);
        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
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
        profile.fetchProfileDetails(fetchPost: false);
        return;
      } else {
        user.followingStatus = "notFollowing";
        update();
        profile.fetchProfileDetails(fetchPost: false);
        return;
      }
    }
  }

  Future<void> _followUnfollowUser(User user) async {
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.followUnfollowUser(_auth.token, user.id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
      } else {
        final decodedData = response.data;
        _toggleFollowUser(user);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
          duration: 2,
        );
      }
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _cancelFollowRequest(User user) async {
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.cancelFollowRequest(_auth.token, user.id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
      } else {
        final decodedData = response.data;
        _toggleFollowUser(user);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> followUnfollowUser(User user) async =>
      await _followUnfollowUser(user);

  Future<void> cancelFollowRequest(User user) async =>
      await _cancelFollowRequest(user);

  Future<void> getFollowersList() async => await _getFollowersList();

  Future<void> loadMore() async =>
      await _loadMore(page: _followersData.value.currentPage! + 1);

  Future<void> searchFollowers(String searchText) async =>
      await _searchFollowers(searchText);
}
