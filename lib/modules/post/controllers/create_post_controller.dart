import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
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

  final _pickedFileList = RxList<File>();
  final _isLoading = false.obs;

  List<File>? get pickedFileList => _pickedFileList;

  bool get isLoading => _isLoading.value;

  var cloudName =
      const String.fromEnvironment('CLOUDINARY_CLOUD_NAME', defaultValue: '');
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: '');

  Future<void> _createNewPost() async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
    var mediaFiles = <Object>[];

    for (var file in _pickedFileList) {
      var filePath = file.path;
      var sizeInKb = file.sizeToKb();
      if (AppUtils.isVideoFile(filePath)) {
        if (sizeInKb > 30 * 1024) {
          AppUtils.showSnackBar(
            'Video file size must be lower than 30 MB',
            StringValues.warning,
          );
          return;
        }
      } else {
        if (sizeInKb > 2048) {
          AppUtils.showSnackBar(
            'Image file size must be lower than 2 MB',
            StringValues.warning,
          );
          return;
        }
      }
    }

    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    for (var file in _pickedFileList) {
      if (AppUtils.isVideoFile(file.path)) {
        await cloudinary
            .unsignedUpload(
          uploadPreset: uploadPreset,
          file: file.path,
          resourceType: CloudinaryResourceType.video,
          folder: "social_media_api/posts/videos",
          progressCallback: (count, total) {
            var progress = ((count / total) * 100).toStringAsFixed(2);
            AppUtils.printLog('Uploading : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "mediaType": "video"
          });
        }).catchError((err) {
          AppUtils.printLog(err);
          AppUtils.showSnackBar('Video upload failed.', StringValues.error);
        });
      } else {
        await cloudinary
            .unsignedUpload(
          uploadPreset: uploadPreset,
          file: file.path,
          resourceType: CloudinaryResourceType.image,
          folder: "social_media_api/posts/images",
          progressCallback: (count, total) {
            var progress = ((count / total) * 100).toStringAsFixed(2);
            AppUtils.printLog('Uploading : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "mediaType": "image"
          });
        }).catchError((err) {
          AppUtils.printLog(err);
          AppUtils.showSnackBar('image upload failed.', StringValues.error);
        });
      }
    }

    try {
      final body = {
        "caption": captionTextController.text,
        "mediaFiles": mediaFiles,
      };

      final response = await _apiProvider.createPost(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        captionTextController.clear();
        await _postController.fetchPosts();
        _isLoading.value = false;
        update();
        AppUtils.closeDialog();
        RouteManagement.goToBack();
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
    _pickedFileList.value = await AppUtils.selectMultipleFiles();
    update();
    if (_pickedFileList.isNotEmpty) {
      RouteManagement.goToCreatePostView();
    }
  }

  Future<void> removePostImage(int index) async {
    if (_pickedFileList.isNotEmpty) {
      _pickedFileList.removeAt(index);
      update();
    }
  }

  Future<void> createNewPost() async {
    if (_pickedFileList.isNotEmpty) {
      await _createNewPost();
    } else {
      _pickedFileList.value = await AppUtils.selectMultipleFiles();
      update();
    }
  }
}
