import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postData = const PostResponse().obs;

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
    await _fetchPosts();
    await Future.delayed(const Duration(seconds: 5), () async {
      await LoginDeviceInfoController.find.getLoginDeviceInfo();
    });
  }

  Future<void> _fetchPosts({int? page}) async {
    AppUtils.printLog("Fetching Posts Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        _isLoading.value = false;
        update();
        AppUtils.printLog("Fetching Posts Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtils.printLog("Fetching Posts Error");
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetching Posts Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetching Posts Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetching Posts Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetching Posts Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtils.printLog("Fetching More Posts Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetching More Posts Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetching More Posts Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Posts Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Posts Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Posts Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetching More Posts Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    AppUtils.printLog("Post Delete Request");

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
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
        AppUtils.printLog("Post Delete Success");
      } else {
        //_postList.insert(postIndex, post);
        update();
        AppUtils.printLog("Post Delete Error");
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      //_postList.insert(postIndex, post);
      update();
      AppUtils.printLog("Post Delete Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      //_postList.insert(postIndex, post);
      update();
      AppUtils.printLog("Post Delete Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      //_postList.insert(postIndex, post);
      update();
      AppUtils.printLog("Post Delete Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      //_postList.insert(postIndex, post);
      update();
      AppUtils.printLog("Post Delete Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
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
    AppUtils.printLog("Like/Unlike Post Request...");

    _toggleLike(post);

    try {
      final response = await _apiProvider.likeUnlikePost(_auth.token, post.id!);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtils.printLog(apiResponse.message!);
      } else {
        _toggleLike(post);
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleLike(post);
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleLike(post);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleLike(post);
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleLike(post);
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPosts() async => await _fetchPosts();

  Future<void> loadMore() async =>
      await _loadMore(page: _postData.value.currentPage! + 1);

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);
}
