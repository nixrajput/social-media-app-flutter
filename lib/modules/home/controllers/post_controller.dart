import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(dio.Dio());

  @override
  void onInit() {
    _fetchAllPosts();
    super.onInit();
  }

  final _isLoading = false.obs;
  final _postData = PostResponse().obs;

  bool get isLoading => _isLoading.value;

  PostResponse get postData => _postData.value;

  set setPostData(PostResponse value) {
    _postData.value = value;
  }

  Future<void> _fetchAllPosts() async {
    _isLoading.value = true;
    update();

    await _apiProvider
        .fetchAllPosts('application/json', 'Bearer ${_auth.token}')
        .then((data) {
      setPostData = data;
      _isLoading.value = false;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _isLoading.value = false;
          update();
          AppUtils.showSnackBar(
            res!.statusMessage.toString(),
            StringValues.error,
          );
          debugPrint("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });
  }

  void _toggleLike(postId) {
    var postIndex =
        _postData.value.posts!.indexWhere((element) => element.id == postId);
    var tempPost = _postData.value.posts!.elementAt(postIndex);

    if (tempPost.likes.contains(_auth.userData.user!.id)) {
      tempPost.likes.remove(_auth.userData.user!.id);
    } else {
      tempPost.likes.add(_auth.userData.user!.id);
    }
    update();
  }

  Future<void> _toggleLikePost(String postId) async {
    _toggleLike(postId);

    await _apiProvider
        .likeUnlikePost('application/json', 'Bearer ${_auth.token}', postId)
        .then((data) {
      AppUtils.showSnackBar(
        data.message!,
        StringValues.success,
      );
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _toggleLike(postId);
          AppUtils.showSnackBar(
            res!.statusMessage.toString(),
            StringValues.error,
          );
          debugPrint("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });

    // try {
    //   final response = await http.get(
    //     Uri.parse(
    //       '${AppUrls.baseUrl}${AppUrls.likePostEndpoint}/$postId',
    //     ),
    //     headers: {
    //       'content-type': 'application/json',
    //       'authorization': 'Bearer ${_auth.token}',
    //     },
    //   );
    //
    //   final data = jsonDecode(response.body);
    //
    //   if (response.statusCode == 200) {
    //     AppUtils.showSnackBar(
    //       data[StringValues.message],
    //       StringValues.success,
    //     );
    //   } else {
    //     _toggleLike(postId);
    //     AppUtils.showSnackBar(
    //       data[StringValues.message],
    //       StringValues.error,
    //     );
    //   }
    // } catch (err) {
    //   _toggleLike(postId);
    //   debugPrint(err.toString());
    //   AppUtils.showSnackBar(
    //     '${StringValues.errorOccurred}: ${err.toString()}',
    //     StringValues.error,
    //   );
    // }
  }

  Future<void> fetchAllPosts() async => await _fetchAllPosts();

  Future<void> toggleLikePost(String postId) async =>
      await _toggleLikePost(postId);
}
