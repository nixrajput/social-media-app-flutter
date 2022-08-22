import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class CreatePostController extends GetxController {
  static CreatePostController get find => Get.find();

  final _auth = AuthService.find;
  final _postController = PostController.find;
  final _apiProvider = ApiProvider(http.Client());

  final captionTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

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
          "mediaFiles",
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
        await _postController.fetchPosts();
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
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> selectPostImages() async {
    _pickedImageList.value = await AppUtils.selectMultipleFiles();
    update();
    if (_pickedImageList.isNotEmpty) {
      RouteManagement.goToCreatePostView();
    }
  }

  Future<void> removePostImage(int index) async {
    if (_pickedImageList.isNotEmpty) {
      _pickedImageList.removeAt(index);
      update();
    }
  }

  Future<void> createNewPost() async {
    if (_pickedImageList.isNotEmpty) {
      await _createNewPost();
    } else {
      _pickedImageList.value = await AppUtils.selectMultipleFiles();
      update();
    }
  }
}
