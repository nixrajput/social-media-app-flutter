import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_details_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class PostDetailsController extends GetxController {
  static PostDetailsController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _postDetailsData = const PostDetailsResponse().obs;
  final _postId = ''.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  PostDetailsResponse? get postDetailsData => _postDetailsData.value;

  String? get postId => _postId.value;

  /// Setters
  set setPostDetailsData(PostDetailsResponse response) {
    _postDetailsData.value = response;
  }

  Future<void> _fetchPostDetails() async {
    AppUtility.printLog("Fetch Post Details Request");

    if (postId == '' || postId == null) return;

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getPostDetails(_auth.token, postId!);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostDetailsData = PostDetailsResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Fetch Post Details Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Fetch Post Details Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetch Post Details Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetch Post Details Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetch Post Details Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetch Post Details Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    AppUtility.printLog("Post Delete Request");

    RouteManagement.goToBack();

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.printLog("Post Delete Success");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
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

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);

  Future<void> fetchPostDetails() async => await _fetchPostDetails();

  @override
  void onInit() {
    super.onInit();

    String? postId = Get.arguments[0];
    Post? post = Get.arguments[1];
    if (post != null) {
      setPostDetailsData = PostDetailsResponse(success: true, post: post);
      update();
    }

    if (post == null && postId != null) {
      _postId.value = postId;
      _fetchPostDetails();
    }
  }
}
