import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class TrendingPostController extends GetxController {
  static TrendingPostController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postData = PostResponse().obs;

  final searchTextController = TextEditingController();

  final List<Post> _postList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  set setPostData(PostResponse value) => _postData.value = value;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  _getData() async {
    await _fetchTrendingPosts();
  }

  Future<void> _fetchTrendingPosts({int? page}) async {
    AppUtility.printLog("Fetching Trending Posts Request");
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getTrendingPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Fetching Trending Posts Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Fetching Trending Posts Error");
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Trending Posts Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Trending Posts Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Trending Posts Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Trending Posts Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Trending Posts Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getTrendingPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Trending Posts Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Trending Posts Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Trending Posts Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Trending Posts Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Trending Posts Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Trending Posts Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    AppUtility.printLog("Post Delete Request");

    var isPostPresent = _postList.any((element) => element.id == postId);

    if (isPostPresent == true) {
      var postIndex = _postList.indexWhere((element) => element.id == postId);
      var post = _postList.elementAt(postIndex);
      _postList.remove(post);
      update();
    }

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
        AppUtility.printLog("Post Delete Success");
      } else {
        update();
        AppUtility.printLog("Post Delete Error");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      update();
      AppUtility.printLog("Post Delete Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      update();
      AppUtility.printLog("Post Delete Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      update();
      AppUtility.printLog("Post Delete Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      update();
      AppUtility.printLog("Post Delete Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleLike(Post post) {
    if (post.isLiked) {
      post.isLiked = false;
      post.likesCount--;
      update();
      return;
    } else {
      post.isLiked = true;
      post.likesCount++;
      update();
      return;
    }
  }

  Future<void> _toggleLikePost(Post post) async {
    AppUtility.printLog("Like/Unlike Post Request...");

    _toggleLike(post);

    try {
      final response = await _apiProvider.likeUnlikePost(_auth.token, post.id!);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.printLog(apiResponse.message!);
      } else {
        _toggleLike(post);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleLike(post);
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleLike(post);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleLike(post);
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleLike(post);
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _searchPosts(String searchText) async {
    if (searchText.isEmpty) {
      await _fetchTrendingPosts();
      return;
    }

    AppUtility.printLog("Search Users Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.searchPosts(_auth.token, searchText);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Search Posts Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Search Posts Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Posts Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Posts Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Posts Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Search Posts Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPosts() async => await _fetchTrendingPosts();

  Future<void> searchPosts(String searchText) async =>
      await _searchPosts(searchText);

  Future<void> loadMore() async =>
      await _loadMore(page: _postData.value.currentPage! + 1);

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);
}
