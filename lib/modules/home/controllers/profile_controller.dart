import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/blocked_users_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/models/responses/profile_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/hive_box_names.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/utils/utility.dart';

class ProfileController extends GetxController {
  final _apiProvider = ApiProvider(http.Client());
  final _auth = AuthService.find;
  final List<User> _blockedUsers = [];
  final _blockedUsersResponse = const BlockedUsersResponse().obs;
  var _isLoading = false;
  final _isMorePostLoading = false.obs;
  final _isPostLoading = false.obs;
  final _loadingBlockedUsers = false.obs;
  final _loadingMoreBlockedUsers = false.obs;
  final _postData = PostResponse().obs;
  final List<Post> _postList = [];
  final _profileDetails = const ProfileResponse().obs;

  static ProfileController get find => Get.find();

  /// Getters
  bool get isLoading => _isLoading;

  bool get isPostLoading => _isPostLoading.value;

  bool get isMorePostLoading => _isMorePostLoading.value;

  bool get loadingBlockedUsers => _loadingBlockedUsers.value;

  bool get loadingMoreBlockedUsers => _loadingMoreBlockedUsers.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  List<User> get blockedUsers => _blockedUsers;

  ProfileResponse? get profileDetails => _profileDetails.value;

  BlockedUsersResponse? get blockedUsersResponse => _blockedUsersResponse.value;

  /// Setters
  set setPostData(PostResponse value) => _postData.value = value;

  set setProfileDetailsData(ProfileResponse value) =>
      _profileDetails.value = value;

  set setBlockedUsersResponse(BlockedUsersResponse value) =>
      _blockedUsersResponse.value = value;

  Future<void> unblockUser(String userId) async => await _unblockUser(userId);

  Future<void> followUnfollowUser(User user) async =>
      await _followUnfollowUser(user);

  Future<void> cancelFollowRequest(User user) async =>
      await _cancelFollowRequest(user);

  Future<void> fetchProfileDetails({bool fetchPost = true}) async =>
      await _fetchProfileDetails(fetchPost: fetchPost);

  Future<bool> loadProfileDetails() async => await _loadProfileDetails();

  Future<void> fetchProfilePosts() async => await _fetchProfilePosts();

  Future<void> fetchBlockedUsers() async => await _fetchBlockedUsers();

  Future<void> loadMoreBlockedUsers() async => await _fetchMoreBlockedUsers();

  Future<void> loadMorePosts() async =>
      await _loadMoreProfilePosts(page: _postData.value.currentPage! + 1);

  Future<void> updateProfile(Map<String, dynamic> details,
          {bool? showLoading}) async =>
      await _updateProfile(details, showLoading: showLoading);

  Future<void> applyForBlueTick(Map<String, dynamic> details) async =>
      await _applyForBlueTick(details);

  Future<void> _saveProfileDataToLocalStorage(ProfileResponse respone) async {
    var data = jsonEncode(respone.toJson());
    await StorageService.write('profileData', data);
    AppUtility.log('Profile data saved to local storage');
  }

  Future<ProfileResponse?> _readProfileDataFromLocalStorage() async {
    var hasData = await StorageService.hasData('profileData');

    if (hasData) {
      AppUtility.log('Profile data found in local storage');
      var data = StorageService.read('profileData');
      return ProfileResponse.fromJson(jsonDecode(data));
    } else {
      AppUtility.log('Profile data not found in local storage', tag: 'error');
      return null;
    }
  }

  Future<void> _saveProfilePostsToLocalStorage(List<Post> posts) async {
    AppUtility.log('Saving profile posts to local storage');

    if (posts.isEmpty) {
      AppUtility.log('No posts found to save', tag: 'error');
      return;
    }

    for (var item in posts) {
      await HiveService.put<Post>(
        HiveBoxNames.profilePosts,
        item.id,
        item,
      );
    }
    AppUtility.log('Profile posts saved to local storage');
  }

  Future<void> _saveBlockedUsersToLocalStorage(List<User> users) async {
    AppUtility.log('Saving blocked users to local storage');

    if (users.isEmpty) {
      AppUtility.log('No users found to save');
      return;
    }

    for (var item in users) {
      await HiveService.put<User>(
        HiveBoxNames.blockedUsers,
        item.id,
        item,
      );
    }
    AppUtility.log('Blocked Users saved to local storage');
  }

  Future<List<Post>?> _readProfilePostsFromLocalStorage() async {
    AppUtility.log('Loading User Posts From Local Storage');
    var isExists = await HiveService.hasLength<Post>(HiveBoxNames.profilePosts);
    if (isExists) {
      var data = await HiveService.getAll<Post>(HiveBoxNames.profilePosts);
      data.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      AppUtility.log('User Posts From Local Storage Loaded');
      return data;
    }
    AppUtility.log('User Posts From Local Storage Loaded');
    return null;
  }

