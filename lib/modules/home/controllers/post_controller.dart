import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthController.find;

  @override
  void onInit() {
    _fetchAllPosts();
    super.onInit();
  }

  final _isLoading = false.obs;
  final _postModel = PostModel().obs;

  bool get isLoading => _isLoading.value;

  PostModel get postModel => _postModel.value;

  set setPostModel(PostModel model) {
    _postModel.value = model;
  }

  Future<void> _fetchAllPosts() async {
    _isLoading.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse(AppUrls.baseUrl + AppUrls.getAllPostsEndpoint),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer ${_auth.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setPostModel = PostModel.fromJson(data);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  void _toggleLike(postId) {
    var postIndex =
        _postModel.value.posts!.indexWhere((element) => element.id == postId);
    var tempPost = _postModel.value.posts!.elementAt(postIndex);

    if (tempPost.likes!.contains(_auth.userModel.user!.id)) {
      tempPost.likes!.remove(_auth.userModel.user!.id);
    } else {
      tempPost.likes!.add(_auth.userModel.user!.id);
    }
    update();
  }

  Future<void> _toggleLikePost(String postId) async {
    _toggleLike(postId);
    try {
      final response = await http.get(
        Uri.parse(
          '${AppUrls.baseUrl}${AppUrls.likePostEndpoint}/$postId',
        ),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer ${_auth.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.success,
        );
      } else {
        _toggleLike(postId);
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _toggleLike(postId);
      debugPrint(err.toString());
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
