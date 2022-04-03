import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _postData = PostResponse().obs;
  final _postList = RxList<Post>();

  bool get isLoading => _isLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  set setPostListData(List<Post> data) => _postList.value = data;

  set setPostData(PostResponse value) => _postData.value = value;

  @override
  void onInit() {
    _fetchAllPosts();
    super.onInit();
  }

  Future<void> _fetchAllPosts() async {
    AppUtils.printLog("Fetching Posts Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.fetchAllPosts(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        setPostListData = _postData.value.posts!;
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleLike(postId) {
    var postIndex = _postList.indexWhere((element) => element.id == postId);
    var tempPost = _postList.elementAt(postIndex);

    if (tempPost.likes.contains(_auth.profileData.user!.id)) {
      tempPost.likes.remove(_auth.profileData.user!.id);
    } else {
      tempPost.likes.add(_auth.profileData.user!.id);
    }
    update();
  }

  Future<void> _toggleLikePost(String postId) async {
    AppUtils.printLog("Like/Unlike Post Request...");

    _toggleLike(postId);

    try {
      final response = await _apiProvider.likeUnlikePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        _toggleLike(postId);
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleLike(postId);
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleLike(postId);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleLike(postId);
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleLike(postId);
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _getTempPostFromList(postId) {
    var postIndex = _postList.indexWhere((element) => element.id == postId);
    var tempPost = _postList.elementAt(postIndex);

    if (_postList.contains(tempPost)) {
      _postList.remove(tempPost);
      _postList.refresh();
    } else {
      _postList.insert(postIndex, tempPost);
      _postList.refresh();
    }
    update();
  }

  Future<void> _deletePost(String postId) async {
    AppUtils.printLog("Post Delete Request...");

    _getTempPostFromList(postId);

    // try {
    //   final response = await _apiProvider.deletePost(_auth.token, postId);
    //
    //   final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
    //
    //   final apiResponse = CommonResponse.fromJson(decodedData);
    //
    //   if (response.statusCode == 200) {
    //     AppUtils.showSnackBar(
    //       apiResponse.message!,
    //       StringValues.success,
    //     );
    //   } else {
    //     _getTempPostFromList(postId);
    //     AppUtils.showSnackBar(
    //       apiResponse.message!,
    //       StringValues.error,
    //     );
    //   }
    // } on SocketException {
    //   _getTempPostFromList(postId);
    //   AppUtils.printLog(StringValues.internetConnError);
    //   AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    // } on TimeoutException {
    //   _getTempPostFromList(postId);
    //   AppUtils.printLog(StringValues.connTimedOut);
    //   AppUtils.printLog(StringValues.connTimedOut);
    //   AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    // } on FormatException catch (e) {
    //   _getTempPostFromList(postId);
    //   AppUtils.printLog(StringValues.formatExcError);
    //   AppUtils.printLog(e);
    //   AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    // } catch (exc) {
    //   _getTempPostFromList(postId);
    //   AppUtils.printLog(StringValues.errorOccurred);
    //   AppUtils.printLog(exc);
    //   AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    // }
  }

  Future<void> fetchAllPosts() async => await _fetchAllPosts();

  Future<void> toggleLikePost(String postId) async =>
      await _toggleLikePost(postId);

  Future<void> deletePost(String postId) async => await _deletePost(postId);
}
