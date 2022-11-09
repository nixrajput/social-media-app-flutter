import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/models/responses/profile_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/utils/utility.dart';

class ProfileController extends GetxController {
  static ProfileController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  var _isLoading = false;
  final _isPostLoading = false.obs;
  final _isMorePostLoading = false.obs;
  final _profileDetails = const ProfileResponse().obs;
  final _postData = PostResponse().obs;
  final List<Post> _postList = [];

  /// Getters
  bool get isLoading => _isLoading;

  bool get isPostLoading => _isPostLoading.value;

  bool get isMorePostLoading => _isMorePostLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  ProfileResponse? get profileDetails => _profileDetails.value;

  /// Setters
  set setPostData(PostResponse value) => _postData.value = value;

  set setProfileDetailsData(ProfileResponse value) =>
      _profileDetails.value = value;

  static Future<void> _saveProfileDataToLocalStorage(
      ProfileResponse respone) async {
    var data = jsonEncode(respone.toJson());
    await StorageService.write('profileData', data);
    AppUtility.log('Profile data saved to local storage');
  }

  static Future<ProfileResponse?> _readProfileDataFromLocalStorage() async {
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

  static Future<void> _saveProfilePostsToLocalStorage(List<Post> posts) async {
    AppUtility.log('Saving profile posts to local storage');

    if (posts.isEmpty) {
      AppUtility.log('No posts found to save', tag: 'error');
      return;
    }

    for (var item in posts) {
      await HiveService.put<Post>(
        'profilePosts',
        item.id,
        item,
      );
    }
    AppUtility.log('Profile posts saved to local storage');
  }

  static Future<List<Post>?> _readProfilePostsFromLocalStorage() async {
    var isExists = await HiveService.hasLength<Post>('profilePosts');
    if (isExists) {
      var data = await HiveService.getAll<Post>('profilePosts');
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return data;
    }
    return null;
  }

  Future<bool> _loadProfileDetails() async {
    AppUtility.log("Loading Profile Details");

    final decodedData = await _readProfileDataFromLocalStorage();

    if (decodedData != null) {
      setProfileDetailsData = decodedData;

      final profilePosts = await _readProfilePostsFromLocalStorage();

      if (profilePosts != null) {
        _postList.clear();
        _postList.addAll(profilePosts);
        await _fetchPosts();
        AppUtility.log("Profile Posts Loaded From Local Storage");
        return true;
      } else {
        AppUtility.log("Failed To Load Profile Posts From Local Storage",
            tag: 'error');
        return false;
      }
    } else {
      AppUtility.log("Failed To Load Profile Details From Local Storage",
          tag: 'error');
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
        _isLoading = false;
        update();
        if (fetchPost) await _fetchPosts();
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

  Future<void> _fetchPosts() async {
    _isPostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _profileDetails.value.user!.id,
        limit: 16,
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
        limit: 16,
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

  Future<void> _updateProfile(Map<String, dynamic> details) async {
    if (details.isEmpty) {
      AppUtility.printLog("No Data To Update");
      return;
    }

    final body = details;

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _fetchProfileDetails(fetchPost: false);
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

  Future<void> followUnfollowUser(User user) async =>
      await _followUnfollowUser(user);

  Future<void> cancelFollowRequest(User user) async =>
      await _cancelFollowRequest(user);

  Future<void> fetchProfileDetails({bool fetchPost = true}) async =>
      await _fetchProfileDetails(fetchPost: fetchPost);

  Future<bool> loadProfileDetails() async => await _loadProfileDetails();

  Future<void> fetchPosts() async => await _fetchPosts();

  Future<void> loadMore() async =>
      await _loadMoreProfilePosts(page: _postData.value.currentPage! + 1);

  Future<void> updateProfile(Map<String, dynamic> details) async =>
      await _updateProfile(details);
}
