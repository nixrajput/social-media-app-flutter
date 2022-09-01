import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post_like_details.dart';
import 'package:social_media_app/apis/models/responses/post_like_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class PostLikedUsersController extends GetxController {
  static PostLikedUsersController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postLikedUsersData = const PostLikeResponse().obs;
  final List<PostLikeDetails> _postLikedUsersList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  PostLikeResponse get postLikedUsersData => _postLikedUsersData.value;

  List<PostLikeDetails> get postLikedUsersList => _postLikedUsersList;

  set setPostLikedUsersData(PostLikeResponse response) {
    _postLikedUsersData.value = response;
  }

  Future<void> _fetchPostLikedUsers() async {
    AppUtils.printLog("Fetch Post Liked Users Request");

    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getPostLikedUsers(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostLikedUsersData = PostLikeResponse.fromJson(decodedData);
        _postLikedUsersList.clear();
        _postLikedUsersList.addAll(_postLikedUsersData.value.results!);
        _isLoading.value = false;
        update();
        AppUtils.printLog("Fetch Post Liked Users Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtils.printLog("Fetch Post Liked Users Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Post Liked Users Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Post Liked Users Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Post Liked Users Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Post Liked Users Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtils.printLog("Fetch More Post Liked Users Request");

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

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostLikedUsersData = PostLikeResponse.fromJson(decodedData);
        _postLikedUsersList.addAll(_postLikedUsersData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetch More Post Liked Users Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetch More Post Liked Users Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Post Liked Users Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Post Liked Users Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Post Liked Users Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Post Liked Users Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPostLikedUsers() async => await _fetchPostLikedUsers();

  Future<void> loadMore() async =>
      await _loadMore(page: _postLikedUsersData.value.currentPage! + 1);

  @override
  void onInit() {
    super.onInit();
    _fetchPostLikedUsers();
  }
}