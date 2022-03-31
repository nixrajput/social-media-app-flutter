import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

  bool get isLoading => _isLoading.value;

  PostResponse? get postData => _postData.value;

  set setPostData(PostResponse value) {
    _postData.value = value;
  }

  @override
  void onInit() {
    _fetchAllPosts();
    super.onInit();
  }

  Future<void> _fetchAllPosts() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.fetchAllPosts(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
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
    } catch (err) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(err);
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  void _toggleLike(postId) {
    var postIndex =
        _postData.value.posts!.indexWhere((element) => element.id == postId);
    var tempPost = _postData.value.posts!.elementAt(postIndex);

    if (tempPost.likes.contains(_auth.profileData.user!.id)) {
      tempPost.likes.remove(_auth.profileData.user!.id);
    } else {
      tempPost.likes.add(_auth.profileData.user!.id);
    }
    update();
  }

  Future<void> _toggleLikePost(String postId) async {
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
    } catch (err) {
      _toggleLike(postId);
      AppUtils.printLog(err);
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> fetchAllPosts() async => await _fetchAllPosts();

  Future<void> toggleLikePost(String postId) async =>
      await _toggleLikePost(postId);
}
