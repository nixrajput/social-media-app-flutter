import 'dart:async';

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
    var isExists = await HiveService.hasLength<User>('recommendedUsers');
    if (isExists) {
      var data = await HiveService.getAll<User>('recommendedUsers');
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _recommendedUsersList.clear();
      _recommendedUsersList.addAll(data.toList());
    }
    _isLoading.value = false;
    update();
    await _getUsers();
  }

  Future<void> _getUsers() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getRecommendedUsers(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.clear();
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        for (var item in _recommendedUsersData.value.results!) {
          await HiveService.put<User>(
            'recommendedUsers',
            item.id,
            item,
          );
        }
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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getRecommendedUsers(_auth.token, page: page);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        for (var item in _recommendedUsersData.value.results!) {
          await HiveService.put<User>(
            'recommendedUsers',
            item.id,
            item,
          );
        }
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
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _searchUsers(String searchText) async {
    if (searchText.isEmpty) {
      await _getUsers();
      return;
    }

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.searchUser(_auth.token, searchText);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.clear();
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
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
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.followUnfollowUser(_auth.token, user.id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _profile.fetchProfileDetails(fetchPost: false);
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
      _isLoading.value = false;
      update();
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
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
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