  static Future<List<User>?> _readPBlockedUsersFromLocalStorage() async {
    AppUtility.log('Loading Blocked Users From Local Storage');
    var isExists = await HiveService.hasLength<User>(HiveBoxNames.blockedUsers);
    if (isExists) {
      var data = await HiveService.getAll<User>(HiveBoxNames.blockedUsers);
      data.sort((a, b) => b.uname.compareTo(a.uname));
      AppUtility.log('Blocked Users From Local Storage Loaded');
      return data;
    }
    AppUtility.log('Blocked Users From Local Storage Loaded');
    return null;
  }

  Future<bool> _loadProfileDetails() async {
    AppUtility.log("Loading Profile Details");

    final decodedData = await _readProfileDataFromLocalStorage();

    if (decodedData != null) {
      setProfileDetailsData = decodedData;

      final profilePosts = await _readProfilePostsFromLocalStorage();
      final blockedUsers = await _readPBlockedUsersFromLocalStorage();

      if (profilePosts != null) {
        _postList.clear();
        _postList.addAll(profilePosts);
      }

      if (blockedUsers != null) {
        _blockedUsers.clear();
        _blockedUsers.addAll(blockedUsers);
      }

      return true;
    } else {
      AppUtility.log("Failed To Load Profile Details From Local Storage",
          tag: 'error');
      await _auth.deleteAllLocalDataAndCache();
      return false;
    }
  }

  Future<void> _fetchProfileDetails({bool fetchPost = true}) async {
    _isLoading = true;
    update();

    try {
      final response = await _apiProvider.getProfileDetails(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setProfileDetailsData = ProfileResponse.fromJson(decodedData);
        await _saveProfileDataToLocalStorage(_profileDetails.value);
        await _fetchBlockedUsers();
        _isLoading = false;
        update();
        if (fetchPost) await _fetchProfilePosts();
      } else {
        final decodedData = response.data;
        _isLoading = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading = false;
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
    } else {
      if (user.followingStatus == "notFollowing") {
        user.followingStatus = "following";
        fetchProfileDetails(fetchPost: false);
        update();
        return;
      } else {
        user.followingStatus = "notFollowing";
        fetchProfileDetails(fetchPost: false);
        update();
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
        await _fetchProfileDetails(fetchPost: false);
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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _fetchProfilePosts() async {
    _isPostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _profileDetails.value.user!.id,
        limit: 12,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        await _saveProfilePostsToLocalStorage(_postData.value.results!);
        _isPostLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isPostLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isPostLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMoreProfilePosts({int? page}) async {
    _isMorePostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _profileDetails.value.user!.id,
        page: page,
        limit: 12,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        await _saveProfilePostsToLocalStorage(_postData.value.results!);
        _isMorePostLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMorePostLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isMorePostLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _updateProfile(Map<String, dynamic> details,
      {bool? showLoading = false}) async {
    if (details.isEmpty) {
      AppUtility.printLog("No Data To Update");
      return;
    }

    final body = details;

    if (showLoading == true) {
      AppUtility.showLoadingDialog();
    }

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _fetchProfileDetails(fetchPost: false);
        if (showLoading == true) {
          AppUtility.closeDialog();
        }
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        if (showLoading == true) {
          AppUtility.closeDialog();
        }
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      if (showLoading == true) {
        AppUtility.closeDialog();
      }
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> _applyForBlueTick(Map<String, dynamic> details) async {
    if (details.isEmpty) {
      AppUtility.printLog("Please enter required details");
      return;
    }

    final body = details;

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> _fetchBlockedUsers() async {
    _loadingBlockedUsers.value = true;
    update();

    try {
      final response = await _apiProvider.getBlockedUsers(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setBlockedUsersResponse = BlockedUsersResponse.fromJson(decodedData);
        _blockedUsers.clear();
        _blockedUsers.addAll(_blockedUsersResponse.value.results!);
        _loadingBlockedUsers.value = false;
        update();
        await _saveBlockedUsersToLocalStorage(
            _blockedUsersResponse.value.results!);
      } else {
        final decodedData = response.data;
        _loadingBlockedUsers.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _loadingBlockedUsers.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _fetchMoreBlockedUsers() async {
    _loadingMoreBlockedUsers.value = true;
    update();

    try {
      final response = await _apiProvider.getBlockedUsers(
        _auth.token,
        page: _blockedUsersResponse.value.currentPage! + 1,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setBlockedUsersResponse = BlockedUsersResponse.fromJson(decodedData);
        _blockedUsers.addAll(_blockedUsersResponse.value.results!);
        _loadingMoreBlockedUsers.value = false;
        update();
        await _saveBlockedUsersToLocalStorage(
            _blockedUsersResponse.value.results!);
      } else {
        final decodedData = response.data;
        _loadingMoreBlockedUsers.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _loadingMoreBlockedUsers.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _unblockUser(String userId) async {
    if (userId.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.userIdNotFound,
        StringValues.warning,
      );
      return;
    }

    try {
      final response = await _apiProvider.unblockUser(_auth.token, userId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _blockedUsers.removeWhere((element) => element.id == userId);
        update();
        await HiveService.delete<User>(HiveBoxNames.blockedUsers, userId);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }
}
