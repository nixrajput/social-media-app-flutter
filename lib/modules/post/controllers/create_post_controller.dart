import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class CreatePostController extends GetxController {
  static CreatePostController get find => Get.find();

  final _auth = AuthController.find;
  final _postController = PostController.find;
  final _apiProvider = ApiProvider(http.Client());

  final captionTextController = TextEditingController();

  final _pickedImageList = RxList<File>();
  final _isLoading = false.obs;

  List<File>? get pickedImageList => _pickedImageList;

  bool get isLoading => _isLoading.value;

  Future<void> _createNewPost() async {
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      var imageList = <http.MultipartFile>[];
      for (var pickedImage in _pickedImageList) {
        final fileStream = http.ByteStream(pickedImage.openRead());
        final fileLength = await pickedImage.length();
        final multiPartFile = http.MultipartFile(
          "images",
          fileStream,
          fileLength,
          filename: pickedImage.path,
        );

        imageList.add(multiPartFile);
      }

      final response = await _apiProvider.createPost(
        _auth.token,
        captionTextController.text,
        imageList,
      );

      final responseDataFromStream = await http.Response.fromStream(response);
      final decodedData =
          jsonDecode(utf8.decode(responseDataFromStream.bodyBytes));

      if (response.statusCode == 201) {
        captionTextController.clear();
        await _postController.fetchAllPosts();
        _isLoading.value = false;
        update();
        AppUtils.closeDialog();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(err);
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> createNewPost() async {
    _pickedImageList.value = await AppUtils.selectMultipleImage();

    if (_pickedImageList.isNotEmpty) {
      await _createNewPost();
    }
  }
}
