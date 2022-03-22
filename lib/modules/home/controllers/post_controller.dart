import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';

class PostController extends GetxController {
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

  Future<void> _fetchAllPosts() async {
    _isLoading.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse(AppUrls.baseUrl + AppUrls.getAllPostsEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
          'authorization': 'Bearer ${_auth.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _postModel.value = PostModel.fromJson(data);
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

  Future<void> fetchAllPosts() async => await _fetchAllPosts();
}
