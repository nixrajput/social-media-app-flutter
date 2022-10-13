import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user_details.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/models/responses/user_details_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class UserDetailsController extends GetxController {
  static UserDetailsController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isPostLoading = false.obs;
  final _isMorePostLoading = false.obs;
  final _postData = PostResponse().obs;
  final _userDetails = const UserDetailsResponse().obs;
  final List<Post> _postList = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isPostLoading => _isPostLoading.value;

  bool get isMorePostLoading => _isMorePostLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  UserDetailsResponse? get userDetails => _userDetails.value;

  /// Setters
  set setPostData(PostResponse value) => _postData.value = value;

  set setUserDetails(UserDetailsResponse value) => _userDetails.value = value;

  @override
  void onInit() async {
    super.onInit();
    var type = Get.arguments[1];

    if (type == 'uid') {
      await _fetchUserDetailsById();
    } else {
      await _fetchUserDetailsByUsername();
    }
  }

  Future<void> _fetchUserDetailsById() async {
    var userId = Get.arguments[0];

    if (userId == null) {
      AppUtility.showSnackBar(
        StringValues.userIdNotFound,
        StringValues.error,
      );
      return;
    }

    AppUtility.printLog("Get User Profile Details Request...");
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getUserDetailsById(_auth.token, userId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setUserDetails = UserDetailsResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();

        /// Fetching Posts with conditions

        if (_userDetails.value.user!.accountStatus == "active") {
          if (_userDetails.value.user!.isPrivate) {
            if (_userDetails.value.user!.followingStatus == "following" ||
                _userDetails.value.user!.id ==
                    profile.profileDetails!.user!.id) {
              await _fetchUserPosts();
            }
          } else {
            await _fetchUserPosts();
          }
        }
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _fetchUserDetailsByUsername() async {
    var username = Get.arguments[0];

    if (username == null) {
      AppUtility.showSnackBar(
        StringValues.usernameNotFound,
        StringValues.error,
      );
      return;
    }

    AppUtility.printLog("Get User Profile Details Request...");
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getUserDetailsByUsername(_auth.token, username);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setUserDetails = UserDetailsResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();

        /// Fetching Posts with conditions

        if (_userDetails.value.user!.accountStatus == "active") {
          if (_userDetails.value.user!.isPrivate) {
            if (_userDetails.value.user!.followingStatus == "following" ||
                _userDetails.value.user!.id ==
                    profile.profileDetails!.user!.id) {
              await _fetchUserPosts();
            }
          } else {
            await _fetchUserPosts();
          }
        }
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _fetchUserPosts({int? page}) async {
    AppUtility.printLog("Fetching Profile Posts Request");
    _isPostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _userDetails.value.user!.id,
        page: page,
        limit: 12,
      );
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        _isPostLoading.value = false;
        update();
        AppUtility.printLog("Fetching Profile Posts Success");
      } else {
        _isPostLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Fetching Profile Posts Error");
      }
    } on SocketException {
      _isPostLoading.value = false;
      update();
      AppUtility.printLog("Fetching Profile Posts Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isPostLoading.value = false;
      update();
      AppUtility.printLog("Fetching Profile Posts Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isPostLoading.value = false;
      update();
      AppUtility.printLog("Fetching Profile Posts Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isPostLoading.value = false;
      update();
      AppUtility.printLog("Fetching Profile Posts Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMoreUserPosts({int? page}) async {
    AppUtility.printLog("Fetching More Profile Posts Request");
    _isMorePostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _userDetails.value.user!.id,
        page: page,
        limit: 12,
      );
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        _isMorePostLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Profile Posts Success");
      } else {
        _isMorePostLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Profile Posts Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMorePostLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Profile Posts Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMorePostLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Profile Posts Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMorePostLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Profile Posts Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMorePostLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Profile Posts Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleFollowUser(UserDetails user) {
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
        user.followersCount++;
        update();
        profile.fetchProfileDetails(fetchPost: false);
        return;
      } else {
        user.followingStatus = "notFollowing";
        user.followersCount--;
        update();
        profile.fetchProfileDetails(fetchPost: false);
        return;
      }
    }
  }

  Future<void> _followUnfollowUser(UserDetails user) async {
    AppUtility.printLog("Follow/Unfollow User Request");
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.followUnfollowUser(_auth.token, user.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
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

  Future<void> _cancelFollowRequest(UserDetails user) async {
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

  Future<void> fetchUserDetailsById() async => await _fetchUserDetailsById();

  Future<void> fetchUserDetailsByUsername() async =>
      await _fetchUserDetailsByUsername();

  Future<void> fetchUserPosts() async => await _fetchUserPosts();

  Future<void> loadMoreUserPosts() async =>
      await _loadMoreUserPosts(page: _postData.value.currentPage! + 1);

  Future<void> followUnfollowUser(UserDetails user) async =>
      await _followUnfollowUser(user);

  Future<void> cancelFollowRequest(UserDetails user) async =>
      await _cancelFollowRequest(user);
}
