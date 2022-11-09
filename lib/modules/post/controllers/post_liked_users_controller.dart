import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/like_details.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/post_like_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class PostLikedUsersController extends GetxController {
  static PostLikedUsersController get find => Get.find();

  final _auth = AuthService.find;
  final _profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postLikedUsersData = const PostLikeResponse().obs;
  final List<LikeDetails> _postLikedUsersList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  PostLikeResponse get postLikedUsersData => _postLikedUsersData.value;

  List<LikeDetails> get postLikedUsersList => _postLikedUsersList;

  set setPostLikedUsersData(PostLikeResponse response) {
    _postLikedUsersData.value = response;
  }

  @override
  void onInit() {
    super.onInit();
    _fetchPostLikedUsers();
  }

  Future<void> _fetchPostLikedUsers() async {
    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getPostLikedUsers(_auth.token, postId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostLikedUsersData = PostLikeResponse.fromJson(decodedData);
        _postLikedUsersList.clear();
        _postLikedUsersList.addAll(_postLikedUsersData.value.results!);
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
    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getComments(
        _auth.token,
        postId,
        page: page,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostLikedUsersData = PostLikeResponse.fromJson(decodedData);
        _postLikedUsersList.addAll(_postLikedUsersData.value.results!);
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

  Future<void> fetchPostLikedUsers() async => await _fetchPostLikedUsers();

  Future<void> loadMore() async =>
      await _loadMore(page: _postLikedUsersData.value.currentPage! + 1);
}
