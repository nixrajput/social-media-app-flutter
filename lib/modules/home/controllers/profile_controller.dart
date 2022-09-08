import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
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
  final _isPostLoading = false.obs;
  final _isMorePostLoading = false.obs;
  ProfileResponse _profileDetails = const ProfileResponse();
  final _postData = const PostResponse().obs;
  final List<Post> _postList = [];

  /// Getters
  bool get isLoading => _isLoading;

  bool get isPostLoading => _isPostLoading.value;

  bool get isMorePostLoading => _isMorePostLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  ProfileResponse get profileDetails => _profileDetails;

  /// Setters
  set setPostData(PostResponse value) => _postData.value = value;

  set setProfileDetailsData(ProfileResponse value) => _profileDetails = value;

  Future<bool> _loadProfileDetails() async {
    AppUtils.printLog("Loading Profile Details From Local Storage Request");

    final decodedData = await AppUtils.readProfileDataFromLocalStorage();

    if (decodedData != null) {
      setProfileDetailsData = ProfileResponse.fromJson(decodedData);

      final decodedPostData =
          await AppUtils.readProfilePostDataFromLocalStorage();
      if (decodedPostData != null) {
        setPostData = PostResponse.fromJson(decodedPostData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        AppUtils.printLog("Loading Profile Details From Local Storage Success");
        return true;
      } else {
        AppUtils.printLog("Profile Post Data Not Found");
      }
    } else {
      AppUtils.printLog("Loading Profile Details From Local Storage Error");
      AppUtils.printLog(StringValues.profileDetailsNotFound);
    }
    return false;
  }

  Future<void> _fetchProfileDetails({bool fetchPost = true}) async {
    _isLoading = true;
    update();
    AppUtils.printLog("Fetching Profile Details Request");
    try {
      final response = await _apiProvider.getProfileDetails(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setProfileDetailsData = ProfileResponse.fromJson(decodedData);
        await AppUtils.saveProfileDataToLocalStorage(decodedData);
        _isLoading = false;
        update();
        AppUtils.printLog("Fetching Profile Details Success");
        if (fetchPost) await _fetchPosts();
      } else {
        _isLoading = false;
        update();
        AppUtils.printLog("Fetching Profile Details Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading = false;
      update();
      AppUtils.printLog("Fetching Profile Details Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading = false;
      update();
      AppUtils.printLog("Fetching Profile Details Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading = false;
      update();
      AppUtils.printLog("Fetching Profile Details Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e.toString());
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading = false;
      update();
      AppUtils.printLog("Fetching Profile Details Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc.toString());
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleFollowUser(User user) {
    if (user.accountPrivacy == "private") {
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
    AppUtils.printLog("Follow/Unfollow User Request");
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.followUnfollowUser(_auth.token, user.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _fetchProfileDetails(fetchPost: false);
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        AppUtils.printLog("Follow/Unfollow User Success");
      } else {
        _toggleFollowUser(user);
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtils.printLog("Follow/Unfollow User Error");
      }
    } on SocketException {
      _toggleFollowUser(user);
      AppUtils.printLog("Follow/Unfollow User Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(user);
      AppUtils.printLog("Follow/Unfollow User Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(user);
      AppUtils.printLog("Follow/Unfollow User Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtils.printLog("Follow/Unfollow User Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _cancelFollowRequest(User user) async {
    AppUtils.printLog("Cancel Follow Request");
    _toggleFollowUser(user);

    try {
      final response =
          await _apiProvider.cancelFollowRequest(_auth.token, user.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        AppUtils.printLog("Cancel Follow Success");
      } else {
        _toggleFollowUser(user);
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtils.printLog("Cancel Follow Error");
      }
    } on SocketException {
      _toggleFollowUser(user);
      AppUtils.printLog("Cancel Follow Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleFollowUser(user);
      AppUtils.printLog("Cancel Follow Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleFollowUser(user);
      AppUtils.printLog("Cancel Follow Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleFollowUser(user);
      AppUtils.printLog("Cancel Follow Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _fetchPosts({int? page}) async {
    AppUtils.printLog("Fetching Profile Posts Request");
    _isPostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _profileDetails.user!.id,
        page: page,
        limit: 12,
      );
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        await AppUtils.deleteProfilePostDataFromLocalStorage();
        await AppUtils.saveProfilePostDataToLocalStorage(decodedData);
        _isPostLoading.value = false;
        update();
        AppUtils.printLog("Fetching Profile Posts Success");
      } else {
        _isPostLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtils.printLog("Fetching Profile Posts Error");
      }
    } on SocketException {
      _isPostLoading.value = false;
      update();
      AppUtils.printLog("Fetching Profile Posts Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isPostLoading.value = false;
      update();
      AppUtils.printLog("Fetching Profile Posts Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isPostLoading.value = false;
      update();
      AppUtils.printLog("Fetching Profile Posts Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isPostLoading.value = false;
      update();
      AppUtils.printLog("Fetching Profile Posts Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtils.printLog("Fetching More Profile Posts Request");
    _isMorePostLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUserPosts(
        _auth.token,
        _profileDetails.user!.id,
        page: page,
        limit: 12,
      );
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        _isMorePostLoading.value = false;
        update();
        AppUtils.printLog("Fetching More Profile Posts Success");
      } else {
        _isMorePostLoading.value = false;
        update();
        AppUtils.printLog("Fetching More Profile Posts Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMorePostLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Profile Posts Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMorePostLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Profile Posts Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMorePostLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Profile Posts Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMorePostLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Profile Posts Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
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
      await _loadMore(page: _postData.value.currentPage! + 1);
}
