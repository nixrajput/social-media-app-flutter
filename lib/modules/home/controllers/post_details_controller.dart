import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_details_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class PostDetailsController extends GetxController {
  static PostDetailsController get find => Get.find();

  final _auth = AuthController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _postDetails = PostDetailsResponse().obs;

  bool get isLoading => _isLoading.value;

  PostDetailsResponse? get postDetails => _postDetails.value;

  set setPostDetails(PostDetailsResponse value) => _postDetails.value = value;

  Future<void> _fetchPostDetails() async {
    var postId = Get.arguments;

    if (postId == '' || postId == null) {
      return;
    }

    AppUtils.printLog("Fetching Posts Details Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.fetchPostDetails(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostDetails = PostDetailsResponse.fromJson(decodedData);
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

  void _toggleLike() {
    var tempPost = _postDetails.value.post!;

    if (tempPost.likes.contains(_auth.profileData.user!.id)) {
      tempPost.likes.remove(_auth.profileData.user!.id);
    } else {
      tempPost.likes.add(_auth.profileData.user!.id);
    }
    update();
  }

  Future<void> _toggleLikePost() async {
    AppUtils.printLog("Like/Unlike Post Request...");

    _toggleLike();

    try {
      final response = await _apiProvider.likeUnlikePost(
          _auth.token, _postDetails.value.post!.id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        _toggleLike();
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleLike();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleLike();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleLike();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleLike();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    AppUtils.printLog("Post Delete Request...");

    // var postIndex = _postList.indexWhere((element) => element.id == postId);
    // var post = _postList.elementAt(postIndex);
    //
    // if (postIndex > -1) {
    //   _postList.remove(post);
    //   _postList.refresh();
    //   update();
    // }

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        // _postList.insert(postIndex, post);
        // _postList.refresh();
        update();
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      // _postList.insert(postIndex, post);
      // _postList.refresh();
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      // _postList.insert(postIndex, post);
      // _postList.refresh();
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      // _postList.insert(postIndex, post);
      // _postList.refresh();
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      // _postList.insert(postIndex, post);
      // _postList.refresh();
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPostDetails() async => await _fetchPostDetails();

  Future<void> toggleLikePost() async => await _toggleLikePost();

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  @override
  void onInit() {
    _fetchPostDetails();
    super.onInit();
  }
}
